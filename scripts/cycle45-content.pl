# One-off content pass of cycle 45 (2026-10-18): answers the Search Console queries of the pages closest to page 1.
# Each edit is a literal replace that must match exactly once; the script dies otherwise (so it cannot run twice).
use strict; use warnings;
my $R=shift // '.';
my @E=(
# ---------- Automatik: overview table, link to the Notentriegelung guide, two FAQs for "wie schleppt man..." / "kann ein Automatik..."
['ratgeber/automatik-abschleppen/index.html','<h2>Wenn der Wählhebel klemmt</h2>',
 '<h2>Auf einen Blick: welches Getriebe, welche Lösung?</h2>
<div class="tblwrap"><table class="tbl"><thead><tr><th>Fahrzeug</th><th>Mit Seil oder Stange?</th><th>Besser</th></tr></thead><tbody>
<tr><td>Klassische Automatik (Wandler)</td><td>Meist kurz möglich: Stellung N, langsam, nur bis zur nächsten Werkstatt</td><td>Für längere Strecken verladen</td></tr>
<tr><td>Doppelkupplungsgetriebe (z.&nbsp;B. DSG)</td><td>Hersteller nennen oft besonders enge Grenzen</td><td>Betriebsanleitung prüfen, im Zweifel verladen</td></tr>
<tr><td>Stufenloses Getriebe (CVT)</td><td>Oft nur sehr eingeschränkt</td><td>Betriebsanleitung prüfen, im Zweifel verladen</td></tr>
<tr><td>Allradantrieb</td><td>Bei vielen Modellen nicht erlaubt</td><td>Auf der Ladefläche transportieren</td></tr>
<tr><td>Hybrid und Elektroauto</td><td>Nein</td><td>Auf der Ladefläche transportieren</td></tr>
<tr><td>Wählhebel steckt in P fest</td><td>Erst nach Notentriegelung</td><td>Notentriegelung oder Verladen</td></tr>
</tbody></table></div>
<h2>Wenn der Wählhebel klemmt</h2>'],
['ratgeber/automatik-abschleppen/index.html','Die Betriebsanleitung beschreibt sie.',
 'Die Betriebsanleitung beschreibt sie. Wo sie bei den gängigen Marken sitzt, steht im Ratgeber <a href="../../ratgeber/automatik-notentriegelung/">Automatik auf N stellen ohne Strom</a>.'],
['ratgeber/automatik-abschleppen/index.html','<details><summary>Kann ich ein Automatikauto mit Seil abschleppen?</summary>',
 '<details><summary>Wie schleppt man ein Automatikauto ab?</summary><div>Betriebsanleitung prüfen, Zündung einschalten, Wählhebel auf N, Seil oder Stange an den Abschleppösen befestigen, Warnblinker an beiden Fahrzeugen. Dann langsam (oft höchstens 50&nbsp;km/h) auf direktem Weg zur nächsten Werkstatt. Für längere Strecken lassen Sie das Auto verladen.</div></details>
<details><summary>Kann jedes Automatikauto abgeschleppt werden?</summary><div>Nein. Bei vielen Allradfahrzeugen, bei Hybrid- und Elektroautos und wenn sich der Wählhebel nicht auf N stellen lässt, sollte das Auto nicht mit drehenden Rädern gezogen werden. Dann ist der Transport auf einem Abschleppwagen der richtige Weg.</div></details>
<details><summary>Kann ich ein Automatikauto mit Seil abschleppen?</summary>'],

# ---------- Wohnmobil: queries are "wohnmobil abschleppdienst", "wohnmobil abschleppen", "wohnwagen abschleppen"
['ratgeber/wohnmobil-gespann-panne/index.html','<title>Wohnmobil oder Gespann liegengeblieben: was gilt</title>','<title>Wohnmobil abschleppen: Panne mit Wohnmobil oder Gespann</title>'],
['ratgeber/wohnmobil-gespann-panne/index.html','<meta property="og:title" content="Wohnmobil oder Gespann liegengeblieben: was gilt">','<meta property="og:title" content="Wohnmobil abschleppen: Panne mit Wohnmobil oder Gespann">'],
['ratgeber/wohnmobil-gespann-panne/index.html','<meta name="description" content="Wohnmobil, Wohnwagen oder Gespann mit Panne: Gewichtsgrenze 3,5 Tonnen, Abkoppeln, Sicherung und welche Angaben für die Bergung zählen.">',
 '<meta name="description" content="Wohnmobil oder Wohnwagen abschleppen lassen: 3,5-Tonnen-Grenze, Abkoppeln, Sicherung und welche Angaben der Abschleppdienst braucht.">'],
['ratgeber/wohnmobil-gespann-panne/index.html','<h1>Wohnmobil oder Gespann liegengeblieben</h1>','<h1>Wohnmobil abschleppen: Panne mit Wohnmobil oder Gespann</h1>'],
['ratgeber/wohnmobil-gespann-panne/index.html','<h2>Diese Angaben helfen uns</h2>',
 '<h2>Wohnmobil abschleppen lassen: so läuft es</h2>
<p>Ein Wohnmobil wird in der Regel nicht am Seil gezogen. Je nach Gewicht, Länge und Antrieb wird es auf ein Fahrzeug mit Ladefläche verladen oder an einer Achse angehoben und geschleppt. Entscheidend ist die zulässige Gesamtmasse: Bis 3,5 Tonnen reicht oft ein Abschleppwagen wie für einen Transporter, darüber braucht es ein schwereres Bergefahrzeug. Deshalb fragen wir am Telefon zuerst nach Gewicht, Länge und Höhe. Den Preis nennen wir Ihnen, bevor ein Fahrzeug losfährt.</p>
<h2>Wohnwagen abschleppen</h2>
<p>Ein Wohnwagen ist ein Anhänger. Ist nur das Zugfahrzeug defekt, kann er abgekoppelt und von einem anderen Zugfahrzeug weitergezogen werden, wenn dessen Anhängelast und Ihre Führerscheinklasse dafür reichen. Ist der Wohnwagen selbst beschädigt, etwa an Reifen, Achse oder Deichsel, oder lässt er sich nicht mehr rollen, wird er verladen. Bei einem Reifenschaden hilft vorher der Blick in den Ratgeber <a href="../../ratgeber/reifenpanne/">Reifenpanne</a>.</p>
<h2>Diese Angaben helfen uns</h2>'],
['ratgeber/wohnmobil-gespann-panne/index.html','<details><summary>Kann der Wohnwagen abgekoppelt werden?</summary>',
 '<details><summary>Was kostet es, ein Wohnmobil abschleppen zu lassen?</summary><div>Das hängt vor allem von Gewicht, Länge, Strecke und Uhrzeit ab. Über 3,5 Tonnen ist ein schwereres Fahrzeug nötig, und das wirkt sich auf den Preis aus. Wir nennen Ihnen den Preis am Telefon, bevor wir losfahren. Allgemeine Richtwerte stehen unter <a href="../../ratgeber/abschleppdienst-kosten/">Abschleppkosten</a>.</div></details>
<details><summary>Zahlt der Automobilclub das Abschleppen meines Wohnmobils?</summary><div>Das hängt von Ihrem Tarif ab. Manche Automobilclubs leisten für Fahrzeuge über 3,5 Tonnen keine Pannenhilfe. Prüfen Sie Mitgliedschaft und Schutzbrief, bevor Sie losfahren.</div></details>
<details><summary>Kann der Wohnwagen abgekoppelt werden?</summary>'],

# ---------- Kosten: 158 impressions at position ~52; queries "abschleppkosten", "wie viel kostet ein abschleppdienst" (pos 6), "abschleppkosten rechner"
['ratgeber/abschleppdienst-kosten/index.html','<title>Was kostet ein Abschleppdienst? Richtwerte und Tipps</title>','<title>Abschleppkosten 2026: Was kostet ein Abschleppdienst?</title>'],
['ratgeber/abschleppdienst-kosten/index.html','<meta property="og:title" content="Was kostet ein Abschleppdienst? Richtwerte und Tipps">','<meta property="og:title" content="Abschleppkosten 2026: Was kostet ein Abschleppdienst?">'],
['ratgeber/abschleppdienst-kosten/index.html','<details><summary>Ist Abschleppen nachts teurer?</summary>',
 '<details><summary>Wie viel kostet ein Abschleppdienst?</summary><div>Als grobe Marktrichtwerte für 2026: im Stadtgebiet etwa 89 bis 150&nbsp;€, auf der Autobahn etwa 129 bis 250&nbsp;€, Pannenhilfe vor Ort etwa 59 bis 120&nbsp;€. Der genaue Preis hängt von Strecke, Uhrzeit, Fahrzeug und Aufwand vor Ort ab.</div></details>
<details><summary>Gibt es einen Abschleppkosten-Rechner?</summary><div>Online-Rechner liefern nur grobe Schätzungen, weil der Preis von Strecke, Uhrzeit, Fahrzeug und Aufwand vor Ort abhängt. Verlässlicher ist ein Anruf: Mit Standort, Fahrzeug und Ziel nennen wir Ihnen den Preis, bevor der Abschleppwagen losfährt.</div></details>
<details><summary>Ist Abschleppen nachts teurer?</summary>'],

# ---------- Frankfurt: "pannenhilfe frankfurt" at position 3.6 with 0 clicks -> lead the title/description with it
['staedte/frankfurt/index.html','<title>Abschleppdienst Frankfurt am Main: Pannenhilfe 24/7</title>','<title>Pannenhilfe &amp; Abschleppdienst Frankfurt am Main 24/7</title>'],
['staedte/frankfurt/index.html','<meta property="og:title" content="Abschleppdienst Frankfurt am Main: Pannenhilfe 24/7">','<meta property="og:title" content="Pannenhilfe &amp; Abschleppdienst Frankfurt am Main 24/7">'],
['staedte/frankfurt/index.html','<meta name="description" content="Pannenhilfe und Abschleppen in Frankfurt am Main: 46 Stadtteile, Frankfurter Kreuz, A5, A661, A648 und A66. So nennen Sie Ihren Standort.">',
 '<meta name="description" content="Pannenhilfe in Frankfurt am Main, rund um die Uhr: Abschleppen in 46 Stadtteilen, am Frankfurter Kreuz, auf A5, A661, A648 und A66. Ein Anruf genügt.">'],

# ---------- Pannenhilfe Köln: "pannendienst köln" shows on 8 pages at positions 55-90, none of them is the target -> make this page the target
['koeln/pannenhilfe/index.html','<title>Pannenhilfe Köln: Batterie, Reifen, falsch getankt</title>','<title>Pannenhilfe &amp; Pannendienst Köln: Batterie, Reifen</title>'],
['koeln/pannenhilfe/index.html','<meta property="og:title" content="Pannenhilfe Köln: Batterie, Reifen, falsch getankt">','<meta property="og:title" content="Pannenhilfe &amp; Pannendienst Köln: Batterie, Reifen">'],
['koeln/pannenhilfe/index.html','<meta name="description" content="Pannenhilfe in Köln: Batterie, Reifen, ausgesperrt, falsch getankt.',
 '<meta name="description" content="Pannendienst in Köln: Batterie, Reifen, ausgesperrt, falsch getankt.'],
['koeln/pannenhilfe/index.html','<p class="lead">Nicht jede Panne braucht einen Abschleppwagen.',
 '<p class="lead">Unser Pannendienst in Köln kommt zu Ihnen, denn nicht jede Panne braucht einen Abschleppwagen.'],
);
my %buf;
for my $e(@E){ my($f,$old,$new)=@$e; unless(exists $buf{$f}){ local $/; open my $i,'<:raw',"$R/$f" or die "$f: $!"; $buf{$f}=<$i> }
  my $n=()=$buf{$f}=~/\Q$old\E/g; die "$f: expected 1 match, got $n for: ".substr($old,0,70)."\n" unless $n==1;
  $buf{$f}=~s/\Q$old\E/$new/; }
for my $f(sort keys %buf){ open my $o,'>:raw',"$R/$f" or die; print $o $buf{$f}; print "patched $f\n" }
