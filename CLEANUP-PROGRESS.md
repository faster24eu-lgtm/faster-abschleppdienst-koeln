# CLEANUP-PROGRESS — quality cleanup of location pages

Read `STYLE-CLEANUP.md` first — it has the exact page pattern, what's auto-generated vs hand-written, and the checks to run after every batch. This file tracks what's done and what's next. If you're picking this up after running low on context: read both files, run the checks below to see current state, then continue with the next unchecked batch.

## Template changes (done once, apply to every page already built)
- [x] `_build/build.pl`: `@tun`/`@tunh` city "so läuft es ab" arrays rewritten as explicit 4-step process (8 phrasing variants). Every city page must keep the placeholder `<h2>Was wir in <Stadt> tun</h2><p>Platzhalter, wird automatisch ersetzt.</p>` for this to fire.
- [x] `_build/build.pl`: Bundesland hub "So arbeiten wir" → "So läuft es ab in `<Land>`" (explicit 4 steps), plus a new `@@FAQ@@` split in `bundeslaender.txt` for state-specific extra FAQs.
- [x] New checks: `scripts/check_trivia.pl` (trivia + unverifiable-claim grep, scoped to `<main>`). `scripts/check_similarity.pl` already existed and already scopes to `<main>` only — reused as-is.

## Pilot batch (pattern-setting, done)
- [x] Kassel (`stadt-kassel`, `_build/content/geo_020.txt`) — 859 words
- [x] Straubing (`stadt-straubing`, `_build/content/geo_041.txt`) — 751 words
- [x] Thüringen (`bl-thueringen`, `_build/content/bundeslaender.txt`) — 583 words, added Rennsteigtunnel/winter facts + 3 extra FAQs

Checks after pilot batch: `perl scripts/audit.pl` → 0 errors. `perl scripts/check_similarity.pl 30 staedte` and `... autobahnen` → 0 pairs > 30%. `perl scripts/check_trivia.pl staedte/kassel staedte/straubing bundeslaender/thueringen` → 0 hits.

## City batches (largest first, batches of 10) — 218 remaining of 220
Legend: [ ] not started, [x] done. Order is approximate (by rough population), doesn't need to be exact.

