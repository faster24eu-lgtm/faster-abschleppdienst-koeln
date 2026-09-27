use strict; use warnings; use FindBin qw($Bin);
binmode(STDOUT,':raw');
my $OUT = "$Bin/..";
my $WA  = 'https://wa.me/4917641956993?text=Hallo%20Faster%2C%20ich%20brauche%20Hilfe%20mit%20meinem%20Fahrzeug.';

my $header = <<'EOT';
<header class="site-header"><div class="wrap nav">
  <a class="brand" href="home.html" aria-label="Faster Abschleppdienst - Startseite"><img src="assets/faster-logo-de-600.png" alt="Faster Abschleppdienst Logo" width="110" height="38"><span><strong>FASTER</strong><small>ABSCHLEPPDIENST &amp; PANNENHILFE</small></span></a>
  <nav class="menu" aria-label="Hauptnavigation">@@MENU@@</nav>
  <div class="nav-cta">@@LANGSWITCH@@<a class="btn btn-wa" href="@@WA@@" target="_blank" rel="noopener">WhatsApp</a><a class="btn btn-y hide-s" href="tel:+4917641956993">+49 176 41956993</a></div>
</div></header>
EOT
my $footer = <<'EOT';
<footer class="site-footer"><div class="wrap foot-grid">
  <div><strong>Faster Abschleppdienst</strong><p>Abschleppdienst und Pannenhilfe in ganz Deutschland, mit Schwerpunkt Köln und Karlsruhe bis Offenburg. Persönlich und rund um die Uhr erreichbar.</p></div>
  <div><strong>Kontakt</strong><p><a href="tel:+4917641956993">+49 176 41956993</a><br><a href="mailto:faster@takeldienstfaster.be">faster@takeldienstfaster.be</a><br>Sitz: De Bosschaertstraat 248<br>2020 Antwerpen, Belgien</p></div>
  <div><strong>Köln</strong><p><a href="index.html">Abschleppdienst Köln</a><br><a href="pannenhilfe-koeln.html">Pannenhilfe Köln</a><br><a href="abschleppen-bergung-koeln.html">Abschleppen &amp; Bergung Köln</a><br><a href="abschleppdienst-koeln-stadtteile.html">Stadtbezirke und Rheinbrücken</a><br><a href="pannenhilfe-koelner-autobahnring.html">Kölner Autobahnring</a><br><a href="pannenhilfe-a3-koeln.html">Panne auf der A3</a><br><a href="pannenhilfe-a4-koeln.html">Panne auf der A4</a><br><a href="pannenhilfe-a1-koeln.html">Panne auf der A1</a></p></div>
  <div><strong>Karlsruhe bis Offenburg</strong><p><a href="abschleppdienst-mittelbaden.html">Übersicht Mittelbaden</a><br><a href="abschleppdienst-karlsruhe.html">Karlsruhe</a><br><a href="abschleppdienst-baden-baden.html">Baden-Baden &amp; Rastatt</a><br><a href="abschleppdienst-achern.html">Achern &amp; Bühl</a><br><a href="abschleppdienst-offenburg.html">Offenburg &amp; Kehl</a><br><a href="abschleppdienst-a5.html">Panne auf der A5</a></p></div>
  <div><strong>Ratgeber &amp; Rechtliches</strong><p><a href="staedte.html">Alle Städte</a><br><a href="bundeslaender.html">Bundesländer</a><br><a href="autobahnen.html">Autobahnen</a><br><a href="ratgeber.html">Alle Ratgeber</a><br><a href="kontakt.html">Kontakt</a><br><a href="impressum.html">Impressum</a><br><a href="datenschutz.html">Datenschutz</a><br><a href="#" onclick="return window.openCookieBanner &amp;&amp; window.openCookieBanner(event)">Cookie-Einstellungen</a></p></div>
</div><div class="wrap foot-bottom">© 2026 Faster Abschleppdienst</div></footer>
EOT
# English mirror of header/footer. Nav/footer links point to en-* pages where they exist yet, otherwise
# fall back to the German page (better than a dead link; swap in as more pages get translated).
my $header_en = <<'EOT';
<header class="site-header"><div class="wrap nav">
  <a class="brand" href="en-home.html" aria-label="Faster Abschleppdienst - Home"><img src="assets/faster-logo-de-600.png" alt="Faster Abschleppdienst Logo" width="110" height="38"><span><strong>FASTER</strong><small>TOWING &amp; ROADSIDE ASSISTANCE</small></span></a>
  <nav class="menu" aria-label="Main navigation">@@MENU@@</nav>
  <div class="nav-cta">@@LANGSWITCH@@<a class="btn btn-wa" href="@@WA@@" target="_blank" rel="noopener">WhatsApp</a><a class="btn btn-y hide-s" href="tel:+4917641956993">+49 176 41956993</a></div>
</div></header>
EOT
my $footer_en = <<'EOT';
<footer class="site-footer"><div class="wrap foot-grid">
  <div><strong>Faster Abschleppdienst</strong><p>Towing and roadside assistance all over Germany, with a focus on Cologne and Karlsruhe to Offenburg. Personal service, reachable around the clock.</p></div>
  <div><strong>Contact</strong><p><a href="tel:+4917641956993">+49 176 41956993</a><br><a href="mailto:faster@takeldienstfaster.be">faster@takeldienstfaster.be</a><br>Registered office: De Bosschaertstraat 248<br>2020 Antwerp, Belgium</p></div>
  <div><strong>Cologne</strong><p><a href="en-index.html">Towing Service Cologne</a><br><a href="en-pannenhilfe-koeln.html">Roadside Assistance Cologne</a><br><a href="en-abschleppen-bergung-koeln.html">Towing &amp; Recovery Cologne</a><br><a href="en-abschleppdienst-koeln-stadtteile.html">Districts &amp; Rhine Bridges</a><br><a href="en-pannenhilfe-koelner-autobahnring.html">Cologne Motorway Ring</a><br><a href="en-pannenhilfe-a3-koeln.html">Breakdown on the A3</a><br><a href="en-pannenhilfe-a4-koeln.html">Breakdown on the A4</a><br><a href="en-pannenhilfe-a1-koeln.html">Breakdown on the A1</a></p></div>
  <div><strong>Karlsruhe to Offenburg</strong><p><a href="en-abschleppdienst-mittelbaden.html">Central Baden Overview</a><br><a href="en-abschleppdienst-karlsruhe.html">Karlsruhe</a><br><a href="en-abschleppdienst-baden-baden.html">Baden-Baden &amp; Rastatt</a><br><a href="en-abschleppdienst-achern.html">Achern &amp; Bühl</a><br><a href="en-abschleppdienst-offenburg.html">Offenburg &amp; Kehl</a><br><a href="en-abschleppdienst-a5.html">Breakdown on the A5</a></p></div>
  <div><strong>Guides &amp; Legal</strong><p><a href="staedte.html">All Cities (German)</a><br><a href="bundeslaender.html">States (German)</a><br><a href="autobahnen.html">Motorways (German)</a><br><a href="ratgeber.html">All Guides (German)</a><br><a href="kontakt.html">Contact</a><br><a href="impressum.html">Legal Notice</a><br><a href="datenschutz.html">Privacy Policy</a><br><a href="#" onclick="return window.openCookieBanner &amp;&amp; window.openCookieBanner(event)">Cookie Settings</a></p></div>
</div><div class="wrap foot-bottom">© 2026 Faster Abschleppdienst</div></footer>
EOT
# Consent Mode default: must be present before the gtag.js loader on every page.
my $consent_default = <<'EOT';
<script>
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('consent', 'default', {
  'ad_storage': 'denied', 'ad_user_data': 'denied', 'ad_personalization': 'denied',
  'analytics_storage': 'denied', 'wait_for_update': 500
});
</script>
EOT
# Google tag (Google Ads AW-10963026341) with call conversion / phone-swap config.
# Phone number below must match the visible text exactly ("+49 176 41956993") for the number-swap to work.
my $gtag_script = <<'EOT';
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-10963026341"></script>
<script>
gtag('js', new Date());
gtag('config', 'AW-10963026341');
gtag('config', 'AW-10963026341/6YcCCJqizocdEKWDyuso', {
  'phone_conversion_number': '+49 176 41956993'
});
</script>
EOT
# Reporting-only click events for phone and WhatsApp links (event delegation, no send_to/conversion label).
my $click_script = <<'EOT';
<script>
document.addEventListener('click', function(e){
  var a = e.target.closest('a[href]'); if (!a) return;
  if (/^tel:/i.test(a.getAttribute('href'))) { gtag('event', 'phone_click', {'event_category': 'contact'}); }
  else if (a.href.indexOf('wa.me') !== -1) { gtag('event', 'whatsapp_click', {'event_category': 'contact'}); }
});
</script>
EOT
# Cookie consent banner (vanilla JS, no libraries). Shown until the visitor accepts or declines; choice is
# stored in localStorage and re-applied silently on later visits. "Cookie-Einstellungen" in the footer reopens it.
my $cookie_banner = <<'EOT';
<div class="cookie-banner" id="cookie-banner" hidden>
  <div class="wrap cookie-in">
    <p>Wir verwenden Cookies von Google, um zu messen, ob unsere Anzeigen zu Anrufen führen. Sie können zustimmen oder ablehnen. Mehr dazu in der <a href="datenschutz.html">Datenschutzerklärung</a>.</p>
    <div class="cookie-actions">
      <button type="button" class="cookie-btn cookie-decline" id="cookie-decline">Ablehnen</button>
      <button type="button" class="cookie-btn cookie-accept" id="cookie-accept">Akzeptieren</button>
    </div>
  </div>
