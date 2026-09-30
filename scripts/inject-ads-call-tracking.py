#!/usr/bin/env python3
"""Add Google Ads website-call conversion to every HTML page. Idempotent."""
import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

BASE = """<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-10963026341"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'AW-10963026341');
</script>
"""

CONV = """<script>
  gtag('config', 'AW-10963026341/1eHUCNemnIwdEKWDyuso', {
    'phone_conversion_number': '+49 176 41956993'
  });
</script>
"""

CONV_ID = "1eHUCNemnIwdEKWDyuso"


def normalize_visible_phone(html: str) -> str:
    # Do not touch tel: or wa.me URLs.
    def repl(m):
        return m.group(0)
    # Visible compact international number (not in tel:)
    html = re.sub(r'(?<!tel:)\+4917641956993', '+49 176 41956993', html)
    html = re.sub(r'(?<!tel:)\+49\s*176\s*41956993', '+49 176 41956993', html)
    html = re.sub(r'(?<!\d)0176[\s/]*41956993(?!\d)', '+49 176 41956993', html)
    return html


def inject(html: str) -> str:
    html = normalize_visible_phone(html)
    has_base = "gtag/js?id=AW-10963026341" in html or "id=AW-10963026341" in html
    has_conv = CONV_ID in html

    if has_base and has_conv:
        return html

    if not has_base:
        m = re.search(r"<head[^>]*>", html, flags=re.I)
        if not m:
            return html
        insert = BASE + CONV
        html = html[: m.end()] + "\n" + insert + html[m.end() :]
        return html

    if has_conv:
        return html

    # Insert conversion immediately after first base config call.
    patterns = [
        "gtag('config', 'AW-10963026341');",
        'gtag("config", "AW-10963026341");',
        "gtag('config','AW-10963026341');",
        'gtag("config","AW-10963026341");',
    ]
    for p in patterns:
        i = html.find(p)
        if i >= 0:
            insert_at = i + len(p)
            # If we are inside a <script>, close it then add CONV as its own script
            # (user asked for a separate snippet after the tag).
            rest = html[insert_at:]
            close = rest.find("</script>")
            if close >= 0:
                after_script = insert_at + close + len("</script>")
                html = html[:after_script] + "\n" + CONV + html[after_script:]
            else:
                html = html[:insert_at] + "\n" + CONV + html[insert_at:]
            return html

    # Fallback: after first gtag.js script tag pair
    m = re.search(
        r'<script[^>]+src="https://www.googletagmanager.com/gtag/js\?id=AW-10963026341"[^>]*>\s*</script>',
        html,
        flags=re.I,
    )
    if m:
        html = html[: m.end()] + "\n" + CONV + html[m.end() :]
        return html

    m = re.search(r"<head[^>]*>", html, flags=re.I)
    if m:
        html = html[: m.end()] + "\n" + CONV + html[m.end() :]
    return html


def main():
    changed = []
    skipped = []
    for dp, _, files in os.walk(ROOT):
        if "/.git" in dp or dp.endswith("/.git"):
            continue
        if "/_build" in dp:
            continue
        for f in files:
            if not f.endswith(".html"):
                continue
            if f.startswith("ba756"):
                continue
            path = os.path.join(dp, f)
            raw = open(path, encoding="utf-8", errors="replace").read()
            new = inject(raw)
            if new != raw:
                open(path, "w", encoding="utf-8").write(new)
                changed.append(os.path.relpath(path, ROOT))
            else:
                skipped.append(os.path.relpath(path, ROOT))
    print("changed", len(changed))
    print("unchanged", len(skipped))
    for p in sorted(changed):
        print(p)


if __name__ == "__main__":
    main()
