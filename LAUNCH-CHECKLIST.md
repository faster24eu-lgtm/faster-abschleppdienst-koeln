# LAUNCH-CHECKLIST

## Session status (2026-09-27, overnight expansion cycle finished ~09:20)
- **375 built pages**, audit 0 errors, 0 broken links, click depth ≤ 3; similarity check 0 pairs above 30 % on both `staedte/*` (max ~29.3 %) and `autobahnen/*` (max ~13.5 %).
- Breakdown: 221 city/district pages (incl. 12 Berlin Bezirke), 68 Autobahn pages, 16 Bundesland hubs + index, 36 Ratgeber guides, 21 Köln pages, 6 Karlsruhe pages, plus home, hubs, Kontakt, Danke, Impressum, Datenschutz.
- Coverage now spans all 16 Bundesländer with genuinely local Tier A/B city pages plus Autobahn pages; the Tier B candidate list from the original brief is exhausted (see COVERAGE.md). Hamburg's 7 Bezirke, and München/Frankfurt/Stuttgart/Düsseldorf district pages, are **not** built — the readily available Wikipedia extracts for those districts lacked usable traffic/orientation facts; would need a better source before writing them.
- Site remains `noindex, nofollow` and `robots.txt` is `Disallow: /` — confirmed still in place as of this cycle. Nothing here has gone live in search yet; that switch is still the owner's call (item 4 below).
- All facts came from Wikipedia extracts read during this session; anything uncertain or time-sensitive is logged under "Owner check" entries throughout SEO-ROADMAP.md (construction/opening dates, planned-but-unrealised roads, population figures tied to a stated date). Nothing was invented: no prices, ratings, review counts, years in business, response times, or claims of local offices/own drivers.

## Before going live, the owner still needs to:

1. **Impressum** (`/impressum/`): company name, legal form, KBO/BTW number, representative, registered address, contact. Placeholders are still in the file. Datenschutz needs the same data plus the actual processors (GitHub Pages hosting, WhatsApp, Google if ads or analytics are added).
2. **Confirm claims with the partners**: "ab 129 €" (Karlsruhe–Offenburg only), the "Hotline rund um die Uhr" wording, the cities where partners really work. See the "Owner check" entries in SEO-ROADMAP.md.
3. **Enforce HTTPS** in GitHub Pages (Settings → Pages) once the certificate has been issued.
4. **Switch indexing on**: remove `<meta name="robots" content="noindex, nofollow">` from the template in `_build/build.pl` (keep it on impressum and datenschutz), rebuild, and replace `robots.txt` with `User-agent: *`, `Allow: /`, `Sitemap: https://abschleppdienst-faster.de/sitemap.xml`.
5. **Google Search Console**: add the domain, put the verification tag into the `<!-- GSC-VERIFICATION -->` slot of the home page (or verify via DNS), submit `sitemap.xml`.
6. **Consent banner** before any ads or analytics tag is added (none is loaded now).
7. Proofread the German copy with a native speaker; check the facts flagged in SEO-ROADMAP.md.
8. Reviews: a Google Business Profile needs a German address; Trustpilot is an option. Do not add review markup to the site until real reviews exist.
