import 'package:chronolator/src/core/extensions/context_extensions.dart';
import 'package:chronolator/src/features/dashboard/presentation/enums/result_mode.dart';
import 'package:material_ui/material_ui.dart';

class ResultModePickerChip extends StatelessWidget {
  const new({
    required this._resultMode,
    required this._resultModeNotifier,
    super.key,
  });

  final ResultMode _resultMode;
  final ValueNotifier<ResultMode> _resultModeNotifier;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final isSelected = _resultMode == _resultModeNotifier.value;

    final foregroundColour = isSelected
        ? scheme.onPrimary
        : scheme.onPrimaryContainer;

    return Theme(
      data: context.theme.copyWith(
        canvasColor: context.colorScheme.primaryContainer,
      ),
      child: ChoiceChip(
        label: Text(_resultMode.label),
        labelStyle: TextStyle(color: foregroundColour),
        selected: isSelected,
        onSelected: (_) => _resultModeNotifier.value = _resultMode,
        side: .new(color: scheme.primary),
        backgroundColor: Colors.transparent,
        selectedColor: scheme.primary,
        checkmarkColor: foregroundColour,
      ),
    );
  }
}
