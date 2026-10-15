# Usage: perl scripts/internal-links.pl . scripts/index-status.txt [dry]
# index-status.txt: one line per sitemap URL, "I /path/" = indexed in Search Console, "N /path/" = not indexed.
# Rerunnable: replaces the <!-- internal-links --> block on every page.
# Adds a "Weitere Einsatzgebiete" block to indexed pages, linking related unindexed pages.
use strict; use warnings; use File::Find; use utf8;
my($R,$statusfile,$dry)=@ARGV; my %P;
find(sub{ return unless $_ eq 'index.html'; my $d=$File::Find::dir; return if $d=~/\.git|_build/;
  (my $rel=$d)=~s/^\Q$R\E//; $rel="$rel/"; $rel=~s#//#/#g; local $/; open my $f,'<:raw',$_; $P{$rel}=<$f>; },$R);
my $S='<!-- internal-links:start -->'; my $E='<!-- internal-links:end -->';
s/\n?\Q$S\E.*?\Q$E\E//s for values %P;   # rerunnable
sub norm{ my($base,$h)=@_; if($h=~m#^https?://#){ return undef unless $h=~s#^https?://abschleppdienst-faster\.de##; $h||='/'; }
  elsif($h!~m#^/#){ $h=$base.$h; } 1 while $h=~s#/\./#/#; 1 while $h=~s#/[^/]+/\.\./#/#; $h.='/' unless $h=~m#/$#; $h }
my(%G,%anchor);
for my $p(keys %P){ my %s; my $body=$P{$p}; $body=~s#<footer.*##s; $body=~s#^.*?<main##s;
  while($P{$p}=~m#<a [^>]*href="([^"\#?]+)"[^>]*>(.*?)</a>#gs){ my($h,$t)=($1,$2); my $u=norm($p,$h); next unless defined $u && exists $P{$u} && $u ne $p; $s{$u}=1;
    $t=~s/<small>.*//s; $t=~s/<[^>]+>//g; $t=~s/\s+/ /g; $t=~s/^ | $//g; $anchor{$u}{$t}++ if (($p=~m#^/en/#) == ($u=~m#^/en/#)) && $t!~/Read|Lesen/ && length $t>2 && length $t<60 && $t ne 'EN' && $t ne 'DE'; }
  $G{$p}=\%s; }
my %ctx; for my $p(keys %P){ my $b=$P{$p}; $b=~s#<footer.*##s; $b=~s#^.*?<main##s; my %s; while($b=~/href="([^"#?]+)/g){ my $u=norm($p,$1); $s{$u}=1 if defined $u && exists $P{$u} } $ctx{$p}=\%s }
my %st; open my $sf,'<',$statusfile or die; while(<$sf>){ chomp; my($s,$u)=split; $st{$u}=$s }
my %land; for my $p(keys %P){ for(sort keys %{$ctx{$p}}){ if(m#^/(?:en/)?bundeslaender/([^/]+)/$#){ $land{$p}//=$1 } } }
$land{$_}//= ($_=~m#^/(en/)?(koeln|karlsruhe)/# ? ($2 eq 'koeln'?'nordrhein-westfalen':'baden-wuerttemberg') : '') for keys %P;
sub lang{ $_[0]=~m#^/en/# ? 'en':'de' } sub sec{ my($s)=$_[0]=~m#^/(?:en/)?([^/]*)#; $s }
my %fromI; for my $p(grep{($st{$_}//'') eq 'I'}keys %G){ $fromI{$_}++ for keys %{$G{$p}} }
my @I=grep{($st{$_}//'') eq 'I' && exists $P{$_} && $_!~m#/(kontakt|datenschutz|impressum|danke)/$#}keys %P;
my %cap=map{ $_ => ($_ eq '/' ? 14 : lang($_) eq 'en' ? 16 : 9) } @I;
my @N=grep{$st{$_} eq 'N' && exists $P{$_} && $_!~m#/(impressum|datenschutz|danke)/$#}keys %st;
my %add; my %newin;
# Homepage first: the Autobahn hub is linked from no indexed page's content and is unknown to Google.
push @{$add{'/'}},'/autobahnen/'; $cap{'/'}--; $newin{'/autobahnen/'}++;
for(keys %P){ $land{$_}=$1 if m#^/(?:en/)?bundeslaender/([^/]+)/$# }
# Pages linked from the body of many pages (Köln, Karlsruhe, cost guide) say nothing about relatedness.
my %bodyin; for my $p(keys %ctx){ $bodyin{$_}++ for keys %{$ctx{$p}} } my $common=0.08*keys %P;
sub geo{ $_[0]=~m#/(staedte|autobahnen|koeln|karlsruhe)/[^/]+/$# && ($bodyin{$_[0]}||0)<$common }
sub score{ my($p,$u)=@_; return -1 if lang($p) ne lang($u) || $G{$p}{$u} || $p eq $u; my $s=0;
  $s+=4 if $ctx{$u}{$p} && ($bodyin{$p}||0)<$common; my $sh=grep{geo($_) && $G{$p}{$_}}keys %{$ctx{$u}}; $s+=($sh>4?4:$sh);
  $s+=3 if $land{$u} && $land{$u} eq $land{$p}; $s+=2 if sec($u) eq sec($p) && sec($u)=~/^(autobahnen|ratgeber)$/; $s }
my %need=map{ my $n=3-($fromI{$_}||0)-($newin{$_}||0); $_=>($n<1?1:$n) } @N;
for my $round(1..3){ my $min=4;
  for my $u(sort{ $need{$b}<=>$need{$a} || $a cmp $b } @N){ next if ($newin{$u}||0)>=$need{$u}; next if $round==4 && ($fromI{$u}||0)+($newin{$u}||0)>0;
    my @c=sort{ $b->[1]<=>$a->[1] || $cap{$b->[0]}<=>$cap{$a->[0]} || $a->[0] cmp $b->[0] } grep{ $_->[1]>=$min && $cap{$_->[0]}>0 && !grep{$_ eq $u}@{$add{$_->[0]}||[]} } map{[$_,score($_,$u)]}@I;
    next unless @c; my $p=$c[0][0]; push @{$add{$p}},$u; $cap{$p}--; $newin{$u}++; } }
# Anything still without a link from an indexed page goes on the homepage.
for my $u(sort @N){ next if ($fromI{$u}||0)+($newin{$u}||0)>0; my $h=lang($u) eq 'en' ? '/en/' : '/'; next if $G{$h}{$u}; push @{$add{$h}},$u; $newin{$u}++; }
sub label{ my $u=shift; my $an=$anchor{$u}||{}; my($t)=sort{length($b)<=>length($a)} grep{ !/→|&rarr;|Read|^(Read|Lesen|Weiterlesen|Mehr|More|EN|DE)/i && length($_)<=48 } keys %$an;
  unless($t){ ($t)=$P{$u}=~m#<h1[^>]*>(.*?)</h1>#s; $t//=$u; $t=~s/<[^>]+>//g } $t }
sub small{ my $u=shift; my $en=lang($u) eq 'en'; my $s=sec($u);
  return $en?'Motorway breakdown help':'Pannenhilfe an der Strecke' if $s eq 'autobahnen' && $u=~m#/a\d#; return $en?'All motorway pages':'Alle Autobahnseiten' if $s eq 'autobahnen';
  return $en?'Breakdown guide':'Ratgeber' if $s eq 'ratgeber'; return $en?'Breakdown help and towing':'Pannenhilfe und Abschleppen' }
sub rel{ my($from,$to)=@_; my $d=()=$from=~m#[^/]+/#g; ($d? '../'x$d : './').substr($to,1) }
my $files=0; my $links=0;
for my $p(sort keys %add){ my @t=@{$add{$p}}; next unless @t; my $en=lang($p) eq 'en';
  my $allg=!grep{sec($_) ne 'ratgeber'}@t;
  my $h=$allg ? ($en?'More guides':'Mehr aus dem Ratgeber') : ($en?'More service areas':'Weitere Einsatzgebiete');
  my $html="\n$S\n<section class=\"section\"><div class=\"wrap narrow\"><h2>$h</h2><div class=\"related\">".join('',map{ '<a href="'.rel($p,$_).'">'.label($_).'<small>'.small($_).'</small></a>' }@t)."</div></div></section>\n$E";
  my $c=$P{$p}; my $pos=rindex($c,'<section class="cta">'); my $m=index($c,'</main>'); $pos=$m if $pos<0 || $pos>$m; die "no anchor in $p" if $pos<0;
  my $before=substr($c,0,$pos); $before=~s/\n$//; substr($c,0,$pos)=$before.$html."\n";
  $files++; $links+=@t; print "$p => ".join(" | ",map{label($_)}@t)."\n" if $dry;
  unless($dry){ open my $o,">:raw","$R/".($p eq '/'?'':substr($p,1))."index.html" or die; print $o $c; close $o } }
my @still=grep{ !($fromI{$_}||0) && !($newin{$_}||0) }@N;
printf "pages edited=%d links added=%d N pages now with >=1 link from indexed: %d/%d, >=3: %d\n",$files,$links,scalar(grep{($fromI{$_}||0)+($newin{$_}||0)>=1}@N),scalar@N,scalar(grep{($fromI{$_}||0)+($newin{$_}||0)>=3}@N);
print "still none: @still\n" if @still;
