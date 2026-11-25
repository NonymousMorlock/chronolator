import 'package:chronolator/src/app/theming/providers/theme_cubit.dart';
import 'package:chronolator/src/core/extensions/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class ThemePickerButton extends StatelessWidget {
  const new({
    required this._themeMode,
    required this._activeThemeMode,
    super.key,
  });

  final ThemeMode _themeMode;
  final ThemeMode _activeThemeMode;

  @override
  Widget build(BuildContext context) {
    final isSelected = _themeMode == _activeThemeMode;
    final foregroundColour = isSelected
        ? context.colorScheme.onSecondaryContainer
        : context.colorScheme.onSurfaceVariant;
    BorderRadiusGeometry? borderRadius;
    if (_themeMode == .dark) {
      borderRadius = const BorderRadius.horizontal(right: Radius.circular(999));
    } else if (_themeMode == .light) {
      borderRadius = const BorderRadius.horizontal(left: Radius.circular(999));
    }
    return GestureDetector(
      onTap: () {
        context.read<ThemeCubit>().switchTo(_themeMode);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: isSelected ? context.colorScheme.secondaryContainer : null,
        ),
        child: Padding(
          padding: const .all(8),
          child: Row(
            mainAxisSize: .min,
            spacing: 5,
            children: [
              Icon(switch (_themeMode) {
                .light => Icons.wb_sunny_outlined,
                .dark => Icons.dark_mode_outlined,
                .system => switch (defaultTargetPlatform) {
                  .linux || .windows || .macOS => Icons.laptop_outlined,
                  _ => Icons.phone_android_outlined,
                },
              }, color: foregroundColour),
              Text(switch (_themeMode) {
                .light => 'Light',
                .dark => 'Dark',
                .system => 'System',
              }, style: TextStyle(color: foregroundColour)),
            ],
          ),
        ),
      ),
    );
  }
}
