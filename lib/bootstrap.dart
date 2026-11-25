import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class const AppBlocObserver() extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here
  LicenseRegistry.addLicense(() async* {
    const fontsPath = 'assets/google_fonts/IBM_Plex_Mono,IBM_Plex_Sans';

    final plexLicense = await rootBundle.loadString(
      '$fontsPath/IBM_Plex_Sans/OFL.txt',
    );

    yield LicenseEntryWithLineBreaks([
      'IBM Plex Sans',
      'IBM Plex Mono',
    ], plexLicense);
  });

  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(await builder());
}
