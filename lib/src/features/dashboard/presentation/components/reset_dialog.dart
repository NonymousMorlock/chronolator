import 'package:chronolator/src/core/extensions/context_extensions.dart';
import 'package:material_ui/material_ui.dart';

class ResetDialog extends StatelessWidget {
  const new({
    required this._numberOfDials,
    required this._fieldResetNotifier,
    super.key,
  });

  final int _numberOfDials;
  final ValueNotifier<bool> _fieldResetNotifier;

  @override
  Widget build(BuildContext context) {
    final foregroundColour = context.textTheme.bodyLarge!.color;

    return AlertDialog(
      title: const Text('Reset All'),
      content: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text(
            'This will clear all fields',
            style: TextStyle(color: foregroundColour),
          ),
          if (_numberOfDials > 2)
            ValueListenableBuilder(
              valueListenable: _fieldResetNotifier,
              builder: (context, shouldReset, _) {
                return CheckboxListTile.adaptive(
                  value: shouldReset,
                  controlAffinity: .leading,
                  contentPadding: .zero,
                  title: Text(
                    'Remove additional fields',
                    style: TextStyle(color: foregroundColour),
                  ),
                  subtitle: Text(
                    'This removes fields '
                    'you added and resets the '
                    'number of fields to '
                    'the default.',
                    style: TextStyle(color: foregroundColour),
                  ),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      _fieldResetNotifier.value = newValue;
                    }
                  },
                );
              },
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel', textAlign: .end),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: context.colorScheme.error,
          ),
          child: const Text('Reset', textAlign: .end),
        ),
      ],
    );
  }
}