- [x] Batch 01: berlin, hamburg, muenchen, frankfurt, stuttgart, duesseldorf, leipzig, dortmund, essen (koeln excluded — it's not a `stadt-*` geo.txt page, it's the homepage + `/koeln/*` subpages, handled later in the "trivia-only" Köln/Karlsruhe pass per the brief). All 9 were already well-written (road facts, not encyclopedic) from an earlier session; this batch trimmed remaining trivia (population figures, Gebietsreform/incorporation dates, Ortsbeirat detail, historical opening dates and superlative "longest/most-congested" claims including two stray "laut Wikipedia" references), added "Sicher warten" + "Wo es oft passiert" sections, added the "Was wir tun" placeholder where missing, and replaced Stadtbezirke-count FAQs with a real customer question (towing to another city). Word counts landed 900–1104 — over the nominal 900 cap, kept as an accepted exception for these very large multi-district metros where the extra length is genuinely useful, not padding.
- [x] Batch 02: bremen, dresden, hannover, nuernberg, duisburg, bochum, wuppertal, bielefeld, bonn, muenster. Same treatment as Batch 01 (population/founding/Gebietsreform/admin trivia removed, "Sicher warten" + "Wo es oft passiert" added, "Was wir tun" placeholder restored where it had been overwritten with real text, trivia FAQs replaced with practical ones). Word counts: bremen 873, dresden 1082, hannover 974, nuernberg 998, duisburg 894, bochum 928, wuppertal 915, bielefeld 858, bonn 860, muenster 932 — again over the nominal 900 cap for several of these large metros, same accepted exception as Batch 01. All checks clean: audit 0 errors, similarity 0 pairs >30% (staedte and autobahnen), trivia 0 hits.
- [x] Batch 03: mannheim, augsburg, wiesbaden, gelsenkirchen, moenchengladbach, braunschweig, chemnitz, kiel, aachen, halle. Same treatment (trivia removed — population/founding/Gebietsreform/admin/military/geology stats, medieval and WWII history, superlative rankings; "Sicher warten" + "Wo es oft passiert" added; "Was wir tun" placeholder restored; trivia FAQs replaced with practical ones). Word counts: mannheim 1036, augsburg 921, wiesbaden 959, gelsenkirchen 850, moenchengladbach 898, braunschweig 782, chemnitz 863, kiel 842, aachen 891, halle 889. First similarity failure of the project: augsburg/chemnitz/halle/wiesbaden shared near-identical boilerplate wording for the "Sicher warten" opening sentence and the cost/nachts/e-auto FAQs (I'd been pasting the same phrasing for these across every city), which pushed 3 pairs over 30%. Fixed by giving each of those 4 pages its own distinct phrasing for those sentences. **Going forward: vary the wording of the Warnblinker-opening sentence and the cost/nachts/e-auto FAQ answers per city, the same way "So läuft es ab" is already varied — don't reuse identical phrasing across pages.** All checks clean after the fix: audit 0 errors, similarity 0 pairs >30% (staedte and autobahnen), trivia 0 hits.
- [x] Batch 04: magdeburg, freiburg, krefeld, luebeck, oberhausen, erfurt, mainz, rostock, hagen, hamm. Same treatment (trivia removed — population/founding/Gebietsreform/admin stats, WWII and medieval/archaeological history, unbuilt-road planning history, one stray "laut Wikipedia" fixed in Hagen; "Sicher warten" + "Wo es oft passiert" added; "Was wir tun" placeholder restored — hagen, hamm and rostock were missing this section entirely from the earlier session and now have it; varied wording used for the Warnblinker sentence and cost/nachts FAQs per the new rule). Word counts: magdeburg 830, freiburg 878, krefeld 824, luebeck 884, oberhausen 877, erfurt 768, mainz 887, rostock 761, hagen 763, hamm 813. All checks clean: audit 0 errors, similarity 0 pairs >30% (staedte and autobahnen), trivia 0 hits.

**Cumulative so far: pilot (3) + batch 01 (9) + batch 02 (10) + batch 03 (10) + batch 04 (10) = 42 pages rewritten.** Push after batch 05 will cross the 50-page threshold.
- [x] Batch 05: saarbruecken, muelheim, potsdam, ludwigshafen, oldenburg, leverkusen, osnabrueck, solingen, heidelberg, herne. Same treatment (trivia removed — population/founding/Gebietsreform/admin stats, medieval and Cold War history, exact-percentage/km statistics, two more "laut Wikipedia" references fixed in Oldenburg and Leverkusen; "Sicher warten" + "Wo es oft passiert" added; "Was wir tun" placeholder restored — saarbruecken, potsdam, ludwigshafen, oldenburg, leverkusen, osnabrueck, solingen, heidelberg and herne were all missing this section entirely from the earlier session). Word counts: saarbruecken 849, muelheim 803, potsdam 826, ludwigshafen 823, oldenburg 843, leverkusen 792, osnabrueck 781, solingen 813, heidelberg 829, herne 809. All checks clean: audit 0 errors, similarity 0 pairs >30% (staedte and autobahnen), trivia 0 hits.

**Cumulative: pilot (3) + batches 01–05 (49) = 52 pages rewritten — over the 50-page push threshold, pushed after this batch.**
- [x] Batch 06: neuss, darmstadt, regensburg, ingolstadt, wuerzburg, wolfsburg, ulm, heilbronn, pforzheim, goettingen. Same treatment (trivia removed — population/founding/Gebietsreform/admin stats, medieval and 20th-century history, exact-percentage/km/Hektar statistics, several more "laut Wikipedia" references fixed; "Sicher warten" + "Wo es oft passiert" added; "Was wir tun" placeholder restored — several of these were missing it or had real hand-written text instead). Word counts: neuss 783, darmstadt 789, regensburg 807, ingolstadt 817, wuerzburg 913, wolfsburg 784, ulm 880, heilbronn 819, pforzheim 779, goettingen 780. Similarity check initially flagged heilbronn↔regensburg at 32.1% (both short pages sharing near-identical cost/Werkstatt FAQ phrasing and the "Warnblinker an, alle Insassen..." opening) — fixed by rewording both pages' FAQ answers and Sicher-warten openings with distinct phrasing, per the rule added after batch 03. All checks clean after the fix: audit 0 errors, similarity 0 pairs >30%, trivia 0 hits.

**Cumulative: pilot (3) + batches 01–06 (59) = 62 pages rewritten.**
- [ ] Batch 07: bottrop, offenbach, trier, bergisch-gladbach, bremerhaven, erlangen, jena, remscheid, salzgitter, fuerth
- [ ] Batch 08: paderborn, hildesheim, cottbus, schwerin, siegen, guetersloh, witten, hanau, moers, ratingen
- [ ] Batch 09: ruesselsheim, esslingen, tuebingen, kempten, aschaffenburg, schweinfurt, villingen-schwenningen, sindelfingen, goeppingen, delmenhorst
- [ ] Batch 10: neubrandenburg, dessau-rosslau, ludwigsburg, reutlingen, flensburg, konstanz, kaiserslautern, worms, bamberg, bayreuth
- [ ] Batch 11: landshut, wilhelmshaven, emden, lueneburg, rosenheim, passau, goerlitz, greifswald, stralsund, celle
- [ ] Batch 12: giessen, wetzlar, marburg, fulda, brandenburg-an-der-havel, frankfurt-oder, plauen, weimar, eisenach, zwickau
- [ ] Batch 13: gera, speyer, neuwied, pirmasens, bad-kreuznach, zweibruecken, saarlouis, neunkirchen-saar, koblenz, wismar
- [ ] Batch 14: neumuenster, memmingen, iserlohn, luenen, marl, castrop-rauxel, velbert, viersen, dormagen, bocholt
- [ ] Batch 15: herford, minden, detmold, lippstadt, soest, unna, arnsberg, luedenscheid, troisdorf, siegburg
- [ ] Batch 16: dinslaken, gladbeck, dorsten, rheine, lingen, wolfenbuettel, goslar, hameln, nienburg, verden
- [ ] Batch 17: hof, ansbach, wittenberg, weiden, amberg, coburg, freising, dachau, huerth, bergheim
- [ ] Batch 18: dueren, euskirchen, kerpen, frechen, kleve, kamp-lintfort, wesel, friedrichshafen, aalen, heidenheim
- [ ] Batch 19: boeblingen, waiblingen, loerrach, baden-baden, bruchsal, norderstedt, neu-ulm, halberstadt, stendal, gotha
- [ ] Batch 20: hilden, langenfeld, sankt-augustin, meerbusch, rastatt, schwaebisch-gmuend, ahlen, bad-homburg, hattingen, ravensburg
- [ ] Batch 21: neustadt-weinstrasse, landau, frankenthal, gummersbach, bad-salzuflen, ansbach (dupe? verify), 12 Berlin Bezirke: berlin-mitte, berlin-friedrichshain-kreuzberg, berlin-pankow, berlin-charlottenburg-wilmersdorf, berlin-spandau, berlin-steglitz-zehlendorf, berlin-tempelhof-schoeneberg, berlin-neukoelln, berlin-treptow-koepenick, berlin-marzahn-hellersdorf, berlin-lichtenberg, berlin-reinickendorf

Note: batch 21 needs a de-dupe pass against batches 1–20 before starting (some names may already appear above — check with `grep -c "^stadt-<slug>" _build/content/geo.txt` vs the checkbox list, and cross off duplicates). The 12 Berlin Bezirke pages are shorter district pages nested under Berlin; same cleanup principles apply (drop Ortsteil history/founding trivia, keep the roads/bridges/landmarks that help locate a breakdown).

## Autobahn batches (after all city batches)
68 pages under `/autobahnen/`. Not started. Plan: batches of 10–12 by Autobahn number, same order as `ls autobahnen`. List them out once city batches are underway (don't pre-commit to an order that might not match what's actually useful — re-check `ls autobahnen` at that time since new pages may have been added).

## Bundesland batches (after Autobahn)
16 states, 1 done (Thüringen). Remaining 15: Baden-Württemberg, Bayern, Berlin, Brandenburg, Bremen, Hamburg, Hessen, Mecklenburg-Vorpommern, Niedersachsen, Nordrhein-Westfalen, Rheinland-Pfalz, Saarland, Sachsen, Sachsen-Anhalt, Schleswig-Holstein. Each needs: winter-conditions note where the state has Mittelgebirge/Alpen (Baden-Württemberg: Schwarzwald/Schwäbische Alb; Bayern: Alpen/Fränkische Alb; Hessen: Rhön/Kaufunger Wald; NRW: Sauerland; Sachsen: Erzgebirge), 3–4 state-specific FAQs via the new `@@FAQ@@` marker, and a check that no "laut Wikipedia" or similar meta-reference remains (found 2 so far: Hessen "Frankfurter Kreuz ... laut Wikipedia", Nordrhein-Westfalen "A40 ... laut Wikipedia" — fix these regardless of which batch reaches them, they read badly).

## Köln and Karlsruhe subpages (after Bundesland)
`/koeln/*` (21 pages) and `/karlsruhe/*` (6 pages): trivia removal only, per the brief — do **not** restructure these, they follow the owner's original copy/format.

## After every batch (mandatory)
1. `perl _build/build.pl`
2. `perl scripts/audit.pl` → must show `errors: 0`
3. `perl scripts/check_similarity.pl 30 staedte` and `perl scripts/check_similarity.pl 30 autobahnen` → `0 above 30%`; if not, add a genuinely local paragraph to the most similar page in the pair (see STYLE.md's existing approach from the expansion session) rather than just trimming words
4. `perl scripts/check_trivia.pl staedte/<slugs in this batch>` → `0 hit(s)`; review any MONEY-pattern hits by hand (see STYLE-CLEANUP.md's known limitation)
5. Spot-check word counts with the existing `wc.sh`-style one-liner (see STYLE-CLEANUP.md)
6. `git add -A && git commit -m "Cleanup: <City1>, <City2>, …"`
7. `git push` after every 50 pages (i.e., roughly every 5 city batches)
8. Update the checkboxes above in this file

## End-of-project tasks (not started)
- [ ] Update `sitemap.xml` lastmod for every changed page (the builder already regenerates `sitemap.xml` with today's date on every `perl _build/build.pl` run — confirm this still holds and that a fresh build right before the final commit captures it)
- [ ] Final summary to the owner: pages rewritten, average word count before/after, anything left out or unverifiable

## Open questions / things left out so far
- None yet from the pilot batch. Log anything you're unsure about here as you go, with the page slug, rather than guessing or asking the user mid-batch.
