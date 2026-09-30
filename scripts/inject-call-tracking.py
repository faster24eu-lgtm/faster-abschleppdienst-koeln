#!/usr/bin/env python3
"""Add AW-10963026341/1eHUCNemnIwdEKWDyuso after existing base gtag config."""
import os, re
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
NEW = """gtag('config', 'AW-10963026341/1eHUCNemnIwdEKWDyuso', {
  'phone_conversion_number': '+49 176 41956993'
});"""
OLD = """gtag('config', 'AW-10963026341/6YcCCJqizocdEKWDyuso', {
  'phone_conversion_number': '+49 176 41956993'
});"""
n = 0
for dp, _, files in os.walk(ROOT):
    if '.git' in dp or '/_build/' in dp + '/':
        continue
    for f in files:
        if not f.endswith('.html'):
            continue
        p = os.path.join(dp, f)
        t = open(p, encoding='utf-8', errors='replace').read()
        if '1eHUCNemnIwdEKWDyuso' in t:
            continue
        if OLD in t:
            t = t.replace(OLD, OLD + "\n" + NEW, 1)
        elif "gtag('config', 'AW-10963026341');" in t:
            t = t.replace("gtag('config', 'AW-10963026341');", "gtag('config', 'AW-10963026341');\n" + NEW, 1)
        elif "gtag('config','AW-10963026341');" in t:
            t = t.replace("gtag('config','AW-10963026341');", "gtag('config','AW-10963026341');\n" + NEW, 1)
        else:
            continue
        open(p, 'w', encoding='utf-8').write(t)
        n += 1
print('patched', n)
