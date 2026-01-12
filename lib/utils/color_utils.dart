import 'package:flutter/material.dart';

class ColorUtils {
  // Base named colors (Material + custom hex)
  static final Map<String, Color> _namedColors = {
    // Material basics
    'black': Colors.black,
    'white': Colors.white,
    'gray': Colors.grey,
    'grey': Colors.grey,
    'blue': Colors.blue,
    'red': Colors.red,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'orange': Colors.orange,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'brown': Colors.brown,
    'indigo': Colors.indigo,
    'teal': Colors.teal,
    'cyan': Colors.cyan,
    'amber': Colors.amber,
    'lime': Colors.lime,
    'deeporange': Colors.deepOrange,
    'deeppurple': Colors.deepPurple,
    'bluegrey': Colors.blueGrey,

    // Fashion-friendly expansions (custom hex)
    'gold': _hex('#FFD700'),
    'silver': _hex('#C0C0C0'),
    'beige': _hex('#F5F5DC'),
    'ivory': _hex('#FFFFF0'),
    'cream': _hex('#FFFDD0'),
    'charcoal': _hex('#36454F'),
    'navy': _hex('#000080'),
    'maroon': _hex('#800000'),
    'burgundy': _hex('#800020'),
    'olive': _hex('#808000'),
    'khaki': _hex('#F0E68C'),
    'mustard': _hex('#FFDB58'),
    'taupe': _hex('#483C32'),
    'tan': _hex('#D2B48C'),
    'peach': _hex('#FFE5B4'),
    'coral': _hex('#FF7F50'),
    'salmon': _hex('#FA8072'),
    'fuchsia': _hex('#FF00FF'),
    'magenta': _hex('#FF00FF'),
    'lavender': _hex('#E6E6FA'),
    'mint': _hex('#98FF98'),
    'turquoise': _hex('#40E0D0'),
    'aquamarine': _hex('#7FFFD4'),
    'skyblue': _hex('#87CEEB'),
    'royalblue': _hex('#4169E1'),
    'sand': _hex('#C2B280'),
    'stone': _hex('#888C8D'),
    'bronze': _hex('#CD7F32'),
    'copper': _hex('#B87333'),
  };

  // Optional aliases for common variations
  static final Map<String, String> _aliases = {
    'grey': 'gray',
    'offwhite': 'ivory',
    'off-white': 'ivory',
    'creamwhite': 'cream',
    'darkblue': 'navy',
    'wine': 'burgundy',
    'blue-gray': 'bluegrey',
    'blue grey': 'bluegrey',
    'royal blue': 'royalblue',
    'sky blue': 'skyblue',
  };

  /// Convert a string to a Color.
  /// Supports named colors, aliases, and hex (#RRGGBB or #AARRGGBB).
  static Color fromString(String input) {
    final key = input.toLowerCase().replaceAll(' ', '').trim();

    // Alias resolution
    final resolved = _aliases[key] ?? key;

    // Named colors
    final named = _namedColors[resolved];
    if (named != null) return named;

    // Hex parsing
    if (resolved.startsWith('#')) return _hexToColor(resolved);

    // Fallback
    return Colors.transparent;
  }

  /// Extend or override named colors at runtime.
  static void register(String name, Color color) {
    _namedColors[name.toLowerCase().replaceAll(' ', '')] = color;
  }

  // Helpers
  static Color _hexToColor(String hex) {
    var v = hex.replaceFirst('#', '');
    if (v.length == 6) v = 'FF$v'; // add alpha if missing
    return Color(int.parse(v, radix: 16));
  }

  static Color _hex(String hex) => _hexToColor(hex);
}