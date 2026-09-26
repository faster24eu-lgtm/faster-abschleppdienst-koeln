use strict; use warnings; use FindBin qw($Bin);
binmode(STDOUT,':raw');
my $OUT = "$Bin/..";
my $WA  = 'https://wa.me/4917641956993?text=Hallo%20Faster%2C%20ich%20brauche%20Hilfe%20mit%20meinem%20Fahrzeug%20in%20K%C3%B6ln.';

my $header = <<'EOT';
<header class="site-header"><div class="wrap nav">
  <a class="brand" href="home.html" aria-label="Faster Abschleppdienst - Startseite"><img src="assets/faster-logo-de-600.png" alt="Faster Abschleppdienst Logo" width="110" height="38"><span><strong>FASTER</strong><small>ABSCHLEPPDIENST &amp; PANNENHILFE</small></span></a>
  <nav class="menu" aria-label="Hauptnavigation">@@MENU@@</nav>
  <div class="nav-cta"><a class="btn btn-wa" href="@@WA@@" target="_blank" rel="noopener">WhatsApp</a><a class="btn btn-y hide-s" href="tel:+4917641956993">+49 176 41956993</a></div>
</div></header>
EOT
my $footer = <<'EOT';
<footer class="site-footer"><div class="wrap foot-grid">
  <div><strong>Faster Abschleppdienst</strong><p>Abschleppdienst und Pannenhilfe in Köln sowie zwischen Karlsruhe und Offenburg. Persönlich und rund um die Uhr erreichbar.</p></div>
  <div><strong>Kontakt</strong><p><a href="tel:+4917641956993">+49 176 41956993</a><br><a href="mailto:faster@takeldienstfaster.be">faster@takeldienstfaster.be</a><br>Sitz: De Bosschaertstraat 248<br>2020 Antwerpen, Belgien</p></div>
  <div><strong>Köln</strong><p><a href="index.html">Abschleppdienst Köln</a><br><a href="pannenhilfe-koeln.html">Pannenhilfe Köln</a><br><a href="abschleppen-bergung-koeln.html">Abschleppen &amp; Bergung Köln</a><br><a href="abschleppdienst-koeln-stadtteile.html">Stadtbezirke und Rheinbrücken</a><br><a href="pannenhilfe-koelner-autobahnring.html">Kölner Autobahnring</a><br><a href="pannenhilfe-a3-koeln.html">Panne auf der A3</a><br><a href="pannenhilfe-a4-koeln.html">Panne auf der A4</a><br><a href="pannenhilfe-a1-koeln.html">Panne auf der A1</a></p></div>
  <div><strong>Karlsruhe bis Offenburg</strong><p><a href="abschleppdienst-mittelbaden.html">Übersicht Mittelbaden</a><br><a href="abschleppdienst-karlsruhe.html">Karlsruhe</a><br><a href="abschleppdienst-baden-baden.html">Baden-Baden &amp; Rastatt</a><br><a href="abschleppdienst-achern.html">Achern &amp; Bühl</a><br><a href="abschleppdienst-offenburg.html">Offenburg &amp; Kehl</a><br><a href="abschleppdienst-a5.html">Panne auf der A5</a></p></div>
  <div><strong>Ratgeber &amp; Rechtliches</strong><p><a href="ratgeber.html">Alle Ratgeber</a><br><a href="kontakt.html">Kontakt</a><br><a href="impressum.html">Impressum</a><br><a href="datenschutz.html">Datenschutz</a></p></div>