</div>
<script>
(function(){
  var KEY = 'faster_cookie_consent';
  var banner = document.getElementById('cookie-banner');
  function apply(choice){
    if (choice === 'granted') {
      gtag('consent', 'update', {'ad_storage':'granted','ad_user_data':'granted','ad_personalization':'granted','analytics_storage':'granted'});
    } else if (choice === 'denied') {
      gtag('consent', 'update', {'ad_storage':'denied','ad_user_data':'denied','ad_personalization':'denied','analytics_storage':'denied'});
    }
  }
  function stored(){ try { return localStorage.getItem(KEY); } catch(e){ return null; } }
  function store(v){ try { localStorage.setItem(KEY, v); } catch(e){} }
  var choice = stored();
  if (choice) { apply(choice); } else if (banner) { banner.hidden = false; }
  var acc = document.getElementById('cookie-accept'); if (acc) acc.addEventListener('click', function(){ store('granted'); apply('granted'); if (banner) banner.hidden = true; });
  var dec = document.getElementById('cookie-decline'); if (dec) dec.addEventListener('click', function(){ store('denied'); apply('denied'); if (banner) banner.hidden = true; });
  window.openCookieBanner = function(e){ if (e) e.preventDefault(); if (banner) banner.hidden = false; return false; };
})();
</script>
EOT
# English cookie banner — same mechanism/keys, translated text, for pages served under /en/.
my $cookie_banner_en = <<'EOT';
<div class="cookie-banner" id="cookie-banner" hidden>
  <div class="wrap cookie-in">
    <p>We use Google cookies to measure whether our ads lead to calls. You can accept or decline. More in our <a href="datenschutz.html">privacy policy</a>.</p>
    <div class="cookie-actions">
      <button type="button" class="cookie-btn cookie-decline" id="cookie-decline">Decline</button>
      <button type="button" class="cookie-btn cookie-accept" id="cookie-accept">Accept</button>
    </div>
  </div>
