import 'package:chronolator/src/app/theming/widgets/theme_picker.dart';
import 'package:chronolator/src/core/extensions/context_extensions.dart';
import 'package:chronolator/src/features/dashboard/presentation/components/reset_dialog.dart';
import 'package:chronolator/src/features/dashboard/presentation/components/result_dialog.dart';
import 'package:chronolator/src/features/dashboard/presentation/controllers/time_dial_controller.dart';
import 'package:chronolator/src/features/dashboard/presentation/enums/chronolator_operation.dart';
import 'package:chronolator/src/features/dashboard/presentation/widgets/operation_button.dart';
import 'package:chronolator/src/features/dashboard/presentation/widgets/time_dial.dart';
import 'package:material_ui/material_ui.dart';

class const DashboardView({super.key}) extends StatefulWidget {
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final _selectedOperationNotifier = ValueNotifier<ChronolatorOperation>(.add);
  final ValueNotifier<List<TimeDialController>> _dialNotifier = ValueNotifier([
    TimeDialController(),
    TimeDialController(),
  ]);

  @override
  void dispose() {
    _selectedOperationNotifier.dispose();
    for (final dialController in _dialNotifier.value) {
      dialController.dispose();
    }
    _dialNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const .all(16),
            child: Column(
              spacing: 20,
              crossAxisAlignment: .start,
              children: [
                const Align(alignment: .topRight, child: ThemePicker()),
                Wrap(
                  spacing: 10,
                  children: [
                    OperationButton(
                      operation: .add,
                      selectedOperationNotifier: _selectedOperationNotifier,
                    ),
                    OperationButton(
                      operation: .subtract,
                      selectedOperationNotifier: _selectedOperationNotifier,
                    ),
                  ],
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _dialNotifier,
                    builder: (context, dials, child) {
                      return ListView.separated(
                        separatorBuilder: (_, _) => const SizedBox(height: 20),
                        padding: const .symmetric(vertical: 10),
                        itemCount: dials.length,
                        itemBuilder: (_, index) {
                          final controller = dials[index];
                          return TimeDial(
                            key: ValueKey(index),
                            timeDialController: controller,
                            dialNotifier: _dialNotifier,
                            index: index,
                          );
                        },
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_dialNotifier.value.isEmpty) return;
                        var duration = Duration.zero;

                        for (final dialController in _dialNotifier.value) {
                          if (_selectedOperationNotifier.value == .add) {
                            duration += dialController.duration;
                          } else {
                            duration -= dialController.duration;
                          }
                        }

                        await showDialog<void>(
                          context: context,
                          builder: (_) => ResultDialog(duration: duration),
                        );
                      },
                      child: const Text('Calculate ='),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.error,
                        foregroundColor: context.colorScheme.onError,
                      ),
                      onPressed: () async {
                        final fieldResetNotifier = ValueNotifier(false);

                        final numberOfDials = _dialNotifier.value.length;

                        final shouldClear = await showDialog<bool?>(
                          context: context,
                          builder: (_) {
                            return ResetDialog(
                              numberOfDials: numberOfDials,
                              fieldResetNotifier: fieldResetNotifier,
                            );
                          },
                        );

                        if (shouldClear ?? false) {
                          final shouldResetDials =
                              numberOfDials < 3 || fieldResetNotifier.value;
                          if (shouldResetDials) {
                            for (final dialController in _dialNotifier.value) {
                              dialController.dispose();
                            }
                            _dialNotifier.value = [
                              TimeDialController(),
                              TimeDialController(),
                            ];
                          } else {
                            for (final dial in _dialNotifier.value) {
                              dial.clear();
                            }
                          }
                        }

                        fieldResetNotifier.dispose();
                      },
                      label: const Text('Clear'),
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
