# Usage: perl scripts/faq-schema.pl page/index.html [...]
# Rebuilds the FAQPage JSON-LD of each page from its visible <details> FAQs (only pages that already have one).
use strict; use warnings;
sub plain{ my $s=shift; $s=~s/<[^>]+>//g; $s=~s/&nbsp;/ /g; $s=~s/&amp;/&/g; $s=~s/&quot;/"/g; $s=~s/&rarr;/→/g; $s=~s/&middot;/·/g; $s=~s/\s+/ /g; $s=~s/^ | $//g; $s }
sub js{ my $s=shift; $s=~s/\\/\\\\/g; $s=~s/"/\\"/g; $s }
for my $f(@ARGV){ local $/; open my $i,'<:raw',$f or die "$f: $!"; my $h=<$i>; close $i;
  my($main)=$h=~m#<main>(.*)</main>#s or die "$f: no main";
  my @q; while($main=~m#<details><summary>(.*?)</summary><div>(.*?)</div></details>#gs){ push @q,[plain($1),plain($2)] }
  my $json='{"@context":"https://schema.org","@type":"FAQPage","mainEntity":['.join(',',map{ '{"@type":"Question","name":"'.js($_->[0]).'","acceptedAnswer":{"@type":"Answer","text":"'.js($_->[1]).'"}}' }@q).']}';
  $h=~s#<script type="application/ld\+json">\{"\@context":"https://schema.org","\@type":"FAQPage".*?</script>#<script type="application/ld+json">$json</script>#s or do { warn "$f: no FAQPage block\n"; next };
  open my $o,'>:raw',$f or die; print $o $h; printf "%s: %d questions\n",$f,scalar @q }
