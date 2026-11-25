part of 'router.dart';

final GoRouter router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, _, child) {
        return ColoredBox(
          color: context.theme.scaffoldBackgroundColor,
          child: Align(
            alignment: .topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: SizedBox.expand(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Provider.value(
                      value: Breakpoints.fromWidth(constraints.maxWidth),
                      child: child,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) {
            return const DashboardView();
          },
        ),
      ],
    ),
  ],
);
