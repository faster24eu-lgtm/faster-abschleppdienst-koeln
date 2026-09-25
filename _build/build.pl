use strict; use warnings; use FindBin qw($Bin);
binmode(STDOUT,':raw');
my $OUT = "$Bin/..";
my $WA  = 'https://wa.me/4917641956993?text=Hallo%20Faster%2C%20ich%20brauche%20Hilfe%20mit%20meinem%20Fahrzeug%20in%20K%C3%B6ln.';

my $header = <<'EOT';
<header class="site-header"><div class="wrap nav">
  <a class="brand" href="index.html" aria-label="Faster Depannage Takeldienst - Startseite"><img src="assets/faster-logo.png" alt="Faster Depannage Takeldienst Logo" width="150" height="40"><span><strong>FASTER</strong><small>DEPANNAGE &amp; TAKELDIENST</small></span></a>
  <nav class="menu" aria-label="Hauptnavigation"><a href="index.html">Köln</a><a href="abschleppdienst-mittelbaden.html">Karlsruhe &amp; Mittelbaden</a><a href="abschleppdienst-a5.html">A5</a><a href="ratgeber.html">Ratgeber</a><a href="kontakt.html">Kontakt</a></nav>
  <div class="nav-cta"><a class="btn btn-wa" href="@@WA@@" target="_blank" rel="noopener">WhatsApp</a><a class="btn btn-y hide-s" href="tel:+4917641956993">+49 176 41956993</a></div>
</div></header>
EOT
my $footer = <<'EOT';
<footer class="site-footer"><div class="wrap foot-grid">
  <div><strong>Faster Depannage Takeldienst</strong><p>Abschleppdienst und Pannenhilfe in Köln sowie zwischen Karlsruhe und Offenburg. Persönlich und rund um die Uhr erreichbar.</p></div>
  <div><strong>Kontakt</strong><p><a href="tel:+4917641956993">+49 176 41956993</a><br><a href="mailto:faster@takeldienstfaster.be">faster@takeldienstfaster.be</a><br>Sitz: De Bosschaertstraat 248<br>2020 Antwerpen, Belgien</p></div>
  <div><strong>Köln</strong><p><a href="index.html">Abschleppdienst Köln</a><br><a href="pannenhilfe-koeln.html">Pannenhilfe Köln</a><br><a href="abschleppen-bergung-koeln.html">Abschleppen &amp; Bergung Köln</a><br><a href="abschleppdienst-koeln-stadtteile.html">Stadtbezirke und Rheinbrücken</a><br><a href="pannenhilfe-koelner-autobahnring.html">Kölner Autobahnring</a><br><a href="pannenhilfe-a3-koeln.html">Panne auf der A3</a><br><a href="pannenhilfe-a4-koeln.html">Panne auf der A4</a><br><a href="pannenhilfe-a1-koeln.html">Panne auf der A1</a></p></div>
  <div><strong>Karlsruhe bis Offenburg</strong><p><a href="abschleppdienst-mittelbaden.html">Übersicht Mittelbaden</a><br><a href="abschleppdienst-karlsruhe.html">Karlsruhe</a><br><a href="abschleppdienst-baden-baden.html">Baden-Baden &amp; Rastatt</a><br><a href="abschleppdienst-achern.html">Achern &amp; Bühl</a><br><a href="abschleppdienst-offenburg.html">Offenburg &amp; Kehl</a><br><a href="abschleppdienst-a5.html">Panne auf der A5</a></p></div>
  <div><strong>Ratgeber &amp; Rechtliches</strong><p><a href="ratgeber.html">Alle Ratgeber</a><br><a href="kontakt.html">Kontakt</a><br><a href="impressum.html">Impressum</a><br><a href="datenschutz.html">Datenschutz</a></p></div>
