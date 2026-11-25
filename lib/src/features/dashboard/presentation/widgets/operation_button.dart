import 'package:chronolator/src/core/extensions/context_extensions.dart';
import 'package:chronolator/src/features/dashboard/presentation/enums/chronolator_operation.dart';
import 'package:material_ui/material_ui.dart';

class OperationButton extends StatelessWidget {
  const new({
    required this._operation,
    required this._selectedOperationNotifier,
    super.key,
  });

  final ChronolatorOperation _operation;
  final ValueNotifier<ChronolatorOperation> _selectedOperationNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedOperationNotifier,
      builder: (context, selectedOperation, _) {
        final isSelected = selectedOperation == _operation;
        return OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isSelected
                  ? context.colorScheme.secondaryContainer
                  : context.colorScheme.outlineVariant,
            ),
            backgroundColor: isSelected
                ? context.colorScheme.secondaryContainer
                : null,
            foregroundColor: isSelected
                ? context.colorScheme.onSecondaryContainer
                : context.colorScheme.onSurfaceVariant,
            minimumSize: const Size(0, 44),
            shape: RoundedRectangleBorder(borderRadius: .circular(12)),
          ),
          onPressed: () {
            if (isSelected) return;
            _selectedOperationNotifier.value = _operation;
          },
          label: Text(_operation.label),
          icon: Icon(_operation.icon),
        );
      },
    );
  }
}
