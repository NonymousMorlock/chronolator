import 'package:chronolator/app/app.dart';
import 'package:chronolator/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
