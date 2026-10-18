# Usage: perl scripts/ratgeber-local-cta.pl [root]
# Adds to every guide page (/ratgeber/<x>/ and /en/ratgeber/<x>/):
#   1. a call box right under the intro (<!-- local-cta:start --> ... <!-- local-cta:end -->)
#   2. after the article: a second call box plus an "Abschleppdienst in Ihrer Nähe" block linking the
#      local service pages (<!-- local-links:start --> ... <!-- local-links:end -->)
# Rerunnable: both blocks are removed and rebuilt on every run. Phone/WhatsApp buttons use the same
# markup as the rest of the site (the visible number must stay "+49 176 41956993" for the Ads number swap).
use strict; use warnings;
my $R = shift // '.';
my $WA = 'https://wa.me/4917641956993?text=Hallo%20Faster%2C%20ich%20brauche%20Hilfe%20mit%20meinem%20Fahrzeug.';

# Headline + one line per guide; anything not listed gets the default.
my %TOP_DE = (
  'automatik-abschleppen'   => ['Automatikauto steht? Wir schicken einen Abschleppwagen.', 'Auf der Ladefläche drehen sich die Räder nicht, das Getriebe bleibt geschont. Rufen Sie an oder schicken Sie Ihren Standort per WhatsApp.'],
  'transporter-abschleppen' => ['Transporter liegengeblieben? Wir schicken einen Abschleppwagen.', 'Nennen Sie uns Gewicht, Ladung und Höhe, dann kommt das passende Fahrzeug. Rufen Sie an oder schicken Sie Ihren Standort per WhatsApp.'],
  'wohnmobil-gespann-panne' => ['Mit Wohnmobil oder Gespann liegengeblieben?', 'Sagen Sie uns Länge, Höhe und Gewicht. Dann klären wir am Telefon, welches Fahrzeug kommt und wie es weitergeht.'],
  'wildunfall'              => ['Nach dem Wildunfall nicht mehr fahrbereit?', 'Wir schicken einen Abschleppwagen und bringen Ihr Auto in die Werkstatt, die Sie uns nennen.'],
  ''                        => ['Panne? Wir schicken einen Abschleppwagen.', 'Rufen Sie an oder schicken Sie Ihren Standort per WhatsApp. Wir sind rund um die Uhr erreichbar.'],
);
my %TOP_EN = (
  'automatik-abschleppen'   => ['Automatic car stranded? We send a tow truck.', 'On a flatbed the wheels do not turn, so the gearbox is spared. Call us or send your location on WhatsApp.'],
  'transporter-abschleppen' => ['Van broken down? We send a tow truck.', 'Tell us the weight, load and height, and the right vehicle comes out. Call us or send your location on WhatsApp.'],
  'wohnmobil-gespann-panne' => ['Stuck with a motorhome or caravan?', 'Tell us the length, height and weight. We will sort out on the phone which vehicle comes and what happens next.'],
  'wildunfall'              => ['Car no longer safe to drive after hitting an animal?', 'We send a tow truck and take your car to the garage you name.'],
  ''                        => ['Broken down? We send a tow truck.', 'Call us or send your location on WhatsApp. We are reachable around the clock.'],
);
my @END_DE = ('Sie brauchen jetzt Hilfe? Ein Anruf genügt.', 'Wir klären die Lage am Telefon und schicken einen Abschleppwagen, wenn er nötig ist. Rund um die Uhr, auch am Wochenende.');
my @END_EN = ('Need help right now? One call is enough.', 'We assess the situation on the phone and send a tow truck if one is needed. Around the clock, weekends included.');

# [path, label, small text]; order as agreed: Köln first, then Karlsruhe region, then Frankfurt.
my @LOCAL_DE = (
  ['koeln/',                'Abschleppdienst Köln',        'Pannenhilfe und Abschleppen in ganz Köln'],
  ['koeln/porz/',           'Abschleppdienst Köln-Porz',   'A59, Flughafen, Wahner Heide'],
  ['koeln/kalk/',           'Abschleppdienst Köln-Kalk',   'A3, A4, Kreuz Köln-Ost'],
  ['karlsruhe/stadt/',      'Abschleppdienst Karlsruhe',   'Südtangente, Kriegsstraße, A5'],
  ['karlsruhe/offenburg/',  'Abschleppdienst Offenburg',   'Offenburg, Kehl und Ortenau'],
  ['karlsruhe/baden-baden/','Abschleppdienst Baden-Baden', 'Baden-Baden, Rastatt, B500'],
  ['karlsruhe/achern/',     'Abschleppdienst Achern',      'Achern, Bühl und Achertal'],
  ['staedte/frankfurt/',    'Abschleppdienst Frankfurt',   'Frankfurt am Main, A3, A5, A66'],
);
my @LOCAL_EN = (
  ['en/koeln/',                'Towing Service Cologne',       'Breakdown help and towing across Cologne'],
  ['en/koeln/porz/',           'Towing Service Cologne-Porz',  'A59, airport, Wahner Heide'],
  ['en/koeln/kalk/',           'Towing Service Cologne-Kalk',  'A3, A4, Cologne-East interchange'],
  ['en/karlsruhe/stadt/',      'Towing Service Karlsruhe',     'Südtangente, Kriegsstraße, A5'],
  ['en/karlsruhe/offenburg/',  'Towing Service Offenburg',     'Offenburg, Kehl and the Ortenau'],
  ['en/karlsruhe/baden-baden/','Towing Service Baden-Baden',   'Baden-Baden, Rastatt, B500'],
  ['en/karlsruhe/achern/',     'Towing Service Achern',        'Achern, Bühl and the Achertal'],
  ['en/staedte/frankfurt/',    'Towing Service Frankfurt',     'Frankfurt am Main, A3, A5, A66'],
);