</div><div class="wrap foot-bottom">© 2026 Faster Abschleppdienst</div></footer>
EOT
my $ld = <<'EOT';
<script type="application/ld+json">
{"@context":"https://schema.org","@type":"LocalBusiness","name":"Faster Abschleppdienst","description":"Abschleppdienst und Pannenhilfe für Köln und Umgebung.","email":"faster@takeldienstfaster.be","telephone":"+4917641956993","address":{"@type":"PostalAddress","streetAddress":"De Bosschaertstraat 248","postalCode":"2020","addressLocality":"Antwerpen","addressCountry":"BE"},"areaServed":{"@type":"City","name":"Köln"},"knowsLanguage":["de","nl","fr","en"]}
</script>
EOT
my $cta = '<section class="cta"><div class="wrap cta-in"><div><h2>Liegengeblieben? Jetzt anrufen.</h2><p>24 Stunden erreichbar. Wir nennen Ihnen den Preis, bevor jemand losfährt.</p></div><div class="actions"><a class="btn btn-dark" href="@@WA@@" target="_blank" rel="noopener">WhatsApp mit Standort</a><a class="btn btn-out" href="tel:+4917641956993">+49 176 41956993</a></div></div></section>';
my (@order, %P); my $cur;
while (my $l = <DATA>) {
  if ($l =~ /^=== (\S+) \| (.*?\| Faster Abschleppdienst) \| (.*) \| (\w+) ===\s*$/) { $cur=$1; push @order,$cur; $P{$cur}={title=>$2,desc=>$3,flag=>$4,body=>''}; next }
  $P{$cur}{body} .= $l if defined $cur;
}
# extra page: Karlsruhe / Mittelbaden (body generated from the owner's copy by md2body.pl)
if (open(my $mb,'<:raw',"$Bin/content/mittelbaden_body.html")) {
  local $/; my $b=<$mb>; close $mb;
  my $wa2='https://wa.me/4917641956993?text=Hallo%20Faster%2C%20ich%20brauche%20Hilfe%20mit%20meinem%20Fahrzeug.';
  $b =~ s/\@\@WA2\@\@/$wa2/g;
  push @order,'abschleppdienst-mittelbaden';
  $P{'abschleppdienst-mittelbaden'}={
    title=>'Abschleppdienst Karlsruhe bis Offenburg ab 129 €',
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
  for my $name (qw(extra_pages.txt extra_koeln.txt extra_region.txt extra_guides.txt extra_guides2.txt extra_guides3.txt extra_koeln2.txt extra_koeln3.txt extra_koeln4.txt extra_guides4.txt extra_guides5.txt extra_guides6.txt extra_guides7.txt extra_guides8.txt extra_guides9.txt extra_guides10.txt extra_guides11.txt extra_guides12.txt extra_guides13.txt extra_guides14.txt extra_koeln5.txt extra_koeln6.txt extra_guides15.txt extra_home.txt extra_ratgeber.txt)) {
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
  'ratgeber-transporter-abschleppen'=>['ratgeber','Transporter abschleppen'], 'ratgeber-tiefgarage-parkhaus-liegengeblieben'=>['ratgeber','Tiefgarage und Parkhaus'], 'ratgeber-wohnmobil-gespann-panne'=>['ratgeber','Wohnmobil und Gespann'], 'ratgeber-winterpanne-schwarzwald'=>['ratgeber','Winterpanne Schwarzwald'], 'ratgeber-panne-kehl-strassburg'=>['ratgeber','Kehl und Straßburg'], 'ratgeber-auto-springt-nicht-an'=>['ratgeber','Auto springt nicht an'], 'ratgeber-kupplung-defekt'=>['ratgeber','Kupplung defekt'], 'ratgeber-wildunfall'=>['ratgeber','Wildunfall'], 'ratgeber-wasserschlag-ueberschwemmung'=>['ratgeber','Auto im Wasser'], 'ratgeber-oelverlust-oelspur'=>['ratgeber','Ölverlust und Ölspur'], 'ratgeber-auto-festgefahren'=>['ratgeber','Auto festgefahren'], 'ratgeber-lenkradsperre-klemmt'=>['ratgeber','Lenkradsperre klemmt'], 'ratgeber-bremsen-versagen'=>['ratgeber','Bremsen versagen'], 'ratgeber-adblue-leer'=>['ratgeber','AdBlue leer'], 'ratgeber-notlauf-auto'=>['ratgeber','Auto im Notlauf'], 'ratgeber-servolenkung-ausgefallen'=>['ratgeber','Servolenkung ausgefallen'],
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

# ---- Site structure: /koeln/, /karlsruhe/, /ratgeber/ ; folder URLs (each page = folder/index.html) ----
my %PATH = (
  'home'=>'',
  'index'=>'koeln', 'pannenhilfe-koeln'=>'koeln/pannenhilfe', 'abschleppen-bergung-koeln'=>'koeln/abschleppen-bergung',
  'pannenhilfe-koelner-autobahnring'=>'koeln/autobahnring', 'pannenhilfe-a1-koeln'=>'koeln/a1', 'pannenhilfe-a3-koeln'=>'koeln/a3', 'pannenhilfe-a4-koeln'=>'koeln/a4',
  'koeln-a57'=>'koeln/a57', 'koeln-a59'=>'koeln/a59', 'koeln-a555'=>'koeln/a555', 'koeln-leverkusener-bruecke'=>'koeln/leverkusener-bruecke',
  'abschleppdienst-koeln-stadtteile'=>'koeln/stadtteile',
  'abschleppdienst-mittelbaden'=>'karlsruhe', 'abschleppdienst-karlsruhe'=>'karlsruhe/stadt', 'abschleppdienst-baden-baden'=>'karlsruhe/baden-baden',
  'abschleppdienst-achern'=>'karlsruhe/achern', 'abschleppdienst-offenburg'=>'karlsruhe/offenburg', 'abschleppdienst-a5'=>'karlsruhe/a5',
  'ratgeber'=>'ratgeber',
);
$PATH{"koeln-$_"} = "koeln/$_" for qw(innenstadt ehrenfeld nippes lindenthal rodenkirchen porz kalk muelheim chorweiler);
sub path_for { my $s=shift; return $PATH{$s} if exists $PATH{$s}; return "ratgeber/$1" if $s =~ /^ratgeber-(.+)$/; return $s; }
sub region_for { my $pa=shift; return 'koeln' if $pa =~ m{^koeln}; return 'karlsruhe' if $pa =~ m{^karlsruhe}; return 'shared'; }
sub depth_of { my $pa=shift; return $pa eq '' ? 0 : scalar(split m{/}, $pa); }
sub relurl { my ($from,$to)=@_; my $d=depth_of($from); my $up = $d ? ('../' x $d) : './'; return $to eq '' ? $up : ($d ? $up : './').$to.'/'; }
sub fix_links {
  my ($html,$from)=@_; my $d=depth_of($from); my $R = $d ? ('../' x $d) : '';
  $html =~ s{href="([a-z0-9-]+)\.html((?:\#[^"]*)?)"}{ exists $PATH{$1} || $1 =~ /^(ratgeber-.+|kontakt|impressum|datenschutz|danke)$/ ? 'href="'.relurl($from,path_for($1)).$2.'"' : qq{href="$1.html$2"} }ge;
  $html =~ s{(href|src)="(assets/[^"]+|styles\.css)"}{$1="$R$2"}g;
  return $html;
}
my %MENU = (
  koeln     => [['Köln','index'],['Pannenhilfe','pannenhilfe-koeln'],['Autobahnen','pannenhilfe-koelner-autobahnring'],['Stadtteile','abschleppdienst-koeln-stadtteile'],['Ratgeber','ratgeber'],['Kontakt','kontakt']],
  karlsruhe => [['Karlsruhe &amp; Mittelbaden','abschleppdienst-mittelbaden'],['Karlsruhe','abschleppdienst-karlsruhe'],['A5','abschleppdienst-a5'],['Ratgeber','ratgeber'],['Kontakt','kontakt']],
  shared    => [['Köln','index'],['Karlsruhe &amp; Mittelbaden','abschleppdienst-mittelbaden'],['Ratgeber','ratgeber'],['Kontakt','kontakt']],
);
$CRUMB_PARENT{'index'} = ['home','Köln &amp; Umgebung'];
$CRUMB_PARENT{'abschleppdienst-mittelbaden'} = ['home','Karlsruhe &amp; Mittelbaden'];
$CRUMB_PARENT{$_} = ['home', {ratgeber=>'Ratgeber',kontakt=>'Kontakt',impressum=>'Impressum',datenschutz=>'Datenschutz'}->{$_}] for qw(ratgeber kontakt impressum datenschutz);
$CRUMB_PARENT{'abschleppdienst-koeln-stadtteile'} = ['index','Stadtbezirke und Rheinbrücken'];
my %DISTRICT = (innenstadt=>'Innenstadt', ehrenfeld=>'Ehrenfeld', nippes=>'Nippes', lindenthal=>'Lindenthal', rodenkirchen=>'Rodenkirchen', porz=>'Porz', kalk=>'Kalk', muelheim=>'Mülheim', chorweiler=>'Chorweiler');
$CRUMB_PARENT{"koeln-$_"} = ['abschleppdienst-koeln-stadtteile', "Köln-$DISTRICT{$_}"] for keys %DISTRICT;
$CRUMB_PARENT{'koeln-a57'} = ['pannenhilfe-koelner-autobahnring','Panne auf der A57'];
$CRUMB_PARENT{'koeln-a59'} = ['pannenhilfe-koelner-autobahnring','Panne auf der A59'];
$CRUMB_PARENT{'koeln-a555'} = ['pannenhilfe-koelner-autobahnring','Panne auf der A555'];
$CRUMB_PARENT{'koeln-leverkusener-bruecke'} = ['pannenhilfe-koelner-autobahnring','Leverkusener Brücke'];
$CRUMB_PARENT{'ratgeber-panne-im-tunnel'} = ['ratgeber','Panne im Tunnel'];
$CRUMB_PARENT{'ratgeber-umweltzone-koeln'} = ['ratgeber','Umweltzone Köln'];
$CRUMB_PARENT{'ratgeber-abschleppen-koeln-kosten'} = ['ratgeber','Kosten in Köln'];
$CRUMB_LABEL{'home'} = 'Start';

