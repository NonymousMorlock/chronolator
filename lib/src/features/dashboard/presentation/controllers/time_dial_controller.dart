import 'package:flutter/widgets.dart';

final class TimeDialController {
  final daysController = TextEditingController();
  final hoursController = TextEditingController();
  final minutesController = TextEditingController();
  final secondsController = TextEditingController();
  final millisecondsController = TextEditingController();
  final microSecondsController = TextEditingController();

  Duration get duration {
    final days = int.tryParse(daysController.text.trim()) ?? 0;
    final hours = int.tryParse(hoursController.text.trim()) ?? 0;
    final minutes = int.tryParse(minutesController.text.trim()) ?? 0;
    final seconds = int.tryParse(secondsController.text.trim()) ?? 0;
    final milliseconds = int.tryParse(millisecondsController.text.trim()) ?? 0;
    final microseconds = int.tryParse(microSecondsController.text.trim()) ?? 0;

    return Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
      microseconds: microseconds,
    );
  }

  void clear() {
    daysController.clear();
    hoursController.clear();
    minutesController.clear();
    secondsController.clear();
    millisecondsController.clear();
    microSecondsController.clear();
  }

  void dispose() {
    daysController.dispose();
    hoursController.dispose();
    minutesController.dispose();
    secondsController.dispose();
    millisecondsController.dispose();
    microSecondsController.dispose();
  }
}
