"""
Dynamic admin theming for django-unfold.

Unfold's _get_value() resolves dotted-string paths via import_string and
calls them with the current request. We use this to return per-tenant
branding (colors, site title/header) in the admin panel.
"""

import math


# ---------------------------------------------------------------------------
# Colour conversion: hex → sRGB → linear RGB → OKLab → OKLCH
# ---------------------------------------------------------------------------

def _hex_to_srgb(hex_color):
    """'#FF5722' → (1.0, 0.341, 0.133)"""
    h = hex_color.lstrip("#")
    return tuple(int(h[i : i + 2], 16) / 255.0 for i in (0, 2, 4))


def _srgb_to_linear(c):
    return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4


def _linear_to_oklab(r, g, b):
    l_ = 0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b
    m_ = 0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b
    s_ = 0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b

    l_ = l_ ** (1 / 3) if l_ > 0 else 0
    m_ = m_ ** (1 / 3) if m_ > 0 else 0
    s_ = s_ ** (1 / 3) if s_ > 0 else 0

    L = 0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_
    a = 1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_
    b_val = 0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_
    return L, a, b_val


def _hex_to_oklch(hex_color):
    """Convert a hex colour to OKLCH (L, C, H) where H is in degrees."""
    sr, sg, sb = _hex_to_srgb(hex_color)
    lr, lg, lb = _srgb_to_linear(sr), _srgb_to_linear(sg), _srgb_to_linear(sb)
    L, a, b = _linear_to_oklab(lr, lg, lb)
    C = math.sqrt(a * a + b * b)
    H = math.degrees(math.atan2(b, a)) % 360
    return L, C, H


# ---------------------------------------------------------------------------
# Palette generation
# ---------------------------------------------------------------------------

# Lightness values for shades 50-950 (11 stops), inspired by Tailwind.
_SHADE_LIGHTNESS = {
    "50": 0.97,
    "100": 0.93,
    "200": 0.87,
    "300": 0.79,
    "400": 0.70,
    "500": 0.60,
    "600": 0.50,
    "700": 0.42,
    "800": 0.35,
    "900": 0.28,
    "950": 0.22,
}

# Chroma multipliers — lighter/darker shades have less chroma.
_SHADE_CHROMA_MULT = {
    "50": 0.25,
    "100": 0.35,
    "200": 0.50,
    "300": 0.70,
    "400": 0.85,
    "500": 1.00,
    "600": 1.00,
    "700": 0.90,
    "800": 0.78,
    "900": 0.65,
    "950": 0.50,
}

# Default indigo palette (used for superusers / anonymous).
_DEFAULT_PRIMARY = {
    "50": "oklch(0.97 0.014 270)",
    "100": "oklch(0.93 0.028 270)",
    "200": "oklch(0.87 0.042 270)",
    "300": "oklch(0.79 0.058 270)",
    "400": "oklch(0.70 0.071 270)",
    "500": "oklch(0.60 0.083 270)",
    "600": "oklch(0.50 0.083 270)",
    "700": "oklch(0.42 0.075 270)",
    "800": "oklch(0.35 0.065 270)",
    "900": "oklch(0.28 0.054 270)",
    "950": "oklch(0.22 0.042 270)",
}


def _generate_oklch_palette(hex_color):
    """Generate an 11-shade OKLCH palette dict from a single hex colour."""
    _, C, H = _hex_to_oklch(hex_color)
    palette = {}
    for shade, lightness in _SHADE_LIGHTNESS.items():
        chroma = C * _SHADE_CHROMA_MULT[shade]
        palette[shade] = f"oklch({lightness:.3f} {chroma:.4f} {H:.1f})"
    return palette


# ---------------------------------------------------------------------------
# Tenant resolution helper
# ---------------------------------------------------------------------------

def _get_user_tenant(request):
    """
    Get the tenant from the logged-in admin user.

    TenantMiddleware exempts /admin/ paths, so request.tenant is None in admin.
    We resolve the tenant from request.user.tenant instead.
    Returns None for superusers (they see the default platform branding)
    and for anonymous users (login page).
    """
    user = getattr(request, "user", None)
    if user is None or not getattr(user, "is_authenticated", False):
        return None
    if user.is_superuser:
        return None
    return getattr(user, "tenant", None)


# ---------------------------------------------------------------------------
# Unfold callable hooks
# ---------------------------------------------------------------------------

def get_primary_colors(request):
    """Return OKLCH colour palette for the current tenant, or defaults."""
    tenant = _get_user_tenant(request)
    if tenant is None:
        return _DEFAULT_PRIMARY
    return _generate_oklch_palette(tenant.primary_color)


def get_site_title(request):
    """Return admin page <title> tag text."""
    tenant = _get_user_tenant(request)
    if tenant is None:
        return "FitLabel Admin"
    return f"{tenant.name} Admin"


def get_site_header(request):
    """Return admin header text (top-left corner)."""
    tenant = _get_user_tenant(request)
    if tenant is None:
        return "FitLabel"
    return tenant.name
