import re, sys, math
from fontTools.fontBuilder import FontBuilder
from fontTools.svgLib.path import parse_path
from fontTools.pens.recordingPen import RecordingPen
from fontTools.pens.boundsPen import BoundsPen
from fontTools.pens.transformPen import TransformPen
from fontTools.pens.ttGlyphPen import TTGlyphPen
from fontTools.pens.cu2quPen import Cu2QuPen

svg, out = sys.argv[1], sys.argv[2]
CP = 0xE100
UPM, ASC, DESC = 1000, 1020, 300          # JetBrains Mono vertical metrics
BOTTOM, TOP = -DESC, ASC                  # the art fills the whole line height
SIZE = TOP - BOTTOM
ADV = 1200                                # two 600-unit cells

src = open(svg).read()
layers = []
for m in re.finditer(r'<path\b(.*?)/?>', src, re.S):
    a = m.group(1)
    d = re.search(r'\bd="(.*?)"', a, re.S).group(1)
    f = re.search(r'fill="rgb\((\d+),\s*(\d+),\s*(\d+)\)"', a)
    op = re.search(r'(?:fill-)?opacity="([\d.]+)"', a)
    rec = RecordingPen(); parse_path(d, rec)
    layers.append((rec, tuple(int(x) for x in f.groups()), float(op.group(1)) if op else 1.0))

# bounding box of the artwork
x0 = y0 = 1e9; x1 = y1 = -1e9
for rec, _, _ in layers:
    bp = BoundsPen(None); rec.replay(bp)
    if bp.bounds:
        x0, y0 = min(x0, bp.bounds[0]), min(y0, bp.bounds[1])
        x1, y1 = max(x1, bp.bounds[2]), max(y1, bp.bounds[3])
print("art bbox", x0, y0, x1, y1)
cx, cy = (x0 + x1) / 2, (y0 + y1) / 2
s = SIZE / (y1 - y0)
gx, gy = s * (x1 - x0) / 2, (TOP + BOTTOM) / 2   # left-aligned, vertically centred
T = (s, 0, 0, -s, gx - s * cx, gy + s * cy)   # flip Y

glyphs, colors, colr = {".notdef": TTGlyphPen(None).glyph()}, [], []

def add(name, draw, rgba):
    tt = TTGlyphPen(None); draw(Cu2QuPen(tt, 0.5, reverse_direction=False))
    glyphs[name] = tt.glyph()
    if rgba not in colors: colors.append(rgba)
    colr.append((name, colors.index(rgba)))

for i, (rec, rgb, op) in enumerate(layers):
    add(f"l{i:02d}", lambda p, rec=rec: rec.replay(TransformPen(p, T)),
        (rgb[0] / 255, rgb[1] / 255, rgb[2] / 255, op))

# base glyph = first layer's outline, used by renderers without colour support
tt = TTGlyphPen(None); layers[0][0].replay(TransformPen(Cu2QuPen(tt, 0.5), T)); glyphs["logo"] = tt.glyph()

order = list(glyphs)
fb = FontBuilder(UPM, isTTF=True)
fb.setupGlyphOrder(order)
fb.setupCharacterMap({CP: "logo"})
fb.setupGlyf(glyphs)
fb.setupHorizontalMetrics({g: (ADV if g != ".notdef" else 600, getattr(glyphs[g], "xMin", 0)) for g in order})
fb.setupHorizontalHeader(ascent=ASC, descent=-DESC)
fb.setupNameTable({"familyName": "EddCode Logo", "styleName": "Regular"})
fb.setupOS2(sTypoAscender=ASC, sTypoDescender=-DESC, usWinAscent=ASC, usWinDescent=DESC)
fb.setupPost()
fb.setupCOLR({"logo": colr})
fb.setupCPAL([colors])
fb.save(out)
print("layers", len(colr), "colors", len(colors), "->", out)
