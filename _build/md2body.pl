use strict; use warnings; binmode(STDOUT,':raw');
use FindBin qw($Bin); my $src="$Bin/content/01-startseite.md";
open(my $f,'<:raw',$src) or die; local $/; my $t=<$f>; close $f;
$t =~ s/\r//g;
$t =~ s/^---\n.*?\n---\n//s;            # front matter
my $WA='@@WA2@@';
$t =~ s/\[MARKE\]/Faster Abschleppdienst/g;
$t =~ s/\[PREIS_AB\]/129/g;
$t =~ s/\[Per WhatsApp Standort senden\]\(\[WHATSAPP\]\)/[Per WhatsApp Standort senden]($WA)/g;
$t =~ s/\*\*\[TELEFON\]\*\*/**[+49 176 41956993](tel:+4917641956993)**/g;
$t =~ s/\[TELEFON\]/[+49 176 41956993](tel:+4917641956993)/g;
$t =~ s/\[ANFAHRT_MIN\]/<mark>[ANFAHRT_MIN, mit Partnern klären]<\/mark>/g;
$t =~ s/\[ZAHLUNGSARTEN[^\]]*\]/<mark>[Zahlungsarten mit Partnern klären, z. B. Bar, EC-Karte, Kreditkarte, Überweisung]<\/mark>/g;
# owner links (/abschleppdienst-xyz/ and /ratgeber/xyz/) point to the flat page files
$t =~ s{\]\(/ratgeber/([a-z-]+)/\)}{](ratgeber-$1.html)}g;
$t =~ s{\]\(/(abschleppdienst-[a-z0-9-]+)/\)}{]($1.html)}g;
sub esc { my $s=shift; $s =~ s/&/&amp;/g; $s =~ s/<(?!\/?mark>)/&lt;/g; $s }
sub inl { my $s=shift; $s=esc($s);
  $s =~ s/\[([^\]]+)\]\(([^)]+)\)/'<a href="'.$2.'"'.($2=~m{^https} ? ' target="_blank" rel="noopener"':'').'>'.$1.'<\/a>'/ge;
  $s =~ s/\*\*(.+?)\*\*/<strong>$1<\/strong>/g; $s }
my ($h1,$out,@list,$ltype)=('','');
sub flush { if(@list){ $out.="<$ltype>\n".join('',map{"<li>$_</li>\n"}@list)."</$ltype>\n"; @list=(); } }
for my $b (split /\n{2,}/, $t){ $b =~ s/^\n+|\n+$//g; next unless length $b;
  if($b =~ /^# (.+)$/){ $h1=inl($1); next }
  next if $b eq '---';
  my @lines = split /\n/, $b;
  while(@lines){ my $l=shift @lines;
    if($l =~ /^## (.+)$/){ flush(); $out.="<h2>".inl($1)."</h2>\n"; next }
    if($l =~ /^### (.+)$/){ flush(); $out.="<h3>".inl($1)."</h3>\n"; next }
    if($l =~ /^(?:- ✔ |- )(.+)$/){ push @list, inl($1); $ltype='ul'; next }
    if($l =~ /^\d+\. (.+)$/){ push @list, inl($1); $ltype='ol'; next }
    flush();
    $out.="<p>".inl($l)."</p>\n";
  }
  flush();
}
# FAQ block: bold question paragraph + answer paragraph -> details (enables FAQPage schema)
if ($out =~ /^(.*<h2>Häufige Fragen<\/h2>\n)(.*)$/s) {
  my ($pre,$rest)=($1,$2); my $d=''; my $tail='';
  while ($rest =~ s{^<p><strong>([^<]*\?)</strong></p>\n<p>(.*?)</p>\n}{}s) { $d .= "<details><summary>$1</summary><div>$2</div></details>\n" }
  $out = $pre.$d.$rest;
}
print qq{<!--AREAS: Karlsruhe, Ettlingen, Rastatt, Baden-Baden, Bühl, Achern, Offenburg, Kehl -->\n<section class="page-head"><div class="wrap narrow"><p class="eyebrow">Karlsruhe · Mittelbaden · Ortenau</p><h1>$h1</h1></div></section>\n<section class="section"><div class="wrap narrow copy">\n$out</div></section>\n\@\@CTA\@\@\n};