sub service_ld {
  my ($slug,$name,$curl,$areas)=@_;
  my $ar = join(',', map { '{"@type":"City","name":"'.$_.'"}' } @$areas);
  $name =~ s/"/\\"/g;
  return '<script type="application/ld+json">{"@context":"https://schema.org","@type":"Service","name":"'.$name.'","serviceType":"Abschleppdienst und Pannenhilfe","url":"'.$curl.'","provider":{"@type":"Organization","name":"Faster Abschleppdienst","telephone":"+4917641956993","email":"faster@takeldienstfaster.be"},"areaServed":['.$ar.'],"availableLanguage":["de","nl","fr","en"]}</script>'."\n";
}
sub article_ld {
  my ($name,$curl)=@_; $name =~ s/"/\\"/g;
  return '<script type="application/ld+json">{"@context":"https://schema.org","@type":"Article","headline":"'.$name.'","inLanguage":"de","mainEntityOfPage":"'.$curl.'","publisher":{"@type":"Organization","name":"Faster Abschleppdienst"}}</script>'."\n";
}

# wipe old flat pages in the repo root (new pages are written as folder/index.html)
unlink glob("$OUT/*.html");

for my $slug (@order) {
  my $p=$P{$slug}; my $body=$p->{body};
  my $path = path_for($slug); my $region = region_for($path);
  my $wa = ($region eq 'koeln') ? $WA : 'https://wa.me/4917641956993?text=Hallo%20Faster%2C%20ich%20brauche%20Hilfe%20mit%20meinem%20Fahrzeug.';
  $body =~ s/\@\@CTA\@\@/related_for($slug).cta_for($slug)/ge;
  $body =~ s/Wir nennen Ihnen den Preis, bevor jemand losfährt\./Wir besprechen Ihre Situation und sagen Ihnen, wie es weitergeht./ if $region eq 'koeln';
  $body =~ s/\@\@WA\@\@/$wa/g;
  # header with region menu
  my $menu = join('', map { sprintf('<a href="%s.html">%s</a>', $_->[1], $_->[0]) } @{$MENU{$region}});
  my $hd = $header; $hd =~ s/\@\@MENU\@\@/$menu/; $hd =~ s/\@\@WA\@\@/$wa/g;
  # PREVIEW MODE: every page is hidden from search engines until launch (remove this line's noindex to go live)
  my $robots = qq{<meta name="robots" content="noindex, nofollow">\n};
  # title / description (max 60 / 155 characters)
  my $suffix = ' | Faster Abschleppdienst';
  my $tt = $p->{title}; $tt =~ s/ \| Faster (Abschleppdienst|Depannage Takeldienst)$//;
  $tt .= $suffix if plainlen($tt.$suffix) <= 60;
  my $curl  = $path eq '' ? $BASE : "$BASE$path/";
  my $canon = qq{<link rel="canonical" href="$curl">\n};
  my $og = qq{<meta property="og:type" content="website"><meta property="og:locale" content="de_DE"><meta property="og:site_name" content="Faster Abschleppdienst"><meta property="og:title" content="$tt"><meta property="og:description" content="$p->{desc}"><meta property="og:url" content="$curl"><meta property="og:image" content="${BASE}assets/faster-road-transport.jpg">\n};
  # structured data: Service (service pages) or Article (guides), FAQPage, BreadcrumbList. No LocalBusiness / no German address.
  my $json = '';
  (my $h1 = ($body =~ m{<h1[^>]*>(.*?)</h1>}s ? $1 : $tt)) =~ s/<[^>]+>//g; $h1 =~ s/&amp;/&/g;
  my $areas_txt = ($body =~ m{<!--AREAS: (.*?) -->}) ? $1 : ($region eq 'koeln' ? 'Köln' : $region eq 'karlsruhe' ? 'Karlsruhe, Baden-Baden, Achern, Offenburg' : 'Köln, Karlsruhe, Offenburg');
  my @areas = split /, /, $areas_txt;
  $body =~ s/<!--AREAS: .*? -->\n?//;
  if ($slug =~ /^ratgeber-/) { $json .= article_ld($h1,$curl); }
  elsif ($slug !~ /^(ratgeber|kontakt|impressum|datenschutz|danke)$/) { $json .= service_ld($slug,$h1,$curl,\@areas); }
  my @qa;
  while ($body =~ m{<details><summary>(.*?)</summary><div>(.*?)</div></details>}sg) {
    push @qa, '{"@type":"Question","name":"'.jesc($1).'","acceptedAnswer":{"@type":"Answer","text":"'.jesc($2).'"}}';
  }
  $json .= '<script type="application/ld+json">{"@context":"https://schema.org","@type":"FAQPage","mainEntity":['.join(',',@qa).']}</script>'."\n" if @qa;
  # breadcrumbs
  my $crumbs = ''; my $bcjson = '';
  if ($slug ne 'home' && $CRUMB_PARENT{$slug}) {
    my ($par,$lab) = @{$CRUMB_PARENT{$slug}}; my @chain = ([$slug,$lab]);
    while ($par && $par ne 'home') { my $pp = $CRUMB_PARENT{$par}; unshift @chain, [$par, $pp ? $pp->[1] : $CRUMB_LABEL{$par}]; $par = $pp ? $pp->[0] : undef; }
    unshift @chain, ['home','Start'];
    my (@li,@jl); my $i=0;
    for my $c (@chain) { $i++; my ($cs,$cl)=@$c; my $cp = path_for($cs); my $u = $cp eq '' ? $BASE : "$BASE$cp/";
      (my $lj=$cl) =~ s/&amp;/&/g; $lj =~ s/"/\\"/g;
      push @jl, qq({"\@type":"ListItem","position":$i,"name":"$lj","item":"$u"});
      push @li, $i==@chain ? qq{<span aria-current="page">$cl</span>} : sprintf('<a href="%s.html">%s</a>', $cs, $cl); }
    $crumbs = '<nav class="crumbs" aria-label="Brotkrumen"><div class="wrap">'.join(' &rsaquo; ',@li)."</div></nav>\n";
    $bcjson = '<script type="application/ld+json">{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":['.join(',',@jl).']}</script>'."\n";
  }
  $json .= $bcjson;
  push @SITEMAP, [$curl,$slug] unless $slug eq 'danke';
  warn "TITLE>60 ($slug): ".plainlen($tt)." $tt\n" if plainlen($tt) > 60;
  warn "DESC>155 ($slug): ".plainlen($p->{desc})."\n" if plainlen($p->{desc}) > 155;
  my $html = qq{<!doctype html>\n<html lang="de">\n<head>\n<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">\n<title>$tt</title>\n<meta name="description" content="$p->{desc}">\n$robots$canon$og<meta name="theme-color" content="#121212">\n<link rel="icon" href="assets/favicon.ico" sizes="any"><link rel="icon" type="image/png" sizes="32x32" href="assets/favicon-32.png"><link rel="apple-touch-icon" href="assets/apple-touch-icon.png">\n<link rel="stylesheet" href="styles.css">\n$json</head>\n<body>\n$hd<main>\n$crumbs$body</main>\n$footer</body>\n</html>\n};
  $html =~ s/<\/head>/<!-- GSC-VERIFICATION -->\n<\/head>/ if $slug eq 'home';
  $html = fix_links($html,$path);
  my $dir = $path eq '' ? $OUT : "$OUT/$path";
  require File::Path; File::Path::make_path($dir);
  open(my $o,'>:raw',"$dir/index.html") or die "cannot write $dir"; print $o $html; close $o; print "wrote /$path\n";
}

{
  my $x = qq{<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n};
  for my $u (@SITEMAP) { $x .= "  <url><loc>$u->[0]</loc><lastmod>$TODAY</lastmod></url>\n"; }
  $x .= "</urlset>\n";
  open(my $sm,'>:raw',"$OUT/sitemap.xml") or die; print $sm $x; close $sm; print "wrote sitemap.xml (".scalar(@SITEMAP)." urls)\n";
}

__DATA__
=== index | Abschleppdienst Köln – Pannenhilfe &amp; Abschleppen | Abschleppdienst und Pannenhilfe für Köln und Umgebung: Pkw, Transporter, Motorräder. 24/7 per Telefon und WhatsApp erreichbar. Partner vor Ort. | index ===
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
<details><summary>Wo sitzt Faster, und wer fährt in Köln?</summary><div>Faster hat seinen Sitz in Antwerpen (Belgien). In Köln und Umgebung arbeiten wir mit Partnern zusammen, die den Einsatz vor Ort übernehmen. Sie erreichen uns rund um die Uhr; wir koordinieren die Hilfe.</div></details>
<details><summary>Welche Sprachen sprechen Sie?</summary><div>Deutsch, Niederländisch, Französisch und Englisch.</div></details>
</div></section>
<section class="cta"><div class="wrap cta-in"><div><h2>Panne in Köln?</h2><p>Rufen Sie an oder schreiben Sie per WhatsApp. Wir sind 24/7 erreichbar.</p></div><div class="actions"><a class="btn btn-dark" href="@@WA@@" target="_blank" rel="noopener">WhatsApp</a><a class="btn btn-out" href="tel:+4917641956993">+49 176 41956993</a></div></div></section>
=== pannenhilfe-koeln | Pannenhilfe Köln | Faster Abschleppdienst | Pannenhilfe in Köln und Umgebung: Batterie, Reifen, Startprobleme, ausgesperrt, falsch getankt. 24/7 erreichbar per Telefon und WhatsApp. | page ===
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
=== abschleppen-bergung-koeln | Abschleppen und Bergung Köln | Abschleppen und Bergung in Köln nach Panne, Unfall oder Schaden. Transport zur Werkstatt oder zum Wunschziel, für Pkw, Transporter, Motorräder. | page ===
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
=== kontakt | Kontakt &amp; Anfrage | Faster Abschleppdienst | Abschleppdienst Köln kontaktieren: per Telefon, WhatsApp oder Formular. Faster Abschleppdienst. | page ===
<section class="page-head"><div class="wrap narrow"><p class="eyebrow">Kontakt</p><h1>Hilfe anfordern</h1><p class="lead">Dringend? Rufen Sie an oder schreiben Sie per WhatsApp und senden Sie Ihren Standort.</p></div></section>
<section class="section"><div class="wrap split">
<div class="copy"><h2>So erreichen Sie uns</h2>
<p><a class="btn btn-wa" href="@@WA@@" target="_blank" rel="noopener">WhatsApp schreiben</a></p>
<p><a class="btn btn-y" href="tel:+4917641956993">+49 176 41956993 anrufen</a></p>
<p><strong>E-Mail:</strong> <a href="mailto:faster@takeldienstfaster.be">faster@takeldienstfaster.be</a></p>
<p><strong>Sitz:</strong><br>Faster Abschleppdienst<br>De Bosschaertstraat 248<br>2020 Antwerpen, Belgien</p>
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
=== impressum | Impressum | Faster Abschleppdienst | Anbieterkennzeichnung von Faster Abschleppdienst. | noindex ===
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
=== datenschutz | Datenschutzerklärung | Faster Abschleppdienst | Datenschutzerklärung dieser Website. | noindex ===
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
=== danke | Vielen Dank | Faster Abschleppdienst | Ihre Anfrage wurde gesendet. | noindex ===
<section class="page-head"><div class="wrap narrow"><h1>Vielen Dank für Ihre Anfrage</h1><p class="lead">Wir melden uns so schnell wie möglich. Bei dringenden Fällen erreichen Sie uns jederzeit per Telefon oder WhatsApp.</p><p><a class="btn btn-y" href="index.html">Zur Startseite</a></p></div></section>
