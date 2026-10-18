# Usage: perl scripts/anchor-variants.pl .                 apply scripts/anchor-variants.txt
#        perl scripts/anchor-variants.pl . dry             same, but only print what would change
#        perl scripts/anchor-variants.pl . report /path/   inbound in-body links and anchor texts per target
# Rerunnable: "vary" re-picks from the whole set; "add" cards carry data-al and are removed before re-adding.
use strict; use warnings; use File::Find; use Digest::MD5 'md5';
my($R,$mode,@T)=@ARGV; $mode//='apply'; my %P;
find(sub{ return unless $_ eq 'index.html'; my $d=$File::Find::dir; return if $d=~/\.git|_build/;
  (my $rel=$d)=~s/^\Q$R\E//; $rel="$rel/"; $rel=~s#//#/#g; local $/; open my $f,'<:raw',$_; $P{$rel}=<$f>; },$R);
sub norm{ my($base,$h)=@_; if($h=~m#^https?://#){ return undef unless $h=~s#^https?://abschleppdienst-faster\.de##; $h||='/'; }
  elsif($h!~m#^/#){ $h=$base.$h; } 1 while $h=~s#/\./#/#; 1 while $h=~s#/[^/]+/\.\./#/#; $h.='/' unless $h=~m#/$#; $h }
sub rel{ my($from,$to)=@_; my $d=()=$from=~m#[^/]+/#g; ($d? '../'x$d : './').substr($to,1) }

if($mode eq 'report'){
  for my $t(@T){ my(%a,%from,$n);
    for my $p(sort keys %P){ next if $p eq $t; my($main)=$P{$p}=~m#<main>(.*)</main>#s or next;
      while($main=~m#<a [^>]*href="([^"\#?]+)"[^>]*>(.*?)</a>#gs){ my($h,$x)=($1,$2); my $u=norm($p,$h); next unless defined $u && $u eq $t;
        $x=~s/<small>.*//s; $x=~s/<[^>]+>//g; $x=~s/\s+/ /g; $x=~s/^ | $//g; $n++; $a{$x}++; $from{$p}=1 } }
    printf "## %s  in-body links=%d from %d pages\n",$t,$n//0,scalar keys %from; printf "   %3d  %s\n",$a{$_},$_ for sort{$a{$b}<=>$a{$a}}keys %a }
  exit }

my(@vary,@add); open my $c,'<:raw',"$R/scripts/anchor-variants.txt" or die $!;
while(<$c>){ s/\r?\n$//; next if /^\s*(#|$)/; my @f=split /\t/;
  if($f[0] eq 'vary'){ push @vary,[$f[1],[split /\|/,$f[2]]] } elsif($f[0] eq 'add'){ push @add,[@f[1..4]] } }
my(%changed,$nv,$na);
for my $p(sort keys %P){ next if $p=~m#^/en/#; my $h=$P{$p}; my $orig=$h;
  $h=~s#<a data-al href="[^"]*">.*?</a>##gs;   # rerunnable
  my($pre,$main,$post)=$h=~m#^(.*?<main>)(.*)(</main>.*)$#s or next;
  for my $v(@vary){ my($t,$set)=@$v; next if $p eq $t; my %in=map{(my $m=$_)=~s#^~##; $m=>1}@$set; my @pick=grep{!/^~/}@$set; my $i=0;
    $main=~s{(<a [^>]*href="([^"\#?]+)"[^>]*>)([^<]+?)(<small>|</a>)}{
      my($o,$href,$x,$e)=($1,$2,$3,$4); my $u=norm($p,$href);
      if(defined $u && $u eq $t && $in{$x}){ my $k=unpack('N',md5("$p#".$i++)) % @pick; my $y=$pick[$k]; $nv++ if $y ne $x; "$o$y$e" } else { "$o$x$e" } }ge; }
  for my $a(@add){ my($s,$t,$label,$small)=@$a; next unless $s eq $p;
    my $r=rel($p,$t); if($main=~/href="\Q$r\E"/){ next }
    # topical related block = last class="related" outside the local-links block
    my $tmp=$main; $tmp=~s{(<!-- local-links:start -->.*?<!-- local-links:end -->)}{'#' x length $1}se;
    my $pos=-1; while($tmp=~/<div class="related">/g){ $pos=pos($tmp) } if($pos<0){ warn "no related block on $p\n"; next }
    substr($main,$pos,0)=qq{<a data-al href="$r">$label<small>$small</small></a>}; $na++; }
  $h=$pre.$main.$post; if($h ne $orig){ $changed{$p}=1; unless($mode eq 'dry'){ (my $f="$R$p")=~s#/$#/index.html#; open my $o,'>:raw',$f or die "$f: $!"; print $o $h } } }
printf "%s: %d pages, %d anchors varied, %d cards added\n",($mode eq 'dry'?'dry run':'written'),scalar keys %changed,$nv//0,$na//0;
