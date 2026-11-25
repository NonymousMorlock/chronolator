import 'package:chronolator/src/app/theming/providers/theme_cubit.dart';
import 'package:chronolator/src/app/theming/widgets/theme_picker_button.dart';
import 'package:chronolator/src/core/extensions/context_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class const ThemePicker({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(5),
      decoration: BoxDecoration(
        borderRadius: .circular(999),
        color: context.colorScheme.surfaceContainer,
      ),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (_, state) {
          return Wrap(
            children: [
              ThemePickerButton(themeMode: .light, activeThemeMode: state),
              ThemePickerButton(themeMode: .system, activeThemeMode: state),
              ThemePickerButton(themeMode: .dark, activeThemeMode: state),
            ],
          );
        },
      ),
    );
  }
}
