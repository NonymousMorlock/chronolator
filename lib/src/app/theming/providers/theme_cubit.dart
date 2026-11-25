import 'package:bloc/bloc.dart';
import 'package:material_ui/material_ui.dart';

class ThemeCubit() extends Cubit<ThemeMode> {
  this : super(.system);

  void switchTo(ThemeMode themeMode) {
    emit(themeMode);
  }
}
