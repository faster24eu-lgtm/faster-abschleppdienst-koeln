# STYLE-CLEANUP — quality cleanup of location pages (2026-09-27 session)

Goal: every city/Autobahn/Bundesland page reads like it was written for a driver stranded right now, not an encyclopedia entry. Pilot pages (Kassel, Straubing, Thüringen) establish the pattern below; all further batches follow it. See CLEANUP-PROGRESS.md for what's done and what's next.

## Two template changes made once, benefiting every page automatically
These live in `_build/build.pl`, not per-page content — do not duplicate them by hand.

1. **`@tun` / `@tunh` arrays** (city pages, ~line 302): the auto-rotated "so läuft es ab" paragraph. Rewritten from generic company-process prose into an explicit 4-step version: *(1) Anruf/WhatsApp mit Standort → (2) wir fragen Fahrzeug, Problem, Ziel → (3) wir finden einen Partner und nennen den Preis vorab → (4) Partner kommt, schleppt ab oder hilft vor Ort)*. 8 phrasing variants, picked by a hash of the slug, so it varies per page without copy-paste. **For this to fire, every city page's hand-written body must still contain the literal placeholder**
   `<h2>Was wir in <Stadt> tun</h2>\n<p>Platzhalter, wird automatisch ersetzt.</p>`
   (exact heading text `Was wir in <Stadt> tun`, exact placeholder text doesn't matter but must be inside one `<p>...</p>` right after). The builder's regex replaces both the heading and the paragraph. Do **not** write your own "So läuft es ab" prose — use this placeholder instead, it saves rewriting 220+ pages by hand and is guaranteed non-duplicate.
2. **Bundesland hubs**: the old generic "So arbeiten wir in `<Land>`" section was replaced with an explicit 4-step "So läuft es ab in `<Land>`" paragraph (same idea, one shared paragraph, fine to be identical across states — Bundesland pages aren't part of the similarity check). Also added: an `@@FAQ@@` split in `_build/content/bundeslaender.txt` — anything after `@@FAQ@@` in a state's block is inserted as extra `<details>` FAQ items *before* the 3 generic ones. Use this for state-specific FAQs (see Thüringen).

## What stays fully automatic (city pages) — do not hand-write these
- The services/destination block ("Was wir in `<Stadt>` koordinieren" or similar rotating heading): abschleppen/pannenhilfe/unfall/e-Auto+Motorrad+Transporter, with `/ratgeber/` links. This *is* the "Ihr Fahrzeug, Ihr Ziel" section from the brief — don't add a second one.
- "In der Nähe von `<Stadt>`": neighbour cities + Bundesland hub + Autobahn links, from `geo_nb.txt`.
- The cost FAQ ("Was kostet Abschleppen in `<Stadt>`?") and, if a neighbour exists, "Helfen Sie auch in `<Nachbarort>`?" — auto-appended after your hand-written FAQs.
- "Weiterlesen" block from `related.txt` and the CTA/footer.

## What you hand-write per city page, in this order
1. `page-head`: eyebrow, H1, 2–3 sentence lead ("Liegen geblieben in `<Stadt>`? Rufen Sie an oder schicken Sie Ihren Standort per WhatsApp …"), keep the two buttons.
2. `<h2>Was wir in <Stadt> tun</h2><p>Platzhalter, wird automatisch ersetzt.</p>` — see above, gets replaced.
3. Road-fact H2 sections: Autobahnen with Kreuze/Dreiecke, Bundesstraßen, tunnels, bridges, ring roads, Gewerbegebiete/Parkhaus if relevant — keep everything from the old page that's still useful, cut everything encyclopedic (see the trivia list below). Ortsteil/Stadtteil names stay if they help describe a location.
4. `<h2>Sicher warten in <Stadt></h2>` — 1 short paragraph: what to do while waiting in *this city's* actual situations only (Autobahn shoulder, tunnel, bridge, Parkhaus, busy Ring) — don't list a situation that doesn't exist there.
5. `<h2>Wo es in <Stadt> oft passiert</h2>` — 1 short paragraph recapping the trouble spots named in section 3 (gradient, junction, construction, tunnel) each with a one-line practical reason/tip.
6. `<h2>So nennen Sie Ihren Standort in <Stadt></h2>` + `<ul class="ticks">` — keep/tighten the existing checklist (heading text is auto-rotated by the builder, keep the exact string "So nennen Sie Ihren Standort in `<Stadt>`" so that still fires).
7. FAQ block (`<section class="section grey">`): 4–5 `<details>` a real customer would ask — never "Wie viele Einwohner…", "Hat … Stadtbezirke?", or other trivia. Good patterns: "Ich stehe auf der `<A…>` kurz vor `<Ausfahrt/Kreuz>`. Was jetzt?", "Können Sie mein Auto von `<Stadt>` zu meiner Werkstatt in `<Nachbarstadt>` bringen?", the cost question, "Helfen Sie auch nachts/am Wochenende?", "Mein E-Auto ist liegen geblieben, geht das auch?". **Important — vary the wording of these recurring FAQ answers (cost/nachts/e-auto) and the "Warnblinker an, alle Insassen hinter die Leitplanke, Warndreieck aufstellen…" opening sentence of the "Sicher warten" section per city.** Pasting the same phrasing repeatedly is what caused the first similarity-check failure of the project (batch 03: augsburg/chemnitz/halle/wiesbaden, fixed after the fact). Treat these like "So läuft es ab" — same idea, different words each time.
8. Drop any stray manual "Weitere Städte: …" line if present — the auto "In der Nähe" block already covers it; a hand-written duplicate list can go stale.

Target: 600–900 words of *main* text (the word counter in `/tmp` or an equivalent counts `<main>` minus script/style). Kassel landed at 859, Straubing at 751.

## Trivia to delete on sight (with the reasoning)
Population + date, founding year/former name, Gebietsreform/Eingemeindung years, "eines von X Oberzentren", "Verwaltungssitz des Regierungsbezirks", Ortsbeirat/Ortschaftsrat structure, exact hectares/m² of Gewerbegebiete, exact parking-space counts, Naturschutz-/Vogelschutzgebiete, Bundeswehr/military history, medieval/Mittelalter history — none of it helps someone find their car. Run `perl scripts/check_trivia.pl staedte/<slug>` after every rewrite; it also flags `€`, `Minuten`, `Sterne`, `Bewertung` as a reminder to check nothing invents a price, time or rating.

## Autobahn pages (not yet started as of the pilot batch)
Same principle: drop construction-year/record-length/"älteste"-style history, keep route + Kreuze/Dreiecke + Rastanlagen + known tough stretches (gradient, tunnel, no-hard-shoulder section) + how to state your position + city links along the route. Add 3–4 practical FAQs, replacing purely historical ones.

## Checks to run after every batch
```
perl _build/build.pl
perl scripts/audit.pl                      # 0 errors required
perl scripts/check_similarity.pl 30 staedte      # 0 pairs > 30% required
perl scripts/check_similarity.pl 30 autobahnen   # 0 pairs > 30% required
perl scripts/check_trivia.pl staedte <slug-dirs just touched>   # 0 hits required (review any MONEY hits by hand — some are legitimate, e.g. distance-in-minutes to a landmark that isn't a promise of arrival time)
```
`check_similarity.pl` already excludes header/footer/nav and looks only at `<main>` — no separate script needed for that part of step 6.

## Known limitation
`check_trivia.pl`'s money-pattern list can true-positive on harmless usage (e.g. "in 10 Minuten Fahrzeit erreichbar" describing road distance, not a promise). Read each MONEY hit before deciding; don't blanket-delete.
