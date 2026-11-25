import 'package:chronolator/bootstrap.dart';
import 'package:chronolator/src/app/app.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
