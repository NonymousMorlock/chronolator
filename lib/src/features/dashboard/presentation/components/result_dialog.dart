import 'package:chronolator/src/app/theming/chronolator_theme.dart';
import 'package:chronolator/src/core/extensions/context_extensions.dart';
import 'package:chronolator/src/core/extensions/duration_presentation.dart';
import 'package:chronolator/src/features/dashboard/presentation/enums/result_mode.dart';
import 'package:chronolator/src/features/dashboard/presentation/widgets/result_mode_picker_chip.dart';
import 'package:material_ui/material_ui.dart';

class ResultDialog extends StatefulWidget {
  const new({required this._duration, super.key});

  final Duration _duration;

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  final _resultModeNotifier = ValueNotifier<ResultMode>(.daysAndHours);

  @override
  void dispose() {
    _resultModeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foregroundColour = context.textTheme.bodyLarge!.color;

    final resultStyle = ChronolatorTheme.numerals(
      context.textTheme.displayMedium!.copyWith(
        color: foregroundColour,
        fontWeight: .w500,
      ),
    );

    return ValueListenableBuilder(
      valueListenable: _resultModeNotifier,
      builder: (context, resultMode, child) {
        final showDays = resultMode == .daysAndHours;
        final numeric = showDays
            ? widget._duration.numericDisplay
            : widget._duration.numericHoursDisplay;

        final labelled = showDays
            ? widget._duration.labelledDisplay
            : widget._duration.labelledHoursDisplay;
        return SimpleDialog(
          contentPadding: const .all(24),
          contentTextStyle: resultStyle,
          titlePadding: const EdgeInsets.all(24).copyWith(bottom: 0),
          titleTextStyle: TextStyle(fontWeight: .w500, color: foregroundColour),
          title: const Text('Total Duration'),
          children: [
            Wrap(
              spacing: 8,
              children: [
                ResultModePickerChip(
                  resultMode: .daysAndHours,
                  resultModeNotifier: _resultModeNotifier,
                ),
                ResultModePickerChip(
                  resultMode: .hours,
                  resultModeNotifier: _resultModeNotifier,
                ),
              ],
            ),
            const SizedBox(height: 10),
            FittedBox(child: Text(numeric)),
            const SizedBox(height: 20),
            Text(labelled, style: const TextStyle(fontSize: 14)),
          ],
        );
      },
    );
  }
}