</div>
<script>
(function(){
  var KEY = 'faster_cookie_consent';
  var banner = document.getElementById('cookie-banner');
  function apply(choice){
    if (choice === 'granted') {
      gtag('consent', 'update', {'ad_storage':'granted','ad_user_data':'granted','ad_personalization':'granted','analytics_storage':'granted'});
    } else if (choice === 'denied') {
      gtag('consent', 'update', {'ad_storage':'denied','ad_user_data':'denied','ad_personalization':'denied','analytics_storage':'denied'});
    }
  }
  function stored(){ try { return localStorage.getItem(KEY); } catch(e){ return null; } }
  function store(v){ try { localStorage.setItem(KEY, v); } catch(e){} }
  var choice = stored();
  if (choice) { apply(choice); } else if (banner) { banner.hidden = false; }
  var acc = document.getElementById('cookie-accept'); if (acc) acc.addEventListener('click', function(){ store('granted'); apply('granted'); if (banner) banner.hidden = true; });
  var dec = document.getElementById('cookie-decline'); if (dec) dec.addEventListener('click', function(){ store('denied'); apply('denied'); if (banner) banner.hidden = true; });
  window.openCookieBanner = function(e){ if (e) e.preventDefault(); if (banner) banner.hidden = false; return false; };
})();
</script>
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
  for my $name (qw(extra_pages.txt extra_koeln.txt extra_region.txt extra_guides.txt extra_guides2.txt extra_guides3.txt extra_koeln2.txt extra_koeln3.txt extra_koeln4.txt extra_guides4.txt extra_guides5.txt extra_guides6.txt extra_guides7.txt extra_guides8.txt extra_guides9.txt extra_guides10.txt extra_guides11.txt extra_guides12.txt extra_guides13.txt extra_guides14.txt extra_koeln5.txt extra_koeln6.txt extra_guides15.txt extra_home.txt), (map { s{.*/}{}r } sort glob("$Bin/content/geo_*.txt")), qw(extra_ratgeber.txt en_home.txt en_koeln.txt en_region.txt en_koeln2.txt en_guides.txt en_guides2.txt)) {
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
my $BASE = 'https://abschleppdienst-faster.de/';
my $TODAY = sprintf('%04d-%02d-%02d', (localtime)[5]+1900, (localtime)[4]+1, (localtime)[3]);
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
  if ($slug =~ /^en-/) {
    my ($h,$t);
    if ($slug =~ /^en-(index|.*koeln.*)$/) { ($h,$t)=('Broken down in Cologne?','Call us or send your location on WhatsApp.'); }
    elsif ($slug =~ /^en-abschleppdienst-(karlsruhe|baden-baden|achern|offenburg|a5|mittelbaden)$/) { ($h,$t)=('Broken down between Karlsruhe and Offenburg?','Call us or share your location on WhatsApp. We tell you the price before anyone drives out.'); }
    else { ($h,$t)=('Reach us directly','Phone and WhatsApp: available around the clock.'); }
    return qq{<section class="cta"><div class="wrap cta-in"><div><h2>$h</h2><p>$t</p></div><div class="actions"><a class="btn btn-dark" href="\@\@WA\@\@" target="_blank" rel="noopener">Send location on WhatsApp</a><a class="btn btn-out" href="tel:+4917641956993">+49 176 41956993</a></div></div></section>};
  }
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
# ---- English mirror: /en/... — same structure, "en-" prefixed slugs. Add new en-<slug> entries here as pages get translated.
$PATH{'en-home'} = 'en';
$PATH{'en-index'} = 'en/koeln'; $PATH{'en-pannenhilfe-koeln'} = 'en/koeln/pannenhilfe'; $PATH{'en-abschleppen-bergung-koeln'} = 'en/koeln/abschleppen-bergung';
$PATH{'en-pannenhilfe-koelner-autobahnring'} = 'en/koeln/autobahnring'; $PATH{'en-pannenhilfe-a1-koeln'} = 'en/koeln/a1'; $PATH{'en-pannenhilfe-a3-koeln'} = 'en/koeln/a3'; $PATH{'en-pannenhilfe-a4-koeln'} = 'en/koeln/a4';
$PATH{'en-abschleppdienst-koeln-stadtteile'} = 'en/koeln/stadtteile';
$PATH{'en-abschleppdienst-mittelbaden'} = 'en/karlsruhe'; $PATH{'en-abschleppdienst-karlsruhe'} = 'en/karlsruhe/stadt'; $PATH{'en-abschleppdienst-baden-baden'} = 'en/karlsruhe/baden-baden';
$PATH{'en-abschleppdienst-achern'} = 'en/karlsruhe/achern'; $PATH{'en-abschleppdienst-offenburg'} = 'en/karlsruhe/offenburg'; $PATH{'en-abschleppdienst-a5'} = 'en/karlsruhe/a5';
$PATH{"en-koeln-$_"} = "en/koeln/$_" for qw(innenstadt ehrenfeld nippes lindenthal rodenkirchen porz kalk muelheim chorweiler a57 a59 a555 leverkusener-bruecke);
$PATH{'en-ratgeber'} = 'en/ratgeber'; $PATH{'en-kontakt'} = 'en/kontakt';
$PATH{"en-ratgeber-$_"} = "en/ratgeber/$_" for qw(abschleppdienst-kosten panne-autobahn unfall-abschleppkosten e-auto-abschleppen starthilfe-batterie reifenpanne falsch-getankt ausgesperrt motorrad-transport abschleppseil-oder-abschleppdienst warnleuchten-auto motor-ueberhitzt automatik-abschleppen nach-unfall-fahrbereit handbremse-loest-sich-nicht motor-geht-aus transporter-abschleppen);
sub path_for { my $s=shift; return $PATH{$s} if exists $PATH{$s}; return "ratgeber/$1" if $s =~ /^ratgeber-(.+)$/; return $s; }
sub region_for { my $pa=shift; $pa =~ s{^en/}{}; return 'koeln' if $pa =~ m{^koeln}; return 'karlsruhe' if $pa =~ m{^karlsruhe}; return 'shared'; }
sub depth_of { my $pa=shift; return $pa eq '' ? 0 : scalar(split m{/}, $pa); }
sub relurl { my ($from,$to)=@_; my $d=depth_of($from); my $up = $d ? ('../' x $d) : './'; return $to eq '' ? $up : ($d ? $up : './').$to.'/'; }
sub fix_links {
  my ($html,$from)=@_; my $d=depth_of($from); my $R = $d ? ('../' x $d) : '';
  $html =~ s{href="([a-z0-9-]+)\.html((?:\#[^"]*)?)"}{ exists $PATH{$1} || $1 =~ /^(ratgeber-.+|kontakt|impressum|datenschutz|danke)$/ ? 'href="'.relurl($from,path_for($1)).$2.'"' : qq{href="$1.html$2"} }ge;
  $html =~ s{(href|src)="(assets/[^"]+|styles\.css)"}{$1="$R$2"}g;
  return $html;
}
my %MENU = (
  koeln     => [['Köln','index'],['Pannenhilfe','pannenhilfe-koeln'],['Autobahnen','pannenhilfe-koelner-autobahnring'],['Stadtteile','abschleppdienst-koeln-stadtteile'],['Alle Städte','staedte'],['Ratgeber','ratgeber'],['Kontakt','kontakt']],
  karlsruhe => [['Karlsruhe &amp; Mittelbaden','abschleppdienst-mittelbaden'],['Karlsruhe','abschleppdienst-karlsruhe'],['A5','abschleppdienst-a5'],['Alle Städte','staedte'],['Ratgeber','ratgeber'],['Kontakt','kontakt']],
  shared    => [['Köln','index'],['Karlsruhe &amp; Mittelbaden','abschleppdienst-mittelbaden'],['Alle Städte','staedte'],['Ratgeber','ratgeber'],['Kontakt','kontakt']],
);
# English nav (same target pages; "All Cities" falls back to the German page until it's translated too).
my %MENU_EN = (
  koeln     => [['Cologne','en-index'],['Roadside Assistance','en-pannenhilfe-koeln'],['Motorways','en-pannenhilfe-koelner-autobahnring'],['Districts','en-abschleppdienst-koeln-stadtteile'],['All Cities','staedte'],['Guides','en-ratgeber'],['Contact','en-kontakt']],
  karlsruhe => [['Karlsruhe &amp; Central Baden','en-abschleppdienst-mittelbaden'],['Karlsruhe','en-abschleppdienst-karlsruhe'],['A5','en-abschleppdienst-a5'],['All Cities','staedte'],['Guides','en-ratgeber'],['Contact','en-kontakt']],
  shared    => [['Cologne','en-index'],['Karlsruhe &amp; Central Baden','en-abschleppdienst-mittelbaden'],['All Cities','staedte'],['Guides','en-ratgeber'],['Contact','en-kontakt']],
);
$CRUMB_PARENT{'index'} = ['home','Köln &amp; Umgebung'];
$CRUMB_PARENT{'abschleppdienst-mittelbaden'} = ['home','Karlsruhe &amp; Mittelbaden'];
$CRUMB_PARENT{$_} = ['home', {ratgeber=>'Ratgeber',kontakt=>'Kontakt',impressum=>'Impressum',datenschutz=>'Datenschutz'}->{$_}] for qw(ratgeber kontakt impressum datenschutz);
$CRUMB_PARENT{'abschleppdienst-koeln-stadtteile'} = ['index','Stadtbezirke und Rheinbrücken'];
# English breadcrumb parents for the translated pages.
$CRUMB_PARENT{'en-index'} = ['home','Cologne &amp; Area'];
$CRUMB_PARENT{'en-abschleppdienst-mittelbaden'} = ['home','Karlsruhe &amp; Central Baden'];
$CRUMB_PARENT{'en-abschleppdienst-koeln-stadtteile'} = ['en-index','Districts &amp; Rhine Bridges'];
$CRUMB_PARENT{'en-pannenhilfe-koeln'} = ['en-index','Roadside Assistance'];
$CRUMB_PARENT{'en-abschleppen-bergung-koeln'} = ['en-index','Towing &amp; Recovery'];
$CRUMB_PARENT{'en-pannenhilfe-koelner-autobahnring'} = ['en-index','Cologne Motorway Ring'];
$CRUMB_PARENT{'en-pannenhilfe-a1-koeln'} = ['en-pannenhilfe-koelner-autobahnring','A1 Breakdown'];
$CRUMB_PARENT{'en-pannenhilfe-a3-koeln'} = ['en-pannenhilfe-koelner-autobahnring','A3 Breakdown'];
$CRUMB_PARENT{'en-pannenhilfe-a4-koeln'} = ['en-pannenhilfe-koelner-autobahnring','A4 Breakdown'];
$CRUMB_PARENT{'en-abschleppdienst-karlsruhe'} = ['en-abschleppdienst-mittelbaden','Karlsruhe'];
$CRUMB_PARENT{'en-abschleppdienst-baden-baden'} = ['en-abschleppdienst-mittelbaden','Baden-Baden &amp; Rastatt'];
$CRUMB_PARENT{'en-abschleppdienst-achern'} = ['en-abschleppdienst-mittelbaden','Achern &amp; Bühl'];
$CRUMB_PARENT{'en-abschleppdienst-offenburg'} = ['en-abschleppdienst-mittelbaden','Offenburg &amp; Kehl'];
$CRUMB_PARENT{'en-abschleppdienst-a5'} = ['en-abschleppdienst-mittelbaden','A5 Breakdown'];
my %DISTRICT = (innenstadt=>'Innenstadt', ehrenfeld=>'Ehrenfeld', nippes=>'Nippes', lindenthal=>'Lindenthal', rodenkirchen=>'Rodenkirchen', porz=>'Porz', kalk=>'Kalk', muelheim=>'Mülheim', chorweiler=>'Chorweiler');
$CRUMB_PARENT{"koeln-$_"} = ['abschleppdienst-koeln-stadtteile', "Köln-$DISTRICT{$_}"] for keys %DISTRICT;
$CRUMB_PARENT{'koeln-a57'} = ['pannenhilfe-koelner-autobahnring','Panne auf der A57'];
$CRUMB_PARENT{'koeln-a59'} = ['pannenhilfe-koelner-autobahnring','Panne auf der A59'];
$CRUMB_PARENT{'koeln-a555'} = ['pannenhilfe-koelner-autobahnring','Panne auf der A555'];
$CRUMB_PARENT{'koeln-leverkusener-bruecke'} = ['pannenhilfe-koelner-autobahnring','Leverkusener Brücke'];
my %DISTRICT_EN = (innenstadt=>'City Centre', ehrenfeld=>'Ehrenfeld', nippes=>'Nippes', lindenthal=>'Lindenthal', rodenkirchen=>'Rodenkirchen', porz=>'Porz', kalk=>'Kalk', muelheim=>'Mülheim', chorweiler=>'Chorweiler');
$CRUMB_PARENT{"en-koeln-$_"} = ['en-abschleppdienst-koeln-stadtteile', "Cologne-$DISTRICT_EN{$_}"] for keys %DISTRICT_EN;
$CRUMB_PARENT{'en-koeln-a57'} = ['en-pannenhilfe-koelner-autobahnring','A57 Breakdown'];
$CRUMB_PARENT{'en-koeln-a59'} = ['en-pannenhilfe-koelner-autobahnring','A59 Breakdown'];
$CRUMB_PARENT{'en-koeln-a555'} = ['en-pannenhilfe-koelner-autobahnring','A555 Breakdown'];
$CRUMB_PARENT{'en-koeln-leverkusener-bruecke'} = ['en-pannenhilfe-koelner-autobahnring','Leverkusen Bridge'];
$CRUMB_PARENT{'en-ratgeber'} = ['home','Guides']; $CRUMB_PARENT{'en-kontakt'} = ['home','Contact'];
$CRUMB_PARENT{'en-ratgeber-abschleppdienst-kosten'} = ['en-ratgeber','What Does a Towing Service Cost?'];
$CRUMB_PARENT{'en-ratgeber-panne-autobahn'} = ['en-ratgeber','Breaking Down on the Motorway'];
$CRUMB_PARENT{'en-ratgeber-unfall-abschleppkosten'} = ['en-ratgeber','Towing Costs After an Accident'];
$CRUMB_PARENT{'en-ratgeber-e-auto-abschleppen'} = ['en-ratgeber','Towing an Electric Car'];
$CRUMB_PARENT{'en-ratgeber-starthilfe-batterie'} = ['en-ratgeber','Jump-Starting and a Flat Battery'];
$CRUMB_PARENT{'en-ratgeber-reifenpanne'} = ['en-ratgeber','Flat Tyre'];
$CRUMB_PARENT{'en-ratgeber-falsch-getankt'} = ['en-ratgeber','Wrong Fuel'];
$CRUMB_PARENT{'en-ratgeber-ausgesperrt'} = ['en-ratgeber','Locked Out'];
$CRUMB_PARENT{'en-ratgeber-motorrad-transport'} = ['en-ratgeber','Motorcycle Transport'];
$CRUMB_PARENT{'en-ratgeber-abschleppseil-oder-abschleppdienst'} = ['en-ratgeber','Tow Rope or Towing Service?'];
$CRUMB_PARENT{'en-ratgeber-warnleuchten-auto'} = ['en-ratgeber','Warning Lights in Your Car'];
$CRUMB_PARENT{'en-ratgeber-motor-ueberhitzt'} = ['en-ratgeber','Engine Overheating'];
$CRUMB_PARENT{'en-ratgeber-automatik-abschleppen'} = ['en-ratgeber','Towing an Automatic Car'];
$CRUMB_PARENT{'en-ratgeber-nach-unfall-fahrbereit'} = ['en-ratgeber','After the Accident: Still Roadworthy?'];
$CRUMB_PARENT{'en-ratgeber-handbremse-loest-sich-nicht'} = ['en-ratgeber',"Handbrake Won't Release"];
$CRUMB_PARENT{'en-ratgeber-motor-geht-aus'} = ['en-ratgeber','Engine Cutting Out While Driving'];
$CRUMB_PARENT{'en-ratgeber-transporter-abschleppen'} = ['en-ratgeber','Towing a Van'];
$CRUMB_PARENT{'ratgeber-panne-im-tunnel'} = ['ratgeber','Panne im Tunnel'];
$CRUMB_PARENT{'ratgeber-umweltzone-koeln'} = ['ratgeber','Umweltzone Köln'];
$CRUMB_PARENT{'ratgeber-abschleppen-koeln-kosten'} = ['ratgeber','Kosten in Köln'];
$CRUMB_LABEL{'home'} = 'Start';
# ---- Germany-wide layer: content/geo.txt lists city / Autobahn pages (slug<TAB>label<TAB>group). stadt-* -> /staedte/<x>/, autobahn-* -> /autobahnen/<x>/. Hubs are generated. ----
my (@GEO_CITY,@GEO_AB);
{
  $PATH{'staedte'}='staedte'; $PATH{'autobahnen'}='autobahnen';
  $CRUMB_PARENT{'staedte'}=['home','Städte']; $CRUMB_PARENT{'autobahnen'}=['home','Autobahnen'];
  if (open(my $gf,"<:raw","$Bin/content/geo.txt")) {
    while (my $l=<$gf>) { chomp $l; next if $l =~ /^\s*(#|$)/; my ($slug,$label,$group,$kind)=split /\t/,$l;
      next unless $P{$slug};
      (my $lab=$label) =~ s/&/&amp;/g;
      if ($slug =~ /^stadt-(.+)$/)    { $PATH{$slug}="staedte/$1";    $CRUMB_PARENT{$slug}=['staedte',$lab]; }
      elsif ($slug =~ /^autobahn-(.+)$/) { $PATH{$slug}="autobahnen/$1"; $CRUMB_PARENT{$slug}=['autobahnen',$lab]; }
      if (($kind//'') eq 'ab') { push @GEO_AB,[$slug,$lab,$group]; } else { push @GEO_CITY,[$slug,$lab,$group]; }
    }
    close $gf;
  }
  my $tbl = sub { my ($rows,$h1,$h2)=@_; my $t='<div class="tblwrap"><table class="tbl"><thead><tr><th>'.$h1.'</th><th>'.$h2.'</th></tr></thead><tbody>'."\n"; for my $r (@$rows) { $t .= "<tr><td>$r->[0]</td><td>$r->[1]</td></tr>\n" } $t.'</tbody></table></div>' };
  my %by; push @{$by{$_->[2]}}, $_ for @GEO_CITY;
  my @rows; for my $g (sort keys %by) { push @rows, [$g, join(', ', map { qq{<a href="$_->[0].html">$_->[1]</a>} } sort { $a->[1] cmp $b->[1] } @{$by{$g}})]; }
  $P{'staedte'} = { title=>'Abschleppdienst in Deutschland: Städte | Faster Abschleppdienst', desc=>'Abschleppdienst und Pannenhilfe in deutschen Städten: Übersicht nach Bundesland mit Seiten zu Stadtteilen, Autobahnen und Hinweisen für Ihren Standort.', flag=>'hub',
    body=>'<section class="page-head"><div class="wrap narrow"><p class="eyebrow">Deutschlandweit</p><h1>Abschleppdienst in Ihrer Stadt</h1><p class="lead">Zu jeder Stadt in dieser Übersicht gibt es eine eigene Seite mit Stadtteilen, Autobahnen und Hinweisen, wie Sie Ihren Standort beschreiben. Rufen Sie an oder schreiben Sie per WhatsApp: wir organisieren die Hilfe.</p></div></section>'."\n".
    '<section class="section"><div class="wrap narrow copy"><h2>Städte nach Bundesland</h2>'."\n".$tbl->(\@rows,'Bundesland','Städte')."\n".
    '<h2>Ihre Stadt fehlt?</h2><p>Faster hat seinen Sitz in Antwerpen (Belgien). Die Einsätze in Deutschland übernehmen Partner vor Ort. Wenn Ihre Stadt hier noch nicht aufgeführt ist, rufen Sie trotzdem an oder schreiben Sie uns per WhatsApp mit Ihrem Standort: in vielen Fällen können wir auch dort Hilfe organisieren. Auf den <a href="autobahnen.html">Autobahn-Seiten</a> finden Sie Ausfahrten und Hinweise zu den wichtigsten Strecken.</p>'."\n".'</div></section>'."\n".'@@CTA@@'."\n" };
  push @order,'staedte' unless grep { $_ eq 'staedte' } @order;
  my @abr = map { [$_->[2], qq{<a href="$_->[0].html">$_->[1]</a>}] } sort { $a->[2] cmp $b->[2] || $a->[1] cmp $b->[1] } @GEO_AB;
  $P{'autobahnen'} = { title=>'Pannenhilfe auf deutschen Autobahnen | Faster Abschleppdienst', desc=>'Panne auf der Autobahn in Deutschland: Seiten zu einzelnen Autobahnen mit Ausfahrten, Rastanlagen und Hinweisen, was bei einer Panne zu tun ist.', flag=>'hub',
    body=>'<section class="page-head"><div class="wrap narrow"><p class="eyebrow">Deutschlandweit</p><h1>Pannenhilfe auf der Autobahn</h1><p class="lead">Wer auf der Autobahn liegen bleibt, muss schnell sagen können, wo er steht. Zu den Strecken in dieser Übersicht finden Sie Ausfahrten, Kreuze und Hinweise für Ihre Standortangabe.</p></div></section>'."\n".
    '<section class="section"><div class="wrap narrow copy"><h2>Autobahnen und Abschnitte</h2>'."\n".$tbl->(\@abr,'Autobahn','Seite')."\n".
    '<p>Allgemeine Schritte bei einer Panne, von Warnblinker bis Notrufsäule, finden Sie im <a href="ratgeber-panne-autobahn.html">Ratgeber zur Panne auf der Autobahn</a>. Die Einsätze übernehmen Partner vor Ort, Faster (Antwerpen, Belgien) koordiniert die Hilfe.</p>'."\n".'</div></section>'."\n".'@@CTA@@'."\n" };
  push @order,'autobahnen' unless grep { $_ eq 'autobahnen' } @order;
}
# ---- Layer 2: Bundesland hubs (/bundeslaender/), neighbour + services blocks on city pages, /staedte/ index with search ----
{
  my $blslug = sub { my $s = lc shift; $s =~ s/\xc3\xa4/ae/g; $s =~ s/\xc3\xb6/oe/g; $s =~ s/\xc3\xbc/ue/g; $s =~ s/\xc3\x9f/ss/g; $s =~ s/[^a-z0-9]+/-/g; $s =~ s/^-|-$//g; $s };
  my $esc = sub { my $s = shift; $s =~ s/&(?!amp;)/&amp;/g; $s };
  my %BYST; push @{$BYST{$_->[2]}}, $_ for @GEO_CITY;
  my %LABEL = map { $_->[0] => $_->[1] } @GEO_CITY;
  my %STATE = map { $_->[0] => $_->[2] } @GEO_CITY;
  my %INTRO;
  if (open(my $sf,'<:raw',"$Bin/content/bundeslaender.txt")) { my $k; while (my $l=<$sf>) { if ($l =~ /^=== (.+?) ===\s*$/) { $k=$1; next } $INTRO{$k} .= $l if defined $k } close $sf }
  my $wabtn = '<p><a class="btn btn-wa" href="@@WA@@" target="_blank" rel="noopener">WhatsApp mit Standort</a> <a class="btn btn-y" href="tel:+4917641956993">+49 176 41956993</a></p>';
  # Bundesland hubs
  my @states = sort keys %BYST;
  for my $name (@states) {
    my $sl = $blslug->($name); my $slug = "bl-$sl"; $PATH{$slug} = "bundeslaender/$sl"; $CRUMB_PARENT{$slug} = ['home', $esc->($name)];
    my $n = $esc->($name); my @c = sort { $a->[1] cmp $b->[1] } @{$BYST{$name}};
    my $links = join(', ', map { qq{<a href="$_->[0].html">$_->[1]</a>} } @c);
    my $intro_raw = $INTRO{$name} // '';
    my ($intro, $extra_faq) = split /\@\@FAQ\@\@\n/, $intro_raw, 2; $intro //= ''; $extra_faq //= '';
    my $cnt = scalar(@c);
    $P{$slug} = { title => "Abschleppdienst in $n: Städte, Autobahnen | Faster Abschleppdienst",
      desc => "Pannenhilfe und Abschleppen in $n: Städte mit eigenen Seiten, wichtige Autobahnen und Hinweise, wie Sie Ihren Standort nennen.", flag => 'hub',
      body => qq{<!--AREAS: $n -->\n<section class="page-head"><div class="wrap narrow"><p class="eyebrow">Bundesland</p><h1>Abschleppdienst in $n</h1><p class="lead">Pannenhilfe und Abschleppen in $n: Zu den Städten unten gibt es eigene Seiten mit Stadtteilen, Straßen und Hinweisen für Ihren Standort. Rufen Sie an oder schreiben Sie per WhatsApp.</p>$wabtn</div></section>\n<section class="section"><div class="wrap narrow copy">\n$intro<h2>Städte in $n mit eigener Seite</h2>\n<p>$links</p>\n<p>Insgesamt sind es derzeit $cnt Seiten in $n. Weitere Städte in ganz Deutschland finden Sie unter <a href="staedte.html">Abschleppdienst in Ihrer Stadt</a>, alle Bundesländer unter <a href="bundeslaender.html">Bundesländer</a>, die Autobahnen unter <a href="autobahnen.html">Pannenhilfe auf der Autobahn</a>.</p>\n<h2>So läuft es ab in $n</h2>\n<p>Sie rufen an oder schreiben per WhatsApp und schicken Ihren Standort. Wir fragen kurz nach Fahrzeug, Problem und Ziel, suchen dann einen Partner in $n und nennen Ihnen den Preis, bevor jemand losfährt. Der Partner kommt, schleppt ab oder hilft direkt vor Ort. Faster hat seinen Sitz in Antwerpen (Belgien), gefahren wird von einem Partnerbetrieb vor Ort.</p>\n</div></section>\n<section class="section grey"><div class="wrap narrow"><h2>Häufige Fragen zu $n</h2>\n$extra_faq<details><summary>Für welche Städte in $n gibt es eigene Seiten?</summary><div>Aktuell für $cnt Orte, sie stehen oben in der Liste. Auch für alle anderen Orte in $n können Sie uns anrufen: Wir klären dann, welcher Partner in Frage kommt.</div></details>\n<details><summary>Was kostet Abschleppen in $n?</summary><div>Einen festen Preis nennen wir nicht, weil er von Fahrzeug, Uhrzeit, Strecke und Aufwand abhängt. Am Telefon nennen wir Ihnen den Preis, bevor jemand losfährt.</div></details>\n<details><summary>Was tue ich zuerst, wenn ich auf der Autobahn in $n liegen bleibe?</summary><div>Warnblinker einschalten, Warnweste anziehen, alle aussteigen und hinter die Leitplanke gehen, Warndreieck aufstellen, dann uns anrufen. Nennen Sie Autobahn, Fahrtrichtung und Kilometer oder Ausfahrt.</div></details>\n</div></section>\n\@\@CTA\@\@\n} };
    push @order, $slug unless grep { $_ eq $slug } @order;
  }
  # Bundeslaender index
  $PATH{'bundeslaender'} = 'bundeslaender'; $CRUMB_PARENT{'bundeslaender'} = ['home','Bundesländer'];
  { my $rows = join('', map { my $nm=$_; my $sl=$blslug->($nm); my $c=scalar(@{$BYST{$nm}}); '<li><a href="bl-'.$sl.'.html">'.$esc->($nm)."</a> ($c)</li>\n" } @states);
    $P{'bundeslaender'} = { title => 'Abschleppdienst nach Bundesland | Faster Abschleppdienst', desc => 'Abschleppdienst und Pannenhilfe in allen Bundesländern: Übersicht mit Städten, Autobahnen und Hinweisen für Ihren Standort.', flag => 'hub',
      body => qq{<section class="page-head"><div class="wrap narrow"><p class="eyebrow">Deutschlandweit</p><h1>Abschleppdienst nach Bundesland</h1><p class="lead">Wählen Sie Ihr Bundesland. Dort finden Sie die Städte mit eigenen Seiten und die wichtigsten Autobahnen.</p></div></section>\n<section class="section"><div class="wrap narrow copy"><ul class="citylist" style="columns:2">\n$rows</ul>\n<p>Alle Städte alphabetisch nach Bundesland: <a href="staedte.html">Abschleppdienst in Ihrer Stadt</a>. Die Autobahnen: <a href="autobahnen.html">Pannenhilfe auf der Autobahn</a>.</p></div></section>\n\@\@CTA\@\@\n} };
    push @order, 'bundeslaender'; }
  # /staedte/ index grouped by Bundesland with search
  { my $sec = join('', map { my $nm=$_; my $sl=$blslug->($nm); '<div class="cityblock"><h2><a href="bl-'.$sl.'.html">'.$esc->($nm).'</a></h2><ul class="citylist">'.join('', map { qq{<li><a href="$_->[0].html">$_->[1]</a></li>} } sort { $a->[1] cmp $b->[1] } @{$BYST{$nm}})."</ul></div>\n" } @states);
    my $js = q{<script>(function(){var q=document.getElementById('cityq');if(!q){return;}var items=document.querySelectorAll('.citylist li');var blocks=document.querySelectorAll('.cityblock');q.addEventListener('input',function(){var v=q.value.trim().toLowerCase();for(var i=0;i<items.length;i++){items[i].style.display=(!v||items[i].textContent.toLowerCase().indexOf(v)>-1)?'':'none';}for(var j=0;j<blocks.length;j++){var lis=blocks[j].querySelectorAll('li');var any=false;for(var k=0;k<lis.length;k++){if(lis[k].style.display!=='none'){any=true;}}blocks[j].style.display=any?'':'none';}});})();</script>};
    $P{'staedte'}{body} = qq{<section class="page-head"><div class="wrap narrow"><p class="eyebrow">Deutschlandweit</p><h1>Abschleppdienst in Ihrer Stadt</h1><p class="lead">Zu jeder Stadt in dieser Übersicht gibt es eine eigene Seite mit Stadtteilen, Autobahnen und Hinweisen, wie Sie Ihren Standort beschreiben. Rufen Sie an oder schreiben Sie per WhatsApp: wir organisieren die Hilfe.</p></div></section>\n<section class="section"><div class="wrap narrow copy"><p><label for="cityq"><strong>Stadt suchen</strong></label><br><input class="citysearch" id="cityq" type="search" placeholder="Stadt eingeben, zum Beispiel Kassel" autocomplete="off"></p>\n$sec<h2>Ihre Stadt fehlt?</h2><p>Faster hat seinen Sitz in Antwerpen (Belgien). Die Einsätze in Deutschland übernehmen Partner vor Ort. Wenn Ihre Stadt hier noch nicht aufgeführt ist, rufen Sie trotzdem an oder schreiben Sie uns per WhatsApp mit Ihrem Standort: wir klären dann, welcher Partner in Frage kommt. Auf den <a href="autobahnen.html">Autobahn-Seiten</a> finden Sie Ausfahrten und Hinweise zu den wichtigsten Strecken, die Bundesländer finden Sie unter <a href="bundeslaender.html">Bundesländer</a>.</p>\n</div></section>\n$js\n\@\@CTA\@\@\n};  }
  # city pages: crumbs -> Bundesland, neighbours, services block, extra FAQ
  my %NB; if (open(my $nf,'<:raw',"$Bin/content/geo_nb.txt")) { while (my $l=<$nf>) { chomp $l; next if $l =~ /^\s*(#|$)/; my ($s,$n,$a)=split /\t/,$l; $NB{$s}=[$n//'',$a//''] } close $nf }
  my $tok = sub { my $t=shift; return 'index' if $t eq 'koeln'; return 'abschleppdienst-karlsruhe' if $t eq 'karlsruhe'; return "stadt-$t" };
  my $abslug = sub { my $t=shift; return 'autobahn-a5-hessen-baden' if $t eq 'a5'; return "autobahn-$t" };
  for my $c (@GEO_CITY) {
    my ($slug,$lab,$state) = @$c; next unless $slug =~ /^stadt-/;
    my $ssl = $blslug->($state);
    $CRUMB_PARENT{$slug} = ["bl-$ssl", $lab];
    $CRUMB_PARENT{"bl-$ssl"} = ['home', $esc->($state)];
    my $b = $P{$slug}{body}; my $v = 0; my $hsum = 0; $hsum = ($hsum*31 + ord($_)) % 1000003 for split //, $slug; $v = $hsum % 6; my $w = int($hsum/7) % 8; my $x = int($hsum/13) % 3;
    my @nbs = grep { $_ ne $slug && $P{$_} } map { $tok->($_) } split /,/, ($NB{$slug}[0] // '');
    @nbs = @nbs[0..7] if @nbs > 8;
    my @abs = grep { $P{$_} } map { $abslug->($_) } split /,/, ($NB{$slug}[1] // '');
    my $nblinks = join(', ', map { qq{<a href="$_.html">}.($LABEL{$_} // $_).'</a>' } @nbs);
    my $ablinks = join(', ', map { my $t=$_; $t =~ s/^autobahn-//; $t =~ s/-.*//; qq{<a href="$_.html">Pannenhilfe auf der A}.substr($t,1).'</a>' } @abs);
    # varied "So läuft es ab" paragraph (4 steps), headings and FAQ wording to keep city pages distinct
    my @tun = (
      "Erstens: Sie rufen an oder schreiben per WhatsApp und schicken Ihren Standort. Zweitens: Wir fragen kurz nach Fahrzeug, Problem und Ziel. Drittens: Wir finden einen Partner in der Nähe von $lab und nennen Ihnen den Preis, bevor jemand losfährt. Viertens: Der Partner kommt, schleppt ab oder hilft direkt vor Ort.",
      "So läuft es ab: Anruf oder WhatsApp mit Standort, dann klären wir Fahrzeug, Problem und Ziel. Danach suchen wir für $lab einen passenden Partner und sagen Ihnen den Preis am Telefon, bevor er losfährt. Zum Schluss übernimmt der Partner vor Ort, ob Abschleppen oder Pannenhilfe.",
      "Vier Schritte bis zur Hilfe in $lab: Sie melden sich mit Ihrem Standort, wir fragen nach Fahrzeug, Problem und Ziel, wir vermitteln einen Partner in der Region und nennen den Preis vorab, und der Partner fährt vor, um abzuschleppen oder direkt zu helfen.",
      "Melden Sie sich per Telefon oder WhatsApp und schicken Sie Ihren Standort. Wir fragen nach Fahrzeug, Problem und Zielort, suchen dann einen Partner in $lab und nennen Ihnen den Preis, bevor jemand losfährt. Der Partner übernimmt anschließend Abschleppen oder Pannenhilfe vor Ort.",
      "In $lab läuft es so: Erst Anruf oder WhatsApp mit Standort, dann ein paar Fragen zu Fahrzeug, Problem und Ziel, danach die Vermittlung an einen Partner in der Region mit Preisangabe vorab, und schließlich die Hilfe oder das Abschleppen vor Ort.",
      "Sie kontaktieren uns mit Ihrem Standort, wir klären Fahrzeug, Problem und Ziel, organisieren einen Partner für $lab und sagen Ihnen den Preis, bevor die Fahrt losgeht. Vor Ort übernimmt der Partner dann das Abschleppen oder die Pannenhilfe.",
      "Der Ablauf in vier Schritten: Kontakt mit Standort per Telefon oder WhatsApp, kurze Fragen zu Fahrzeug, Problem und Ziel, Vermittlung eines Partners in der Nähe von $lab samt Preis vorab, und zuletzt die Hilfe oder das Abschleppen durch den Partner.",
      "Zuerst schicken Sie uns Ihren Standort per Anruf oder WhatsApp. Dann fragen wir nach Fahrzeug, Problem und Ziel. Anschließend suchen wir einen Partner in $lab und nennen den Preis, bevor er fährt. Am Ende steht die Hilfe oder das Abschleppen vor Ort.",
    );
    my @tunh = ("So läuft es ab in $lab", "In 4 Schritten zur Hilfe in $lab", "So läuft ein Einsatz in $lab ab", "Der Ablauf in $lab");
    my @nenn = ("So nennen Sie Ihren Standort in $lab", "Standort in $lab richtig angeben", "Was wir von Ihnen wissen müssen");
    $b =~ s{<h2>Was wir in [^<]+ tun</h2>\s*<p>.*?</p>}{'<h2>'.$tunh[int($hsum/11) % 4].'</h2><p>'.$tun[$w].'</p>'}se;
    $b =~ s{<h2>So nennen Sie Ihren Standort in [^<]+</h2>}{'<h2>'.$nenn[$x].'</h2>'}se;
    my $svc;
    {
      my $LK = sub { my ($u,$t)=@_; qq{<a href="$u.html">$t</a>} };
      my @head = ("Was wir in $lab koordinieren","Abschleppen und Pannenhilfe in $lab","Wobei wir Ihnen in $lab helfen","Unsere Leistungen für $lab");
      my @intro = ("Sie rufen an oder schreiben per WhatsApp, wir klären Fahrzeug, Standort und Ziel und organisieren einen Partner in Ihrer Nähe.",
        "Für $lab läuft es so: Sie schildern uns die Lage, wir suchen einen Partner in der Umgebung und nennen Ihnen den Preis, bevor er losfährt.",
        "Was ist passiert, wo stehen Sie, wohin soll das Fahrzeug? Mit diesen drei Antworten können wir in $lab einen Partnerbetrieb beauftragen.",
        "Bleibt Ihr Fahrzeug in $lab liegen, ist der erste Schritt ein Anruf. Danach vermitteln wir einen Betrieb, der zu Fahrzeug und Situation passt.",
        "");
      my @ia = ("Abschleppen und Transport zur Werkstatt oder nach Hause (".$LK->('ratgeber-abschleppdienst-kosten','Was kostet ein Abschleppdienst?').")",
        "Wenn das Fahrzeug nicht mehr fahren kann: Abschleppen oder Transport auf der Ladefläche, Hintergründe unter ".$LK->('ratgeber-abschleppdienst-kosten','Kosten eines Abschleppdienstes'),
        "Bergung und Transport in die Werkstatt Ihrer Wahl, siehe ".$LK->('ratgeber-abschleppdienst-kosten','Was kostet ein Abschleppdienst?'));
      my @ib = ("Pannenhilfe wie ".$LK->('ratgeber-starthilfe-batterie','Starthilfe')." und ".$LK->('ratgeber-reifenpanne','Reifenpanne'),
        "Leere Batterie (".$LK->('ratgeber-starthilfe-batterie','Starthilfe').") oder platter Reifen (".$LK->('ratgeber-reifenpanne','Reifenpanne').")",
        "Hilfe bei ".$LK->('ratgeber-starthilfe-batterie','Starthilfe')."-Fällen und bei einer ".$LK->('ratgeber-reifenpanne','Reifenpanne'));
      my @ic = ("Abtransport nach einem Unfall, dazu ".$LK->('ratgeber-unfall-abschleppkosten','Abschleppkosten nach einem Unfall'),
        "Fahrzeuge nach einem Unfallschaden, ".$LK->('ratgeber-unfall-abschleppkosten','wer die Kosten trägt'),
        "Unfallfahrzeuge, siehe ".$LK->('ratgeber-unfall-abschleppkosten','Kosten nach einem Unfall'));
      my @id = ($LK->('ratgeber-e-auto-abschleppen','E-Autos').", ".$LK->('ratgeber-motorrad-transport','Motorräder')." und ".$LK->('ratgeber-transporter-abschleppen','Transporter bis 3,5 t'),
        "Besondere Fahrzeuge: ".$LK->('ratgeber-e-auto-abschleppen','Elektroauto').", ".$LK->('ratgeber-motorrad-transport','Motorrad').", ".$LK->('ratgeber-transporter-abschleppen','Transporter'),
        "Auch für ".$LK->('ratgeber-e-auto-abschleppen','Elektroautos').", ".$LK->('ratgeber-motorrad-transport','Motorräder')." und ".$LK->('ratgeber-transporter-abschleppen','Transporter')." bis 3,5 Tonnen");
      my @close = ("Die Einsätze fährt ein Partner vor Ort, wir koordinieren ihn und nennen Ihnen den Preis am Telefon, bevor jemand losfährt.",
        "Der Preis hängt von Fahrzeug, Zeit und Strecke ab, Sie erfahren ihn vor der Abfahrt.",
        "Wer bei Ihnen ankommt, ist ein Partnerbetrieb in der Region. Wir bleiben bis zum Schluss Ihr Ansprechpartner.",
        "Ob Tag oder Nacht: Rufen Sie an, wir sind rund um die Uhr erreichbar.",
        "");
      my $hi = int($hsum/3)%5; my $ha = int($hsum/5)%3; my $hb = int($hsum/7)%3; my $hc = int($hsum/11)%3; my $hd = int($hsum/13)%3; my $he = int($hsum/17)%5; my $hh = int($hsum/23)%4;
      $svc = '<h2>'.$head[$hh].'</h2>'.($intro[$hi] ne '' ? '<p>'.$intro[$hi].'</p>' : '')
        .'<ul class="ticks"><li>'.$ia[$ha].'</li><li>'.$ib[$hb].'</li><li>'.$ic[$hc].'</li><li>'.$id[$hd].'</li></ul>'
        .($close[$he] ne '' ? '<p>'.$close[$he].'</p>' : '');
    }
    my $near = '<h2>In der Nähe von '.$lab.'</h2><p>'.($nblinks ? ($v==1 ? "Ebenfalls mit eigener Seite: $nblinks. " : "Nachbarstädte mit eigener Seite: $nblinks. ") : '').'Übersicht für das Bundesland: <a href="bl-'.$ssl.'.html">Abschleppdienst in '.$esc->($state).'</a>.'.($ablinks ? ($v==2 ? " Passende Autobahnen: $ablinks." : " Autobahnseiten zur Strecke: $ablinks.") : '').'</p>';
    my $blk = $svc.$near;
    my $m1 = "</div></section>\n<section class=\"section grey\">"; my $i1 = index($b,$m1);
    if ($i1 >= 0) { substr($b,$i1,0) = $blk; } else { warn "no marker in $slug\n"; }
    my $nb1 = $nbs[0] ? ($LABEL{$nbs[0]} // '') : '';
    my @cost = ('Einen festen Preis nennen wir hier nicht, weil er von Fahrzeug, Uhrzeit, Strecke und Aufwand abhängt. Am Telefon nennen wir Ihnen den Preis, bevor jemand losfährt.','Pauschal lässt sich das nicht sagen: Fahrzeugtyp, Tageszeit, Entfernung zum Ziel und der Aufwand vor Ort bestimmen den Preis. Sie erfahren ihn am Telefon, bevor ein Fahrzeug zu Ihnen losfährt.','Der Preis hängt davon ab, was am Fahrzeug zu tun ist, wann und wohin es gebracht wird. Wir nennen ihn Ihnen vor der Abfahrt, damit Sie entscheiden können.');
    my $faq = qq{<details><summary>Was kostet Abschleppen in $lab?</summary><div>$cost[int($hsum/17) % 3]</div></details>\n};
    my @hlp = ("Wir organisieren Einsätze in der Region um $lab. Nennen Sie uns Ort und Straße, am besten mit Ihrem Standort per WhatsApp, dann klären wir, welcher Partner in Frage kommt.","Rufen Sie an und sagen Sie uns, wo Sie stehen. Wir prüfen, welcher Partner rund um $lab den Einsatz übernehmen kann, und melden uns mit dem Preis, bevor jemand losfährt.","Das hängt vom genauen Ort ab. Schicken Sie uns Ihren Standort per WhatsApp oder rufen Sie an, dann klären wir die Anfahrt mit einem Partner in der Nähe."); $faq .= qq{<details><summary>Helfen Sie auch in der Umgebung, zum Beispiel in $nb1?</summary><div>$hlp[int($hsum/19) % 3]</div></details>\n} if $nb1;
    my $m2 = "</div></section>\n\@\@CTA\@\@"; my $i2 = rindex($b,$m2);
    if ($i2 >= 0) { substr($b,$i2,0) = $faq; } else { warn "no faq marker in $slug\n"; }
    my $nbl = join(', ', map { ($LABEL{$_} // $_) } @nbs); $nbl =~ s/<[^>]+>//g;
    $b =~ s/<!--AREAS: (.*?) -->/'<!--AREAS: '.$1.($nbl ? ', '.$nbl : '').' -->'/e;
    $P{$slug}{body} = $b;
  }
}

sub service_ld {
  my ($slug,$name,$curl,$areas,$is_en)=@_;
  my $ar = join(',', map { '{"@type":"City","name":"'.$_.'"}' } @$areas);
  $name =~ s/"/\\"/g;
  my $stype = $is_en ? 'Towing and roadside assistance' : 'Abschleppdienst und Pannenhilfe';
  return '<script type="application/ld+json">{"@context":"https://schema.org","@type":"Service","name":"'.$name.'","serviceType":"'.$stype.'","url":"'.$curl.'","provider":{"@type":"Organization","name":"Faster Abschleppdienst","telephone":"+4917641956993","email":"faster@takeldienstfaster.be"},"areaServed":['.$ar.'],"availableLanguage":["de","nl","fr","en"]}</script>'."\n";
}
sub article_ld {
  my ($name,$curl,$is_en)=@_; $name =~ s/"/\\"/g;
  return '<script type="application/ld+json">{"@context":"https://schema.org","@type":"Article","headline":"'.$name.'","inLanguage":"'.($is_en?'en':'de').'","mainEntityOfPage":"'.$curl.'","publisher":{"@type":"Organization","name":"Faster Abschleppdienst"}}</script>'."\n";
}

# wipe old flat pages in the repo root (new pages are written as folder/index.html)
unlink glob("$OUT/*.html");

# Bilingual pairing: any "en-<slug>" page automatically links back to and from its German original "<slug>",
# provided that page exists. Add a page here (en_home.txt / en_koeln.txt / en_region.txt / future en_*.txt)
# and this pairing — and the language-switch button — pick it up with no further wiring.
my %TRANSLATE;
for my $s (@order) {
  next unless $s =~ /^en-(.+)$/;
  my $base = $1;
  next unless $P{$base};
  $TRANSLATE{$base} = $s; $TRANSLATE{$s} = $base;
}

for my $slug (@order) {
  my $p=$P{$slug}; my $body=$p->{body};
  my $path = path_for($slug); my $region = region_for($path);
  my $is_en = ($slug =~ /^en-/) ? 1 : 0;
  my $wa = ($region eq 'koeln') ? $WA : 'https://wa.me/4917641956993?text=Hallo%20Faster%2C%20ich%20brauche%20Hilfe%20mit%20meinem%20Fahrzeug.';
  $body =~ s/\@\@CTA\@\@/related_for($slug).cta_for($slug)/ge;
  $body =~ s/Wir nennen Ihnen den Preis, bevor jemand losfährt\./Wir besprechen Ihre Situation und sagen Ihnen, wie es weitergeht./ if $region eq 'koeln' && !$is_en;
  $body =~ s/\@\@WA\@\@/$wa/g;
  # language switch: German pages link to their translated en- counterpart if one exists yet (else fall back
  # to the English homepage, so the button always works); English pages always link back to their German original.
  my $counterpart = $TRANSLATE{$slug};
  my ($switch_slug, $switch_label) = $is_en ? ($counterpart, 'DE') : ($counterpart // 'en-home', 'EN');
  my $langswitch = qq{<a class="btn-lang" href="$switch_slug.html" aria-label="}.($is_en ? 'Auf Deutsch anzeigen' : 'View in English').qq{">$switch_label</a>};
  # header with region menu (English pages get the English nav labels, same target region)
  my $menuset = $is_en ? $MENU_EN{$region} : $MENU{$region};
  my $menu = join('', map { sprintf('<a href="%s.html">%s</a>', $_->[1], $_->[0]) } @$menuset);
  my $hdr = $is_en ? $header_en : $header;
  $hdr =~ s/\@\@MENU\@\@/$menu/; $hdr =~ s/\@\@WA\@\@/$wa/g; $hdr =~ s/\@\@LANGSWITCH\@\@/$langswitch/;
  my $ftr = $is_en ? $footer_en : $footer;
  my $cbanner = $is_en ? $cookie_banner_en : $cookie_banner;
  # Site is live: pages are indexable unless their marker's flag is explicitly "noindex" (impressum, datenschutz, danke).
  my $robots = (($p->{flag}//'') eq 'noindex') ? qq{<meta name="robots" content="noindex, nofollow">\n} : '';
  # title / description (max 60 / 155 characters)
  my $suffix = ' | Faster Abschleppdienst';
  my $tt = $p->{title}; $tt =~ s/ \| Faster (Abschleppdienst|Depannage Takeldienst)$//;
  $tt .= $suffix if plainlen($tt.$suffix) <= 60;
  my $curl  = $path eq '' ? $BASE : "$BASE$path/";
  my $canon = qq{<link rel="canonical" href="$curl">\n};
  my $og = qq{<meta property="og:type" content="website"><meta property="og:locale" content="}.($is_en?'en_US':'de_DE').qq{"><meta property="og:site_name" content="Faster Abschleppdienst"><meta property="og:title" content="$tt"><meta property="og:description" content="$p->{desc}"><meta property="og:url" content="$curl"><meta property="og:image" content="${BASE}assets/faster-road-transport.jpg">\n};
  # hreflang: only emitted for pages that are part of a real translation pair (not the en-home fallback case).
  my $hreflang = '';
  if ($counterpart) {
    my $cpath = path_for($counterpart); my $curl2 = $cpath eq '' ? $BASE : "$BASE$cpath/";
    my ($de_url,$en_url) = $is_en ? ($curl2,$curl) : ($curl,$curl2);
    $hreflang = qq{<link rel="alternate" hreflang="de" href="$de_url">\n<link rel="alternate" hreflang="en" href="$en_url">\n<link rel="alternate" hreflang="x-default" href="$de_url">\n};
  }
  # structured data: Service (service pages) or Article (guides), FAQPage, BreadcrumbList. No LocalBusiness / no German address.
  my $json = '';
  (my $h1 = ($body =~ m{<h1[^>]*>(.*?)</h1>}s ? $1 : $tt)) =~ s/<[^>]+>//g; $h1 =~ s/&amp;/&/g;
  my $areas_txt = ($body =~ m{<!--AREAS: (.*?) -->}) ? $1 : ($region eq 'koeln' ? 'Köln' : $region eq 'karlsruhe' ? 'Karlsruhe, Baden-Baden, Achern, Offenburg' : 'Köln, Karlsruhe, Offenburg');
  my @areas = split /, /, $areas_txt;
  $body =~ s/<!--AREAS: .*? -->\n?//;
  if ($slug =~ /^ratgeber-/) { $json .= article_ld($h1,$curl,$is_en); }
  elsif ($slug !~ /^(ratgeber|kontakt|impressum|datenschutz|danke)$/) { $json .= service_ld($slug,$h1,$curl,\@areas,$is_en); }
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
    unshift @chain, [($is_en ? 'en-home' : 'home'), $is_en ? 'Home' : 'Start'];
    my (@li,@jl); my $i=0;
    for my $c (@chain) { $i++; my ($cs,$cl)=@$c; my $cp = path_for($cs); my $u = $cp eq '' ? $BASE : "$BASE$cp/";
      (my $lj=$cl) =~ s/&amp;/&/g; $lj =~ s/"/\\"/g;
      push @jl, qq({"\@type":"ListItem","position":$i,"name":"$lj","item":"$u"});
      push @li, $i==@chain ? qq{<span aria-current="page">$cl</span>} : sprintf('<a href="%s.html">%s</a>', $cs, $cl); }
    $crumbs = '<nav class="crumbs" aria-label="'.($is_en?'Breadcrumb':'Brotkrumen').'"><div class="wrap">'.join(' &rsaquo; ',@li)."</div></nav>\n";
    $bcjson = '<script type="application/ld+json">{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":['.join(',',@jl).']}</script>'."\n";
  }
  $json .= $bcjson;
  push @SITEMAP, [$curl,$slug] unless $slug eq 'danke';
  warn "TITLE>60 ($slug): ".plainlen($tt)." $tt\n" if plainlen($tt) > 60;
  warn "DESC>155 ($slug): ".plainlen($p->{desc})."\n" if plainlen($p->{desc}) > 155;
  my $html = qq{<!doctype html>\n<html lang="}.($is_en?'en':'de').qq{">\n<head>\n<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">\n<title>$tt</title>\n<meta name="description" content="$p->{desc}">\n$robots$canon$hreflang$og<meta name="theme-color" content="#121212">\n<link rel="icon" href="assets/favicon.ico" sizes="any"><link rel="icon" type="image/png" sizes="32x32" href="assets/favicon-32.png"><link rel="apple-touch-icon" href="assets/apple-touch-icon.png">\n<link rel="stylesheet" href="styles.css">\n$consent_default$gtag_script$click_script$json</head>\n<body>\n$hdr<main>\n$crumbs$body</main>\n$ftr$cbanner</body>\n</html>\n};
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
<h2>Verantwortlich für den Inhalt nach § 18 Abs. 2 MStV</h2>
<p><mark>[Name des Geschäftsführers ergänzen]</mark><br>De Bosschaertstraat 248<br>2020 Antwerpen, Belgien</p>
<p class="fine">Hinweis: Bitte lassen Sie das Impressum vor der Veröffentlichung von einer fachkundigen Person prüfen.</p>
</div></section>
=== datenschutz | Datenschutzerklärung | Faster Abschleppdienst | Datenschutzerklärung dieser Website. | noindex ===
<section class="page-head"><div class="wrap narrow"><h1>Datenschutzerklärung</h1></div></section>
<section class="section"><div class="wrap narrow copy">
<p><mark>ENTWURF: Bitte vor der Veröffentlichung von einer fachkundigen Person prüfen lassen und die markierten Angaben ergänzen.</mark></p>
<h2>1. Verantwortlicher</h2>
<p><mark>[Firmenname]</mark>, De Bosschaertstraat 248, 2020 Antwerpen, Belgien. E-Mail: <a href="mailto:faster@takeldienstfaster.be">faster@takeldienstfaster.be</a>, Telefon: +49 176 41956993.</p>
<h2>2. Hosting</h2>
<p>Diese Website wird über GitHub Pages bereitgestellt, einen Dienst der GitHub, Inc., 88 Colin P. Kelly Jr. Street, San Francisco, CA 94107, USA. Beim Aufruf der Seiten verarbeitet GitHub technisch notwendige Daten, insbesondere Ihre IP-Adresse, Datum und Uhrzeit des Zugriffs sowie den verwendeten Browser, in Server-Logdateien. Rechtsgrundlage ist Art. 6 Abs. 1 lit. f DSGVO (berechtigtes Interesse an einer funktionsfähigen und sicheren Website). Dabei ist eine Übermittlung personenbezogener Daten in die USA nicht ausgeschlossen; GitHub, Inc. ist unter dem EU-US Data Privacy Framework zertifiziert, das ein angemessenes Datenschutzniveau vorsieht. Weitere Informationen finden Sie in der <a href="https://docs.github.com/en/site-policy/privacy-policies/github-general-privacy-statement" target="_blank" rel="noopener">Datenschutzerklärung von GitHub</a>.</p>
<h2>3. Kontaktformular</h2>
<p>Wenn Sie das Formular nutzen, werden Ihre Angaben über den Dienst FormSubmit.co per E-Mail an uns übermittelt und ausschließlich zur Bearbeitung Ihrer Anfrage verwendet. Rechtsgrundlage ist Art. 6 Abs. 1 lit. b bzw. lit. f DSGVO. FormSubmit.co hat seinen Sitz außerhalb der EU.</p>
<h2>4. Kontakt per Telefon, E-Mail und WhatsApp</h2>
<p>Wenn Sie uns anrufen, eine E-Mail schreiben oder den WhatsApp-Link nutzen, verarbeiten wir die dabei mitgeteilten Daten (bei WhatsApp auch Ihren Standort, wenn Sie ihn senden) ausschließlich zur Bearbeitung Ihrer Anfrage. Rechtsgrundlage ist Art. 6 Abs. 1 lit. b DSGVO (vorvertragliche Maßnahme bzw. Vertragserfüllung). WhatsApp wird von der Meta Platforms Ireland Limited betrieben; für die Nutzung von WhatsApp gelten zusätzlich dessen eigene Datenschutzbestimmungen, auf deren Inhalt wir keinen Einfluss haben.</p>
<h2>5. Google Ads: Conversion- und Anruf-Tracking</h2>
<p>Auf dieser Website ist der Google-Tag von Google Ads eingebunden (Anbieter: Google Ireland Limited, Gordon House, Barrow Street, Dublin 4, Irland). Damit messen wir, ob der Besuch einer Google-Anzeige zu einem Telefonanruf führt: Die im Text sichtbare Telefonnummer wird dazu im Browser durch eine Google-Rufnummer ersetzt, über die der Anruf weiterhin bei uns ankommt; zusätzlich erfassen wir anonym, ob auf die Telefonnummer oder den WhatsApp-Button geklickt wurde. Diese Verarbeitungen finden nur statt, wenn Sie zuvor über den Cookie-Banner zugestimmt haben; ohne Ihre Einwilligung bleibt das Tracking deaktiviert. Rechtsgrundlage ist Ihre Einwilligung nach Art. 6 Abs. 1 lit. a DSGVO in Verbindung mit § 25 Abs. 1 TDDDG. Dabei kann es zu einer Datenübermittlung an Google in die USA kommen. Sie können Ihre Einwilligung jederzeit mit Wirkung für die Zukunft über den Link „Cookie-Einstellungen“ im Footer dieser Seite widerrufen oder ändern.</p>
<h2>6. Ihre Rechte</h2>
<p>Sie haben das Recht auf Auskunft, Berichtigung, Löschung, Einschränkung der Verarbeitung, Datenübertragbarkeit und Widerspruch sowie das Recht, sich bei einer Datenschutzaufsichtsbehörde zu beschweren, in Belgien bei der Gegevensbeschermingsautoriteit (Autorité de protection des données).</p>
<h2>7. Speicherdauer</h2>
<p>Wir speichern personenbezogene Daten aus Ihrer Anfrage nur so lange, wie es zu deren Bearbeitung erforderlich ist, und löschen sie anschließend, soweit keine gesetzlichen Aufbewahrungspflichten entgegenstehen. Ihre Cookie-Entscheidung wird ausschließlich in Ihrem eigenen Browser (localStorage) gespeichert, nicht auf unseren Servern.</p>
</div></section>
=== danke | Vielen Dank | Faster Abschleppdienst | Ihre Anfrage wurde gesendet. | noindex ===
<section class="page-head"><div class="wrap narrow"><h1>Vielen Dank für Ihre Anfrage</h1><p class="lead">Wir melden uns so schnell wie möglich. Bei dringenden Fällen erreichen Sie uns jederzeit per Telefon oder WhatsApp.</p><p><a class="btn btn-y" href="index.html">Zur Startseite</a></p></div></section>
