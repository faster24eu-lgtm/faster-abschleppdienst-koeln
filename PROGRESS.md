# PROGRESS

Session goal: cover all of Germany with unique, factual pages (see COVERAGE.md). Log per cycle: SEO-ROADMAP.md (owner check lists live there).

## Decisions
- No Python on this machine: the checks are Perl (`scripts/audit.pl`, `scripts/check_similarity.pl`). Similarity = shared word 5-grams of the smaller page, threshold 30 %, run over `staedte/*`.
- The generator already existed (Perl); existing pages were not rewritten. New shared blocks (services, neighbours, extra FAQ, Bundesland breadcrumbs) are generated per city page with several variants chosen by a hash of the slug.
- City pages keep the URL `/staedte/<slug>/`; breadcrumb is Start › Bundesland › Stadt; the Bundesland hub is `/bundeslaender/<slug>/`.
- WhatsApp pre-fill text made generic (it used to say "in Köln").
- Site remains noindex / Disallow. Impressum and Datenschutz untouched.

## Done
- Köln (9 districts, 4 motorway pages, 3 guides), Karlsruhe–Offenburg region, Ratgeber (35 guides, 8 expanded to 800–950 words).
- 40+ city pages, 9 Autobahn pages, 13 Bundesland hubs + index, /staedte/ grouped by Bundesland with search, footer and home linking, generic WhatsApp text, sitemap with build date.

## Next
1. Tier A missing cities (COVERAGE.md).
2. Autobahn pages (Tier D), then district pages for the biggest cities, then Tier B.
3. Expand the shortest Ratgeber guides and add new guides.
4. Finalise LAUNCH-CHECKLIST.md at the end.
