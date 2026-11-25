import 'package:chronolator/src/core/extensions/context_extensions.dart';
import 'package:chronolator/src/features/dashboard/presentation/controllers/time_dial_controller.dart';
import 'package:chronolator/src/features/dashboard/presentation/widgets/time_dial_field.dart';
import 'package:material_ui/material_ui.dart';

class TimeDial extends StatelessWidget {
  const new({
    required this._timeDialController,
    required this._dialNotifier,
    required this._index,
    super.key,
  });

  final TimeDialController _timeDialController;
  final ValueNotifier<List<TimeDialController>> _dialNotifier;
  final int _index;

  @override
  Widget build(BuildContext context) {
    final isLast = _index == _dialNotifier.value.length - 1;
    final colonDelimiter = Text(':', style: context.textTheme.headlineSmall);
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      spacing: 12,
      children: [
        Row(
          mainAxisSize: .min,
          spacing: 5,
          children: [
            Expanded(
              child: TimeDialField(
                controller: _timeDialController.daysController,
                label: 'DS',
              ),
            ),
            colonDelimiter,
            Expanded(
              child: TimeDialField(
                controller: _timeDialController.hoursController,
                label: 'HS',
              ),
            ),
            colonDelimiter,
            Expanded(
              child: TimeDialField(
                controller: _timeDialController.minutesController,
                label: 'MIN',
              ),
            ),
            colonDelimiter,
            Expanded(
              child: TimeDialField(
                controller: _timeDialController.secondsController,
                label: 'S',
              ),
            ),
            Text('.', style: context.textTheme.headlineSmall),
            Expanded(
              child: TimeDialField(
                controller: _timeDialController.millisecondsController,
                label: 'MIL',
              ),
            ),
            Expanded(
              child: TimeDialField(
                controller: _timeDialController.microSecondsController,
                label: 'MIC',
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: .min,
          spacing: 10,
          children: [
            if (_index > 1)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.error,
                  foregroundColor: context.colorScheme.onError,
                ),
                onPressed: () {
                  _dialNotifier.value = List.from(
                    _dialNotifier.value..removeAt(_index),
                  );
                },
                label: const Text('Remove'),
                icon: const Icon(Icons.delete_forever),
              ),

            if (isLast)
              ElevatedButton.icon(
                onPressed: () {
                  _dialNotifier.value = List.from(
                    _dialNotifier.value..add(TimeDialController()),
                  );
                },
                label: const Text('Add'),
                icon: const Icon(Icons.access_time_outlined),
              ),
          ],
        ),
      ],
    );
  }
}
