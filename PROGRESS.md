# PROGRESS

Session goal: cover all of Germany with unique, factual pages (see COVERAGE.md). Log per cycle: SEO-ROADMAP.md (owner check lists live there).

## Decisions
- No Python on this machine: the checks are Perl (`scripts/audit.pl`, `scripts/check_similarity.pl`). Similarity = shared word 5-grams of the smaller page, threshold 30 %, run over `staedte/*` and `autobahnen/*`.
- The generator already existed (Perl); existing pages were not rewritten. New shared blocks (services, neighbours, extra FAQ, Bundesland breadcrumbs) are generated per city page with several variants chosen by a hash of the slug.
- City pages keep the URL `/staedte/<slug>/`; breadcrumb is Start › Bundesland › Stadt; the Bundesland hub is `/bundeslaender/<slug>/`.
- WhatsApp pre-fill text made generic (it used to say "in Köln").
- Time-sensitive facts (construction status, closures) are worded "nach der genutzten Quelle" and listed under "Owner check" in SEO-ROADMAP.md.
- Site remains noindex / Disallow. Impressum and Datenschutz untouched.

## Status (2026-09-27 ~05:30)
- 301 built pages (audit: 0 errors, 0 broken links, click depth ≤ 3; similarity: 0 pairs above 30 %, max ~29 % city/city, ~14 % Autobahn/Autobahn).
- Breakdown: 142 city/district pages (incl. 12 Berlin Bezirke), 43 Autobahn pages, Bundesland hubs (16 hubs plus sub pages, 46 files), 36 Ratgeber guides (8 expanded to 800–950 words), 21 Köln pages, 6 Karlsruhe pages, plus home, hubs, Kontakt, Danke, Impressum, Datenschutz.
- Main-text length: median about 650 words on city pages, minimum about 510 (target in STYLE.md: 650–950). Autobahn pages 540–730 words after expansion with sourced history and traffic details.

## Next
1. Add Moers (last open Großstadt), then more Tier B cities and Autobahn pages from COVERAGE.md; expand the shortest city pages further.
2. Hamburg Bezirke and other district pages once sources with real traffic facts are found.
3. Expand the shortest Ratgeber guides and add new guides.
4. Finalise LAUNCH-CHECKLIST.md at the end.