sub callbox {
  my ($h, $t, $en) = @_;
  my $wa = $en ? 'Send location on WhatsApp' : 'WhatsApp mit Standort';
  my $call = $en ? 'Call now: +49 176 41956993' : 'Jetzt anrufen: +49 176 41956993';
  my $sub = $en ? '24/7 &middot; one call is enough' : '24/7 erreichbar &middot; ein Anruf genügt';
  return qq{<section class="section callbox" style="padding:18px 0 0"><div class="wrap narrow"><div style="background:#fff8d6;border:2px solid #f6c400;border-radius:8px;padding:16px 18px;display:flex;flex-wrap:wrap;gap:12px;align-items:center;justify-content:space-between"><div><strong style="font-size:20px;line-height:1.3">$h</strong><br><span>$t</span><br><small>$sub</small></div><div style="display:flex;flex-wrap:wrap;gap:10px"><a class="btn btn-y" href="tel:+4917641956993">$call</a><a class="btn btn-wa" href="$WA" target="_blank" rel="noopener">$wa</a></div></div></div></section>};
}

my ($n, $skipped) = (0, 0);
for my $lang ('de', 'en') {
  my $dir = $lang eq 'en' ? "$R/en/ratgeber" : "$R/ratgeber";
  opendir(my $dh, $dir) or die "no $dir";
  for my $slug (sort grep { !/^\./ && -f "$dir/$_/index.html" } readdir $dh) {
    my $file = "$dir/$slug/index.html";
    open(my $fh, '<:raw', $file) or die; local $/; my $c = <$fh>; close $fh;
    $c =~ s/\n?<!-- local-cta:start -->.*?<!-- local-cta:end -->//s;
    $c =~ s/\n?<!-- local-links:start -->.*?<!-- local-links:end -->//s;
    my $en = $lang eq 'en';
    my $up = $en ? '../../../' : '../../';
    my ($th, $tt) = @{ ($en ? \%TOP_EN : \%TOP_DE)->{$slug} // ($en ? \%TOP_EN : \%TOP_DE)->{''} };
    my $top = "\n<!-- local-cta:start -->\n" . callbox($th, $tt, $en) . "\n<!-- local-cta:end -->";
    my @end = $en ? @END_EN : @END_DE;
    my $links = join('', map { qq{<a href="$up$_->[0]">$_->[1]<small>$_->[2]</small></a>} } @{ $en ? \@LOCAL_EN : \@LOCAL_DE });
    my ($lh, $lp) = $en
      ? ('Towing near you', 'Pages with local roads, motorway exits and tips on describing where you are:')
      : ('Abschleppdienst in Ihrer Nähe', 'Eigene Seiten mit Straßen, Autobahnausfahrten und Hinweisen, wie Sie Ihren Standort beschreiben:');
    my $bottom = "\n<!-- local-links:start -->\n" . callbox($end[0], $end[1], $en)
      . qq{\n<section class="section"><div class="wrap narrow"><h2>$lh</h2><p>$lp</p><div class="related">$links</div></div></section>\n<!-- local-links:end -->};
    # 1. after the intro
    my $i = index($c, '<section class="page-head">');
    my $j = $i < 0 ? -1 : index($c, '</section>', $i);
    if ($j < 0) { warn "no page-head in $file\n"; $skipped++; next; }
    # no second call box when the intro already has call buttons (it stacked two boxes on Automatik/Transporter)
    substr($c, $j + length('</section>'), 0) = $top unless substr($c, $i, $j - $i) =~ /href="tel:/;
    # 2. after the article and its FAQ: before "Weiterlesen", the internal-links block or the closing CTA
    my $pos = -1;
    for my $m ('<section class="section"><div class="wrap narrow"><h2>Weiterlesen</h2>', '<section class="section"><div class="wrap narrow"><h2>Read more</h2>', '<!-- internal-links:start -->', '<section class="cta">', '</main>') {
      my $k = index($c, $m); $pos = $k if $k >= 0 && ($pos < 0 || $k < $pos);
    }
    die "no anchor in $file" if $pos < 0;
    my $before = substr($c, 0, $pos); $before =~ s/\n+$//;
    substr($c, 0, $pos) = $before . $bottom . "\n";
    open(my $oh, '>:raw', $file) or die; print $oh $c; close $oh; $n++;
  }
}
print "guides updated: $n, skipped: $skipped\n";
