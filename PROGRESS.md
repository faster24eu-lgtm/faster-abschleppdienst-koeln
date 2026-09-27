# PROGRESS

Session goal: cover all of Germany with unique, factual pages (see COVERAGE.md). Log per cycle: SEO-ROADMAP.md (owner check lists live there).

## Decisions
- No Python on this machine: the checks are Perl (`scripts/audit.pl`, `scripts/check_similarity.pl`). Similarity = shared word 5-grams of the smaller page, threshold 30 %, run over `staedte/*` and `autobahnen/*`.
- The generator already existed (Perl); existing pages were not rewritten. New shared blocks (services, neighbours, extra FAQ, Bundesland breadcrumbs) are generated per city page with several variants chosen by a hash of the slug.
- City pages keep the URL `/staedte/<slug>/`; breadcrumb is Start › Bundesland › Stadt; the Bundesland hub is `/bundeslaender/<slug>/`.
- WhatsApp pre-fill text made generic (it used to say "in Köln").
- Time-sensitive facts (construction status, closures) are worded "nach der genutzten Quelle" and listed under "Owner check" in SEO-ROADMAP.md.
- Site remains noindex / Disallow. Impressum and Datenschutz untouched.

## Status (2026-09-27, latest batch: Marl, Dorsten, Lippstadt, Castrop-Rauxel, Arnsberg, Rheine, Goslar, Wolfenbüttel, Hameln, Hof, Ansbach, Wittenberg)
- 370 built pages (audit: 0 errors, 0 broken links, click depth ≤ 3; similarity: 0 pairs above 30 %, max ~29 % city/city, ~13 % Autobahn/Autobahn).
- Breakdown: 216 city/district pages (incl. 12 Berlin Bezirke), 68 Autobahn pages, 16 Bundesland hubs + index, 36 Ratgeber guides (8 expanded to 800–950 words), 21 Köln pages, 6 Karlsruhe pages, plus home, hubs, Kontakt, Danke, Impressum, Datenschutz.
- Correction: until 06:00 the geo.txt rows of 54 newer Autobahn pages lacked the kind column `ab`, so the builder also generated 54 thin `/bundeslaender/aNN/` hub pages and listed the Autobahnen under `/staedte/`. Fixed (commit "Fix: mark Autobahn rows…"); earlier page totals in this log (e.g. 301, 359) included those 54 junk hubs. Rule: every `autobahn-*` row in geo.txt must end with a tab and `ab`.
- Main-text length: median about 670 words on city and Autobahn pages, minimum about 490 (new city pages 514–680) (target in STYLE.md: 650–950).

## Next
1. Tier A is complete (Moers added). Continue with Tier B cities and further expansions from COVERAGE.md.
2. Hamburg Bezirke and other district pages once sources with real traffic facts are found.
3. Expand the shortest Ratgeber guides and add new guides.
4. Finalise LAUNCH-CHECKLIST.md at the end.
