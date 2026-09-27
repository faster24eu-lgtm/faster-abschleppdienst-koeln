# LAUNCH-CHECKLIST (draft, finalise at the end of the session)

1. **Impressum** (`/impressum/`): company name, legal form, KBO/BTW number, representative, registered address, contact. Placeholders are still in the file. Datenschutz needs the same data plus the actual processors (GitHub Pages hosting, WhatsApp, Google if ads or analytics are added).
2. **Confirm claims with the partners**: "ab 129 €" (Karlsruhe–Offenburg only), the "Hotline rund um die Uhr" wording, the cities where partners really work. See the "Owner check" entries in SEO-ROADMAP.md.
3. **Enforce HTTPS** in GitHub Pages (Settings → Pages) once the certificate has been issued.
4. **Switch indexing on**: remove `<meta name="robots" content="noindex, nofollow">` from the template in `_build/build.pl` (keep it on impressum and datenschutz), rebuild, and replace `robots.txt` with `User-agent: *`, `Allow: /`, `Sitemap: https://abschleppdienst-faster.de/sitemap.xml`.
5. **Google Search Console**: add the domain, put the verification tag into the `<!-- GSC-VERIFICATION -->` slot of the home page (or verify via DNS), submit `sitemap.xml`.
6. **Consent banner** before any ads or analytics tag is added (none is loaded now).
7. Proofread the German copy with a native speaker; check the facts flagged in SEO-ROADMAP.md.
8. Reviews: a Google Business Profile needs a German address; Trustpilot is an option. Do not add review markup to the site until real reviews exist.
