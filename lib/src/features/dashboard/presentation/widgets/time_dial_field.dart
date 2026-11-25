import 'package:chronolator/src/app/responsiveness/breakpoints.dart';
import 'package:chronolator/src/app/theming/chronolator_theme.dart';
import 'package:chronolator/src/core/extensions/context_extensions.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

class TimeDialField extends StatelessWidget {
  const new({required this._controller, required this._label, super.key});

  final TextEditingController _controller;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return Consumer<Breakpoints>(
      builder: (_, breakpoint, _) {
        return TextField(
          controller: _controller,
          keyboardType: .number,
          textInputAction: .next,
          textAlign: .center,
          style: ChronolatorTheme.numerals(
            context.textTheme.bodyLarge!.copyWith(
              fontSize: breakpoint == .compact ? null : 24,
              fontWeight: .normal,
              letterSpacing: -.5,
              color: context.colorScheme.onSurface,
            ),
          ),
          decoration: InputDecoration(label: Text(_label)),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        );
      },
    );
  }
}
