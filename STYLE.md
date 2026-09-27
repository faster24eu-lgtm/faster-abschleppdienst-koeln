# STYLE – abschleppdienst-faster.de

## How the site is built
Static site, generated. **Never edit the HTML files**; edit the sources and run `perl _build/build.pl` (Perl, no dependencies).

| What | Where |
|---|---|
| Builder (template, header/footer, JSON-LD, breadcrumbs, sitemap, Bundesland hubs, service/nearby blocks) | `_build/build.pl` |
| Page content, one marker line per page: `=== slug \| title \| description \| flag ===` | `_build/content/*.txt` (city/Autobahn pages: `geo_NNN.txt`) |
| Page list for Germany-wide pages: `slug<TAB>label<TAB>group<TAB>kind` (group = Bundesland, kind `ab` = Autobahn) | `_build/content/geo.txt` |
| Neighbour cities + Autobahn links per city page | `_build/content/geo_nb.txt` |
| Bundesland intro texts | `_build/content/bundeslaender.txt` |
| "Weiterlesen" blocks | `_build/content/related.txt` |
| Styles | `styles.css` (one file, no framework) |
| Checks | `scripts/audit.pl`, `scripts/check_similarity.pl` |

Adding a city: append the page to a new `geo_NNN.txt` (start with `=== stadt-<slug> | title | description | page ===`, then `<!--AREAS: … -->`, the body, and `@@CTA@@` at the end), add one line to `geo.txt`, add neighbours to `geo_nb.txt`, run the build, run both scripts, commit.

URLs: city `/staedte/<slug>/`, Autobahn `/autobahnen/<a-nummer>/`, Bundesland `/bundeslaender/<slug>/`, guides `/ratgeber/<slug>/`. Slug rules: lowercase, ä→ae, ö→oe, ü→ue, ß→ss, hyphens. All internal links are relative (`slug.html` in the sources is rewritten to relative folder URLs by the builder).

## Page structure (city page)
1. `page-head`: eyebrow, H1 "Abschleppdienst <Stadt>", lead (2 sentences), WhatsApp + phone button.
2. Copy sections (H2 each): city facts (Stadtbezirke/Stadtteile, Einwohnerzahl only if sourced), the roads that matter (Autobahn with Kreuze/Dreiecke, Schnellstraßen, Bundesstraßen, bridges, tunnels, ring roads), a local feature that affects the location description (rivers, Altstadt, ports, hills), "Was wir in <Stadt> tun" (rotating variants, generated), "So nennen Sie Ihren Standort" (bullet list).
3. Generated blocks (builder): services block (6 variants, links to /ratgeber/ articles), "In der Nähe von <Stadt>" (neighbour cities, Bundesland hub, Autobahn pages).
4. FAQ (`<details>` → FAQPage JSON-LD): 4 city-specific questions plus generated "Was kostet Abschleppen in <Stadt>?" and "Helfen Sie auch in <Nachbarort>?".
5. CTA block, footer.

JSON-LD (builder): Service (provider Organization with phone/e-mail, areaServed from the `<!--AREAS-->` comment plus neighbour cities), FAQPage, BreadcrumbList Start › Bundesland › Stadt. No LocalBusiness with a German address.
Length: about 650–950 words of main text.

## Tone
German, "Sie", calm and practical, short sentences. Say what the reader should do and what to tell us on the phone. No marketing words, no emoji, no superlatives without a source.

## Hard content rules
- Faster sits in Antwerpen (Belgien); jobs are done by partner companies on site. Never claim a local office, own fleet, own driver in a city, or a specific arrival time.
- No prices, ratings, reviews, customer counts, years in business, certifications, response times.
- Facts only from sources we checked (German Wikipedia extracts, official pages). If unsure, leave it out and note it in `SEO-ROADMAP.md` for the owner.
- No claims about Umweltzonen/Fahrverbote unless verified (Berlin and München are worded as such).
- Site stays `noindex, nofollow`; `robots.txt` stays `Disallow: /` until the owner decides (see LAUNCH-CHECKLIST.md).
- Do not edit `/impressum/` or `/datenschutz/` content.

## Breakdown-on-Autobahn safety wording (vary per page, never copy identically)
Warnblinker an, Warnweste anziehen, alle Insassen aussteigen und hinter die Leitplanke gehen, Warndreieck aufstellen (nur wenn es gefahrlos geht), Notrufsäule oder Notruf 112 bei Gefahr, dann uns anrufen und Autobahn, Fahrtrichtung, Kilometer oder Ausfahrt nennen. Long version: `/ratgeber/panne-autobahn/`.

## Phone / contact
+49 176 41956993 (`tel:+4917641956993`, `wa.me/4917641956993`), faster@takeldienstfaster.be. The WhatsApp pre-fill text is generic (no city).
