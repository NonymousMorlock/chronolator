import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

abstract final class ChronolatorTheme {
  static const seed = Color(0xFF006A6A);

  static final ThemeData light = build(.light);
  static final ThemeData dark = build(.dark);

  static final ThemeData highContrastLight = build(.light, contrastLevel: 1);

  static final ThemeData highContrastDark = build(.dark, contrastLevel: 1);

  static ThemeData build(Brightness brightness, {double contrastLevel = 0.0}) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
      contrastLevel: contrastLevel,
    );

    final base = ThemeData(useMaterial3: true, colorScheme: scheme);

    return base.copyWith(
      textTheme: GoogleFonts.ibmPlexSansTextTheme(base.textTheme),
      primaryTextTheme: GoogleFonts.ibmPlexSansTextTheme(base.primaryTextTheme),
      inputDecorationTheme: InputDecorationThemeData(
        border: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: BorderSide(color: scheme.outline),
        ),
        filled: true,
        fillColor: scheme.surfaceContainerLowest,
        contentPadding: const .symmetric(vertical: 14, horizontal: 0),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: .circular(18)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size(0, 48),
        ),
      ),
    );
  }

  static TextStyle numerals(TextStyle base) {
    return GoogleFonts.ibmPlexMono(textStyle: base);
  }
}
