import 'package:material_ui/material_ui.dart';

enum ChronolatorOperation({
  required final String label,
  required final IconData icon,
}) {
  add(label: 'Add', icon: Icons.add),
  subtract(label: 'Subtract', icon: Icons.remove),
}