</div><div class="wrap foot-bottom">© 2026 Faster Depannage Takeldienst</div></footer>
EOT
my $ld = <<'EOT';
<script type="application/ld+json">
{"@context":"https://schema.org","@type":"LocalBusiness","name":"Faster Depannage Takeldienst","description":"Abschleppdienst und Pannenhilfe für Köln und Umgebung.","email":"faster@takeldienstfaster.be","telephone":"+4917641956993","address":{"@type":"PostalAddress","streetAddress":"De Bosschaertstraat 248","postalCode":"2020","addressLocality":"Antwerpen","addressCountry":"BE"},"areaServed":{"@type":"City","name":"Köln"},"knowsLanguage":["de","nl","fr","en"]}
</script>
EOT
my $cta = '<section class="cta"><div class="wrap cta-in"><div><h2>Liegengeblieben? Jetzt anrufen.</h2><p>24 Stunden erreichbar. Wir nennen Ihnen den Preis, bevor jemand losfährt.</p></div><div class="actions"><a class="btn btn-dark" href="@@WA@@" target="_blank" rel="noopener">WhatsApp mit Standort</a><a class="btn btn-out" href="tel:+4917641956993">+49 176 41956993</a></div></div></section>';
my (@order, %P); my $cur;
while (my $l = <DATA>) {
  if ($l =~ /^=== (\S+) \| (.*?\| Faster Depannage Takeldienst) \| (.*) \| (\w+) ===\s*$/) { $cur=$1; push @order,$cur; $P{$cur}={title=>$2,desc=>$3,flag=>$4,body=>''}; next }
  $P{$cur}{body} .= $l if defined $cur;
}
# extra page: Karlsruhe / Mittelbaden (body generated from the owner's copy by md2body.pl)
if (open(my $mb,'<:raw',"$Bin/content/mittelbaden_body.html")) {
  local $/; my $b=<$mb>; close $mb;
  my $wa2='https://wa.me/4917641956993?text=Hallo%20Faster%2C%20ich%20brauche%20Hilfe%20mit%20meinem%20Fahrzeug.';
  $b =~ s/\@\@WA2\@\@/$wa2/g;
  push @order,'abschleppdienst-mittelbaden';
  $P{'abschleppdienst-mittelbaden'}={
    title=>'Abschleppdienst Karlsruhe bis Offenburg: Festpreis ab 129 €',
    desc=>'Panne oder Unfall zwischen Karlsruhe, Baden-Baden, Achern und Offenburg? 24h Abschleppdienst und Pannenhilfe, Festpreis am Telefon. +49 176 41956993',
    flag=>'page', body=>$b};
}
sub jesc { my $s=shift; $s =~ s/<[^>]+>//g; $s =~ s/&amp;/&/g; $s =~ s/&nbsp;/ /g; $s =~ tr/\\//d; $s =~ s/"/\\"/g; $s =~ s/\s+/ /g; $s }
sub schema_for {
  my $r = shift; my $out = '';
  my @qa;
  while ($$r =~ m{<details><summary>(.*?)</summary><div>(.*?)</div></details>}sg) {
    push @qa, '{"@type":"Question","name":"'.jesc($1).'","acceptedAnswer":{"@type":"Answer","text":"'.jesc($2).'"}}';
  }
  $out .= '<script type="application/ld+json">{"@context":"https://schema.org","@type":"FAQPage","mainEntity":['.join(',',@qa).']}</script>'."\n" if @qa;
  if ($$r =~ s/<!--AREAS: (.*?) -->\n?//) {
    my @ar = map { '{"@type":"City","name":"'.$_.'"}' } split /, /, $1;
    $out .= '<script type="application/ld+json">{"@context":"https://schema.org","@type":"AutomotiveBusiness","name":"Faster Abschleppdienst","telephone":"+4917641956993","email":"faster@takeldienstfaster.be","areaServed":['.join(',',@ar).'],"knowsLanguage":["de","nl","fr","en"]}</script>'."\n";
  }
  return $out;
}
# extra pages: marker "=== slug | title | description | flag ===", optional body comment <!--AREAS: a, b -->. Later files override earlier slugs.
{
  my $dir = "$Bin/content";
  for my $name (qw(extra_pages.txt extra_koeln.txt extra_region.txt extra_guides.txt extra_guides2.txt extra_guides3.txt extra_koeln2.txt extra_koeln3.txt extra_koeln4.txt extra_guides4.txt)) {
    open(my $ex,"<:raw","$dir/$name") or next; my $c;
    while (my $l=<$ex>) {
      if ($l =~ /^=== (\S+) \| (.*?) \| (.*) \| (\w+) ===\s*$/) { $c=$1; push @order,$c unless $P{$c}; $P{$c}={title=>"$2 | Faster Abschleppdienst",desc=>$3,flag=>$4,body=>""}; next }
      $P{$c}{body} .= $l if defined $c;
    }
    close $ex;
  }
}
# ---- SEO layer: canonical, Open Graph, breadcrumbs, related links, varied CTAs, sitemap ----
# BASE must be changed to the real domain before launch (canonical, og:url, sitemap use it).
my $BASE = 'https://faster24eu-lgtm.github.io/faster-abschleppdienst-koeln/';
my $TODAY = '2026-09-26';
my %CRUMB_PARENT = (
  'pannenhilfe-koeln'=>['index','Pannenhilfe Köln'], 'abschleppen-bergung-koeln'=>['index','Abschleppen &amp; Bergung Köln'],
  'pannenhilfe-koelner-autobahnring'=>['index','Kölner Autobahnring'], 'pannenhilfe-a3-koeln'=>['pannenhilfe-koelner-autobahnring','Panne auf der A3'], 'pannenhilfe-a4-koeln'=>['pannenhilfe-koelner-autobahnring','Panne auf der A4'], 'pannenhilfe-a1-koeln'=>['pannenhilfe-koelner-autobahnring','Panne auf der A1'], 'abschleppdienst-koeln-stadtteile'=>['index','Köln: Stadtbezirke und Rheinbrücken'],
  'abschleppdienst-mittelbaden'=>['index','Karlsruhe bis Offenburg'],
  'abschleppdienst-karlsruhe'=>['abschleppdienst-mittelbaden','Karlsruhe'], 'abschleppdienst-baden-baden'=>['abschleppdienst-mittelbaden','Baden-Baden &amp; Rastatt'],
  'abschleppdienst-achern'=>['abschleppdienst-mittelbaden','Achern &amp; Bühl'], 'abschleppdienst-offenburg'=>['abschleppdienst-mittelbaden','Offenburg &amp; Kehl'],
  'abschleppdienst-a5'=>['abschleppdienst-mittelbaden','Panne auf der A5'],
  'ratgeber'=>['index','Ratgeber'], 'kontakt'=>['index','Kontakt'], 'impressum'=>['index','Impressum'], 'datenschutz'=>['index','Datenschutz'],
  'ratgeber-abschleppdienst-kosten'=>['ratgeber','Was kostet ein Abschleppdienst?'], 'ratgeber-panne-autobahn'=>['ratgeber','Panne auf der Autobahn'],
  'ratgeber-unfall-abschleppkosten'=>['ratgeber','Abschleppkosten nach einem Unfall'], 'ratgeber-e-auto-abschleppen'=>['ratgeber','E-Auto abschleppen'],
  'ratgeber-starthilfe-batterie'=>['ratgeber','Starthilfe und leere Batterie'], 'ratgeber-reifenpanne'=>['ratgeber','Reifenpanne'],
  'ratgeber-falsch-getankt'=>['ratgeber','Falsch getankt'], 'ratgeber-ausgesperrt'=>['ratgeber','Ausgesperrt'],
  'ratgeber-motorrad-transport'=>['ratgeber','Motorrad-Transport'], 'ratgeber-abschleppseil-oder-abschleppdienst'=>['ratgeber','Abschleppseil oder Abschleppdienst?'],
  'ratgeber-warnleuchten-auto'=>['ratgeber','Warnleuchten im Auto'], 'ratgeber-motor-ueberhitzt'=>['ratgeber','Motor überhitzt'],
  'ratgeber-automatik-abschleppen'=>['ratgeber','Automatikauto abschleppen'], 'ratgeber-nach-unfall-fahrbereit'=>['ratgeber','Nach dem Unfall: fahrbereit?'],
  'ratgeber-handbremse-loest-sich-nicht'=>['ratgeber','Handbremse löst sich nicht'], 'ratgeber-motor-geht-aus'=>['ratgeber','Motor geht während der Fahrt aus'],
  'ratgeber-transporter-abschleppen'=>['ratgeber','Transporter abschleppen'], 'ratgeber-tiefgarage-parkhaus-liegengeblieben'=>['ratgeber','Tiefgarage und Parkhaus'], 'ratgeber-wohnmobil-gespann-panne'=>['ratgeber','Wohnmobil und Gespann'],
);
my %CRUMB_LABEL = ('index'=>'Start', 'ratgeber'=>'Ratgeber', 'abschleppdienst-mittelbaden'=>'Karlsruhe bis Offenburg');
# related links per page from related.txt (tab separated: slug, target, label, small); placed before the CTA
my %RELATED = ();
{
  my $rf = "$Bin/content/related.txt";
  if (open(my $rh,'<:raw',$rf)) { while (my $l=<$rh>) { chomp $l; $l =~ s/\r$//; next unless $l =~ /\S/ && $l !~ /^#/; my ($s,@t)=split /\t/, $l; push @{$RELATED{$s}}, \@t; } close $rh; }
}
sub related_for {
  my $slug = shift; my $r = $RELATED{$slug} or return '';
  my $h = join('', map { sprintf('<a href="%s">%s<small>%s</small></a>', $_->[0], $_->[1], $_->[2]//'') } @$r);
  return qq{\n<section class="section"><div class="wrap narrow"><h2>Weiterlesen</h2><div class="related">$h</div></div></section>\n};
}
sub cta_for {
  my $slug = shift;
  my ($h,$t);
  if ($slug =~ /^(index|.*koeln.*)$/) { ($h,$t)=('Panne in Köln?','Rufen Sie an oder schreiben Sie per WhatsApp und schicken Sie Ihren Standort.'); }
  elsif ($slug =~ /^abschleppdienst-(karlsruhe|baden-baden|achern|offenburg|a5|mittelbaden)$/) { ($h,$t)=('Liegen geblieben zwischen Karlsruhe und Offenburg?','Rufen Sie an oder teilen Sie Ihren Standort per WhatsApp. Den Preis nennen wir vor der Abfahrt.'); }
  elsif ($slug =~ /^ratgeber/) { ($h,$t)=('Ihr Fall ist nicht dabei?','Schildern Sie uns die Lage kurz am Telefon oder per WhatsApp, dann sagen wir Ihnen, was sinnvoll ist.'); }
  else { ($h,$t)=('Direkt erreichbar','Telefon und WhatsApp: rund um die Uhr.'); }
  return qq{<section class="cta"><div class="wrap cta-in"><div><h2>$h</h2><p>$t</p></div><div class="actions"><a class="btn btn-dark" href="\@\@WA\@\@" target="_blank" rel="noopener">WhatsApp mit Standort</a><a class="btn btn-out" href="tel:+4917641956993">+49 176 41956993</a></div></div></section>};
}
sub plainlen { my $s=shift; $s =~ s/&amp;/&/g; $s =~ s/&[a-z]+;/x/g; length($s) }
my @SITEMAP;

for my $slug (@order) {
  my $p=$P{$slug}; my $body=$p->{body}; my $wa = ($slug eq 'index' || $slug =~ /koeln/) ? $WA : 'https://wa.me/4917641956993?text=Hallo%20Faster%2C%20ich%20brauche%20Hilfe%20mit%20meinem%20Fahrzeug.'; $body =~ s/\@\@CTA\@\@/related_for($slug).cta_for($slug)/ge; $body =~ s/\@\@WA\@\@/$wa/g; my $hd=$header; $hd =~ s/\@\@WA\@\@/$wa/g;
  # PREVIEW MODE: every page is hidden from search engines until launch (remove this line's noindex to go live)
  my $robots = qq{<meta name="robots" content="noindex, nofollow">\n};
  my $json = $slug eq "index" ? $ld : "";
  $json .= schema_for(\$body);
  my $suffix = ' | Faster Abschleppdienst';
  my $tt = $p->{title}; $tt =~ s/ \| Faster (Abschleppdienst|Depannage Takeldienst)$//;
  if ($slug eq 'index') { $tt .= ' | Faster Depannage Takeldienst' if plainlen($tt.' | Faster Depannage Takeldienst') <= 75; }
  else { $tt .= $suffix if plainlen($tt.$suffix) <= 62; }
  my $curl  = $slug eq 'index' ? $BASE : "$BASE$slug.html";
  my $canon = qq{<link rel="canonical" href="$curl">\n};
  my $og = qq{<meta property="og:type" content="website"><meta property="og:locale" content="de_DE"><meta property="og:site_name" content="Faster Depannage Takeldienst"><meta property="og:title" content="$tt"><meta property="og:description" content="$p->{desc}"><meta property="og:url" content="$curl"><meta property="og:image" content="${BASE}assets/faster-road-transport.jpg">\n};
  my $crumbs = ''; my $bcjson = '';
  if ($slug ne 'index' && $CRUMB_PARENT{$slug}) {
    my ($par,$lab) = @{$CRUMB_PARENT{$slug}}; my @chain = ([$slug,$lab]);
    while ($par && $par ne 'index') { my $pp = $CRUMB_PARENT{$par}; unshift @chain, [$par, $pp ? $pp->[1] : $CRUMB_LABEL{$par}]; $par = $pp ? $pp->[0] : undef; }
    unshift @chain, ['index','Start'];
    my (@li,@jl); my $i=0;
    for my $c (@chain) { $i++; my ($cs,$cl)=@$c; my $u = $cs eq 'index' ? $BASE : "$BASE$cs.html";
      (my $lj=$cl) =~ s/&amp;/&/g; $lj =~ s/"/\\"/g;
      push @jl, qq({"\@type":"ListItem","position":$i,"name":"$lj","item":"$u"});
      push @li, $i==@chain ? qq{<span aria-current="page">$cl</span>} : sprintf('<a href="%s">%s</a>', $cs eq 'index' ? 'index.html' : "$cs.html", $cl); }
    $crumbs = '<nav class="crumbs" aria-label="Brotkrumen"><div class="wrap">'.join(' &rsaquo; ',@li)."</div></nav>\n";
    $bcjson = '<script type="application/ld+json">{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":['.join(',',@jl).']}</script>'."\n";
  }
  $json .= $bcjson;
  push @SITEMAP, [$curl,$slug] unless $slug eq 'danke';
  warn "TITLE>62 ($slug): ".plainlen($tt)." $tt\n" if plainlen($tt) > 62 && $slug ne 'index';
  warn "DESC>160 ($slug): ".plainlen($p->{desc})."\n" if plainlen($p->{desc}) > 160;
  my $html = qq{<!doctype html>\n<html lang="de">\n<head>\n<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">\n<title>$tt</title>\n<meta name="description" content="$p->{desc}">\n$robots$canon$og<meta name="theme-color" content="#121212">\n<link rel="icon" href="assets/favicon.ico" sizes="any"><link rel="icon" type="image/png" sizes="32x32" href="assets/favicon-32.png"><link rel="apple-touch-icon" href="assets/apple-touch-icon.png">\n<link rel="stylesheet" href="styles.css">\n$json</head>\n<body>\n$hd<main>\n$crumbs$body</main>\n$footer</body>\n</html>\n};
  open(my $o,'>:raw',"$OUT/$slug.html") or die; print $o $html; close $o; print "wrote $slug.html\n";
}
{
  my $x = qq{<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n};
  for my $u (@SITEMAP) { $x .= "  <url><loc>$u->[0]</loc><lastmod>$TODAY</lastmod></url>\n"; }
  $x .= "</urlset>\n";
  open(my $sm,'>:raw',"$OUT/sitemap.xml") or die; print $sm $x; close $sm; print "wrote sitemap.xml (".scalar(@SITEMAP)." urls)\n";
}

__DATA__
=== index | Abschleppdienst Köln – Pannenhilfe &amp; Abschleppen | Faster Depannage Takeldienst | Abschleppdienst und Pannenhilfe für Köln und Umgebung: Pkw, Transporter, Motorräder. 24/7 erreichbar per Telefon und WhatsApp. Faster Depannage Takeldienst. | index ===
<section class="hero"><div class="wrap hero-grid"><div>
<p class="eyebrow">Abschleppdienst Köln</p>
<h1>Abschleppdienst Köln: Pannenhilfe und Abschleppen, 24/7 erreichbar</h1>
<p class="lead">Panne, Unfall oder ein Fahrzeug, das nicht mehr startet? Rufen Sie an oder schreiben Sie per WhatsApp. Wir besprechen die Situation und organisieren die Hilfe in Köln und Umgebung.</p>
<div class="actions"><a class="btn btn-wa" href="@@WA@@" target="_blank" rel="noopener">WhatsApp mit Standort senden</a><a class="btn btn-y" href="tel:+4917641956993">+49 176 41956993 anrufen</a></div>
<ul class="proof"><li><strong>24/7</strong>erreichbar per Telefon und WhatsApp</li><li><strong>Persönlich</strong>direkt am Telefon oder per WhatsApp</li><li><strong>Pkw bis Transporter</strong>auch Motorräder und Maschinen</li></ul>
</div><div><img class="hero-img" src="assets/faster-road-transport.jpg" alt="Faster Abschleppwagen mit Fahrzeugen auf der Straße" width="1200" height="900" fetchpriority="high"></div></div></section>
<section class="section"><div class="wrap"><h2>Unsere Leistungen in Köln und Umgebung</h2><p class="sub">Von der einfachen Starthilfe bis zum Abschleppen nach einem Unfall.</p>
<div class="cards3">
<article class="card"><h3>Pannenhilfe</h3><p>Batterie leer, platter Reifen, Startprobleme oder ausgesperrt? Wir versuchen zuerst, Ihnen vor Ort zu helfen.</p><a href="pannenhilfe-koeln.html">Mehr erfahren →</a></article>
<article class="card"><h3>Abschleppen und Bergung</h3><p>Nach Unfall, Brand oder Schaden holen wir Ihr Fahrzeug sicher ab und bringen es zum vereinbarten Ort.</p><a href="abschleppen-bergung-koeln.html">Mehr erfahren →</a></article>
<article class="card"><h3>Fahrzeugtransport</h3><p>Zur Werkstatt, nach Hause, zum Händler oder an ein anderes Ziel, auch wenn es nicht eilt.</p><a href="abschleppen-bergung-koeln.html">Mehr erfahren →</a></article>
<article class="card"><h3>Transporter bis 3,5 Tonnen</h3><p>Größere Fahrzeuge brauchen andere Kapazität und eine andere Ladeweise. Auch dafür gibt es eine Lösung.</p></article>
<article class="card"><h3>Motorräder und Roller</h3><p>Zwei Räder oder vier: Für uns macht das keinen Unterschied.</p></article>
<article class="card"><h3>Maschinen und Gabelstapler</h3><p>Auch Transport für schweres oder ungewöhnliches Material.</p></article>
</div></div></section>
<section class="section grey"><div class="wrap"><h2>So funktioniert es</h2><div class="steps">
<article class="step"><span>1</span><h3>Anruf oder WhatsApp</h3><p>Nennen Sie Ihren Standort (am schnellsten per WhatsApp-Standort), Marke und Modell und was passiert ist.</p></article>
<article class="step"><span>2</span><h3>Situation klären</h3><p>Wir besprechen mit Ihnen, was nötig ist und wie es weitergeht.</p></article>
<article class="step"><span>3</span><h3>Hilfe vor Ort</h3><p>Wir organisieren die vereinbarte Hilfe und bringen Ihr Fahrzeug an den gewünschten Ort.</p></article>
</div></div></section>
<section class="section"><div class="wrap narrow"><h2>Erst Sicherheit, dann Hilfe</h2>
<p>Bringen Sie sich zuerst in Sicherheit, bevor Sie uns anrufen: Warnblinkanlage einschalten, Warnweste anziehen, Warndreieck aufstellen, wenn es sicher möglich ist, und wenn möglich hinter der Leitplanke warten. Um das Technische kümmern wir uns.</p></div></section>
<section class="section grey"><div class="wrap narrow"><h2>Häufige Fragen</h2>
<details><summary>Wie schnell sind Sie da?</summary><div>Das hängt von Standort, Verkehr und Verfügbarkeit ab. Wir geben Ihnen beim Anruf eine realistische Einschätzung statt eines festen Versprechens.</div></details>
<details><summary>Was kostet die Hilfe?</summary><div>Das hängt von Standort, Ziel, Fahrzeug und Situation ab und lässt sich nicht pauschal auf einer Website sagen. Rufen Sie an oder schreiben Sie uns, dann besprechen wir Ihren Fall persönlich.</div></details>
<details><summary>Sind Sie nachts und am Wochenende erreichbar?</summary><div>Ja, per Telefon und WhatsApp sind wir 24/7 erreichbar.</div></details>
<details><summary>Wo sitzt Faster, und wer fährt in Köln?</summary><div>Faster Depannage Takeldienst hat seinen Sitz in Antwerpen (Belgien). In Köln und Umgebung arbeiten wir mit Partnern zusammen, die den Einsatz vor Ort übernehmen. Sie erreichen uns rund um die Uhr; wir koordinieren die Hilfe.</div></details>
<details><summary>Welche Sprachen sprechen Sie?</summary><div>Deutsch, Niederländisch, Französisch und Englisch.</div></details>
</div></section>
<section class="cta"><div class="wrap cta-in"><div><h2>Panne in Köln?</h2><p>Rufen Sie an oder schreiben Sie per WhatsApp. Wir sind 24/7 erreichbar.</p></div><div class="actions"><a class="btn btn-dark" href="@@WA@@" target="_blank" rel="noopener">WhatsApp</a><a class="btn btn-out" href="tel:+4917641956993">+49 176 41956993</a></div></div></section>
=== pannenhilfe-koeln | Pannenhilfe Köln | Faster Depannage Takeldienst | Pannenhilfe in Köln und Umgebung: Batterie, Reifen, Startprobleme, ausgesperrt, falsch getankt. 24/7 erreichbar per Telefon und WhatsApp. | page ===
<section class="page-head"><div class="wrap narrow"><p class="eyebrow">Pannenhilfe</p><h1>Pannenhilfe Köln</h1><p class="lead">Nicht jede Panne braucht einen Abschleppwagen. Oft lässt sich das Problem vor Ort lösen.</p></div></section>
<section class="section"><div class="wrap narrow copy">
<h2>Wobei wir helfen</h2>
<ul class="ticks">
<li><strong>Batterie leer und Startprobleme:</strong> Wenn es sicher und technisch möglich ist, versuchen wir zuerst, das Fahrzeug mit einem Booster zu starten.</li>
<li><strong>Platter Reifen:</strong> Weiterfahren ist nicht immer möglich oder sicher. Oft ist ein direkter Transport zum Reifenservice die günstigste und effizienteste Lösung.</li>
<li><strong>Ausgesperrt:</strong> Wir schauen, ob wir Ihnen vor Ort helfen können.</li>
<li><strong>Falsch getankt:</strong> Nicht einfach weiterfahren. Je nach Situation ziehen wir einen Techniker hinzu oder bringen das Fahrzeug zu einer Werkstatt.</li>
<li><strong>Fahrzeug springt nicht an:</strong> Wir prüfen zuerst, was los ist, und entscheiden dann, ob eine Hilfe vor Ort reicht oder das Fahrzeug abgeschleppt werden muss.</li>
</ul>
<h2>So läuft es ab</h2>
<p>Rufen Sie an oder schreiben Sie per WhatsApp und senden Sie Ihren Standort. Wir besprechen, was nötig ist, und organisieren die Hilfe.</p>
<p><a class="btn btn-wa" href="@@WA@@" target="_blank" rel="noopener">WhatsApp mit Standort</a> <a class="btn btn-y" href="tel:+4917641956993">+49 176 41956993</a></p>
</div></section>
=== abschleppen-bergung-koeln | Abschleppen und Bergung Köln | Faster Depannage Takeldienst | Abschleppen und Bergung in Köln und Umgebung nach Panne, Unfall oder Schaden. Transport zur Werkstatt oder zum Wunschziel. | page ===
<section class="page-head"><div class="wrap narrow"><p class="eyebrow">Abschleppen &amp; Bergung</p><h1>Abschleppen und Bergung Köln</h1><p class="lead">Wenn Weiterfahren nicht mehr geht, bringen wir Ihr Fahrzeug sicher an den vereinbarten Ort.</p></div></section>
<section class="section"><div class="wrap narrow copy">
<h2>Abschleppen nach Panne oder Unfall</h2>
<p>Von der klassischen Abschleppung bis zum Unfall, Brand oder schweren Schaden: Wir holen Ihr Fahrzeug sicher ab und bringen es zur Werkstatt, nach Hause oder an ein anderes Ziel. Die Vorgehensweise hängt von Situation und Fahrzeug ab.</p>
<h2>Fahrzeugtransport ohne Eile</h2>
<p>Nicht jede Fahrt ist dringend. Steht das Fahrzeug bereits sicher, planen wir den Transport zu einem passenden Zeitpunkt, zum Beispiel zur Werkstatt, zum Händler oder zu einem Käufer oder Verkäufer.</p>
<h2>Fahrzeuge</h2>
<ul class="ticks"><li>Pkw und Transporter bis 3,5 Tonnen</li><li>Motorräder und Roller</li><li>Maschinen und Gabelstapler</li></ul>
<h2>Kosten</h2>
<p>Die Kosten hängen von Standort, Ziel, Fahrzeugtyp und Dringlichkeit ab. Rufen Sie an oder schreiben Sie uns, dann besprechen wir Ihren Fall persönlich.</p>
<p><a class="btn btn-wa" href="@@WA@@" target="_blank" rel="noopener">WhatsApp mit Standort</a> <a class="btn btn-y" href="tel:+4917641956993">+49 176 41956993</a></p>
</div></section>
=== kontakt | Kontakt &amp; Anfrage | Faster Depannage Takeldienst | Abschleppdienst Köln kontaktieren: per Telefon, WhatsApp oder Formular. Faster Depannage Takeldienst. | page ===
<section class="page-head"><div class="wrap narrow"><p class="eyebrow">Kontakt</p><h1>Hilfe anfordern</h1><p class="lead">Dringend? Rufen Sie an oder schreiben Sie per WhatsApp und senden Sie Ihren Standort.</p></div></section>
<section class="section"><div class="wrap split">
<div class="copy"><h2>So erreichen Sie uns</h2>
<p><a class="btn btn-wa" href="@@WA@@" target="_blank" rel="noopener">WhatsApp schreiben</a></p>
<p><a class="btn btn-y" href="tel:+4917641956993">+49 176 41956993 anrufen</a></p>
<p><strong>E-Mail:</strong> <a href="mailto:faster@takeldienstfaster.be">faster@takeldienstfaster.be</a></p>
<p><strong>Sitz:</strong><br>Faster Depannage Takeldienst<br>De Bosschaertstraat 248<br>2020 Antwerpen, Belgien</p>
<p><strong>Sprachen:</strong> Deutsch, Niederländisch, Französisch und Englisch.</p></div>
<form class="formbox" action="https://formsubmit.co/faster24eu@gmail.com" method="POST">
<input type="hidden" name="_subject" value="[DE-Köln Abschleppdienst] Neue Anfrage">
<input type="hidden" name="_template" value="table"><input type="hidden" name="_captcha" value="true">
<label>Name*<input name="naam" required></label>
<label>E-Mail*<input type="email" name="email" required></label>
<label>Telefonnummer<input name="telefoon"></label>
<label>Marke und Modell des Fahrzeugs<input name="voertuig"></label>
<label>Wo steht das Fahrzeug?<input name="ophaalplaats"></label>
<label>Wohin soll es gebracht werden?<input name="bestemming"></label>
<label>Was ist passiert?<textarea name="situatie"></textarea></label>
<button class="btn btn-y" type="submit">Anfrage senden</button>
<p class="fine">Mit dem Absenden stimmen Sie zu, dass Ihre Angaben zur Bearbeitung Ihrer Anfrage per E-Mail an Faster übermittelt werden. Mehr in der <a href="datenschutz.html">Datenschutzerklärung</a>.</p>
</form></div></section>
=== impressum | Impressum | Faster Depannage Takeldienst | Anbieterkennzeichnung von Faster Depannage Takeldienst. | noindex ===
<section class="page-head"><div class="wrap narrow"><h1>Impressum</h1></div></section>
<section class="section"><div class="wrap narrow copy">
<p><mark>ENTWURF: Die markierten Angaben müssen vor der Veröffentlichung ergänzt werden.</mark></p>
<h2>Angaben gemäß § 5 DDG</h2>
<p><mark>[Firmenname und Rechtsform laut Handelsregister ergänzen]</mark><br>De Bosschaertstraat 248<br>2020 Antwerpen, Belgien</p>
<h2>Kontakt</h2>
<p>Telefon: +49 176 41956993<br>E-Mail: <a href="mailto:faster@takeldienstfaster.be">faster@takeldienstfaster.be</a></p>
<h2>Unternehmensregister und Umsatzsteuer</h2>
<p>Unternehmensnummer (KBO/BCE): <mark>[ergänzen]</mark><br>Umsatzsteuer-Identifikationsnummer (BTW): <mark>[ergänzen]</mark></p>
<h2>Vertretungsberechtigt</h2>
<p><mark>[Name des Geschäftsführers ergänzen]</mark></p>
<p class="fine">Hinweis: Bitte lassen Sie das Impressum vor der Veröffentlichung von einer fachkundigen Person prüfen.</p>
</div></section>
=== datenschutz | Datenschutzerklärung | Faster Depannage Takeldienst | Datenschutzerklärung dieser Website. | noindex ===
<section class="page-head"><div class="wrap narrow"><h1>Datenschutzerklärung</h1></div></section>
<section class="section"><div class="wrap narrow copy">
<p><mark>ENTWURF: Bitte vor der Veröffentlichung von einer fachkundigen Person prüfen lassen und die markierten Angaben ergänzen.</mark></p>
<h2>1. Verantwortlicher</h2>
<p><mark>[Firmenname]</mark>, De Bosschaertstraat 248, 2020 Antwerpen, Belgien. E-Mail: <a href="mailto:faster@takeldienstfaster.be">faster@takeldienstfaster.be</a>, Telefon: +49 176 41956993.</p>
<h2>2. Hosting</h2>
<p>Diese Website wird <mark>[Hosting-Anbieter eintragen, z. B. GitHub Pages]</mark> bereitgestellt. Beim Aufruf der Seiten verarbeitet der Anbieter technisch notwendige Daten, insbesondere Ihre IP-Adresse, in Server-Logdateien. Rechtsgrundlage ist Art. 6 Abs. 1 lit. f DSGVO.</p>
<h2>3. Kontaktformular</h2>
<p>Wenn Sie das Formular nutzen, werden Ihre Angaben über den Dienst FormSubmit.co per E-Mail an uns übermittelt und ausschließlich zur Bearbeitung Ihrer Anfrage verwendet. Rechtsgrundlage ist Art. 6 Abs. 1 lit. b bzw. lit. f DSGVO. FormSubmit.co hat seinen Sitz außerhalb der EU.</p>
<h2>4. Kontakt per Telefon, E-Mail und WhatsApp</h2>
<p>Wenn Sie uns anrufen, schreiben oder den WhatsApp-Link nutzen, verarbeiten wir die mitgeteilten Daten (bei WhatsApp auch Ihren Standort, wenn Sie ihn senden) zur Bearbeitung Ihrer Anfrage. Für WhatsApp gelten zusätzlich deren Datenschutzbestimmungen.</p>
<h2>5. Cookies und Tracking</h2>
<p>Diese Website verwendet keine Cookies zu Analyse- oder Werbezwecken und bindet keine Tracking-Dienste ein.</p>
<h2>6. Ihre Rechte</h2>
<p>Sie haben das Recht auf Auskunft, Berichtigung, Löschung, Einschränkung der Verarbeitung, Datenübertragbarkeit und Widerspruch sowie das Recht, sich bei einer Datenschutzaufsichtsbehörde zu beschweren, in Belgien bei der Gegevensbeschermingsautoriteit (Autorité de protection des données).</p>
</div></section>
=== danke | Vielen Dank | Faster Depannage Takeldienst | Ihre Anfrage wurde gesendet. | noindex ===
<section class="page-head"><div class="wrap narrow"><h1>Vielen Dank für Ihre Anfrage</h1><p class="lead">Wir melden uns so schnell wie möglich. Bei dringenden Fällen erreichen Sie uns jederzeit per Telefon oder WhatsApp.</p><p><a class="btn btn-y" href="index.html">Zur Startseite</a></p></div></section>
