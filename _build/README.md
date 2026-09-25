# _build

Static-site generator for this repository (Perl, no dependencies). The folder starts with an underscore, so GitHub Pages does not publish it.

```
perl _build/md2body.pl > _build/content/mittelbaden_body.html   # only if 01-startseite.md changed
perl _build/build.pl                                            # writes all *.html and sitemap.xml into the repo root
```

- `content/extra_*.txt`: page sources. Marker line: `=== slug | title | description | flag ===`. Later files override earlier slugs; the first pages (index, kontakt, impressum, ...) live in `__DATA__` at the end of `build.pl`.
- `content/related.txt`: tab-separated related links per page (slug, target, label, small text).
- `@@CTA@@` in a body inserts the related block and the call-to-action; `@@WA@@` is the WhatsApp link.
- Breadcrumb parents, base URL (`$BASE`) and the preview `noindex` line are in `build.pl`.
