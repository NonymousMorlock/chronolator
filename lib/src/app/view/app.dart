import 'package:chronolator/l10n/l10n.dart';
import 'package:chronolator/src/app/routing/router.dart';
import 'package:chronolator/src/app/theming/chronolator_theme.dart';
import 'package:chronolator/src/app/theming/providers/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class const App({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            routerConfig: router,
            theme: ChronolatorTheme.light,
            darkTheme: ChronolatorTheme.dark,
            highContrastTheme: ChronolatorTheme.highContrastLight,
            highContrastDarkTheme: ChronolatorTheme.highContrastDark,
            themeMode: themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
