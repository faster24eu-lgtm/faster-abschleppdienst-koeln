# Faster – Abschleppdienst Köln (deutsche Website, lokales Abschleppen)

Eigenständige statische Website (HTML/CSS, kein Build), getrennt von [takeldienstfaster.be](https://takeldienstfaster.be) und getrennt von der Transport-Seite `faster-koeln`. Sie richtet sich an Kunden in **Köln und Umgebung**, die einen **Abschleppdienst / Pannenhilfe** suchen.

## Vorschau-Modus

Die Seite ist als **Vorschau** online und für Suchmaschinen gesperrt (`noindex, nofollow` auf jeder Seite, `robots.txt` mit `Disallow: /`). Vor dem echten Start beides entfernen (Zeile "PREVIEW MODE" im Baukasten bzw. `<meta name="robots">` in den Seiten und `robots.txt`).

## Wichtig: Was diese Seite (noch) nicht behauptet

Faster hat seinen Sitz in Antwerpen (Belgien). Die Seite nennt deshalb bewusst **keine Adresse in Köln, keine Anfahrtszeit und kein „vor Ort in 30 Minuten“**. Solche Aussagen sind in Deutschland irreführend (UWG), wenn sie nicht stimmen, und ein Google-Unternehmensprofil in Köln setzt einen echten Standort voraus. Die Texte sagen nur, was auf der Hauptseite belegt ist: 24/7 erreichbar, Preis vorab, Pkw/Transporter bis 3,5 t, Motorräder, Maschinen.

## Vor der Veröffentlichung klären (Pflicht)

1. **Einsatz in Köln:** Erledigt. Die Einsätze übernehmen Partner vor Ort, Faster koordiniert (steht so in der FAQ). Bitte nur veröffentlichen, wenn die Partner das mittragen.
2. **Telefonnummer:** Es steht die belgische Nummer +32 3 375 67 37. Eine deutsche Nummer würde die Erreichbarkeit für Kunden in Köln verbessern.
3. **Impressum** (§ 5 DDG): Für eine öffentliche deutsche Geschäftsseite ist es Pflicht (Name, Rechtsform, Anschrift, Kontakt, Unternehmens- und USt-Nummer). Ohne diese Angaben drohen Abmahnungen. Im Vorschau-Modus ist das unkritisch, vor dem echten Start nicht.
4. **Datenschutzerklärung** prüfen lassen und Hosting-Anbieter eintragen.
5. **Texte gegenlesen** (idealerweise Muttersprachler). Alles ist neu formulierter Entwurf.
6. **Formular aktivieren:** Beim ersten Absenden schickt FormSubmit eine Aktivierungs-E-Mail an faster24eu@gmail.com.
7. **Domain festlegen**, dann `canonical`, `sitemap.xml` und Open-Graph-Angaben ergänzen (bewusst noch nicht enthalten).

## Tracking
Kein Google-Tag, keine Cookies. Für Google Ads in Deutschland wäre vorher eine Einwilligungsabfrage nötig.

## Seiten
`index.html` (Abschleppdienst Köln), `pannenhilfe-koeln.html`, `abschleppen-bergung-koeln.html`, `kontakt.html`, `impressum.html` und `datenschutz.html` (Entwürfe, noindex), `danke.html` (noindex).

## Veröffentlichen
Reines Static-Hosting, z. B. GitHub Pages (Settings → Pages → Branch `main`, Ordner `/`). Kostenlose GitHub Pages brauchen ein öffentliches Repository.
