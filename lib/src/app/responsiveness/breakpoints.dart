enum Breakpoints({
  required final int? upperBound,
  required final int lowerBound,
}) {
  compact(upperBound: 600 - 1, lowerBound: 0),
  medium(upperBound: 840 - 1, lowerBound: 600),
  expanded(upperBound: 1200 - 1, lowerBound: 840),
  large(upperBound: 1600 - 1, lowerBound: 1200),
  extraLarge(upperBound: null, lowerBound: 1600);

  static Breakpoints fromWidth(double width) {
    assert(
      width.isFinite && width >= 0,
      'The width must be non-negative, and finite',
    );

    for (final breakpoint in values) {
      final upperBound = breakpoint.upperBound;
      final lowerBound = breakpoint.lowerBound;

      final withinBounds =
          width >= lowerBound && (upperBound == null || width <= upperBound);
      if (withinBounds) return breakpoint;
    }
    return extraLarge;
  }
}
