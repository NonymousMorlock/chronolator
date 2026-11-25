/// Presentation formats for a duration, normalised into days and smaller units.
///
/// A day is exactly 24 hours, following [Duration]'s definition.
extension DurationPresentation on Duration {
  String get numericHoursDisplay => toString();

  /// Nonzero units, for example `1 day, 6 hours, 1 millisecond`.
  ///
  /// Returns `0 seconds` for zero. A single leading minus sign applies to the
  /// entire duration. Labels and pluralisation are English.
  String get labelledDisplay => _labelledDisplay(includeDays: true);

  String get labelledHoursDisplay => _labelledDisplay(includeDays: false);

  String _labelledDisplay({required bool includeDays}) {
    final parts = _parts;

    final hours = includeDays
        ? parts.hours
        : parts.days * Duration.hoursPerDay + parts.hours;

    final units = [
      if (includeDays) (parts.days, 'day'),
      (hours, 'hour'),
      (parts.minutes, 'minute'),
      (parts.seconds, 'second'),
      (parts.milliseconds, 'millisecond'),
      (parts.microseconds, 'microsecond'),
    ];

    final labels = [
      for (final (value, unit) in units)
        if (value != 0) '$value $unit${value == 1 ? '' : 's'}',
    ];

    if (labels.isEmpty) return '0 seconds';

    final sign = parts.negative ? '-' : '';
    return '$sign${labels.join(', ')}';
  }

  /// `DDD:HH:MM:SS.mmmuuu`, with one leading minus sign when negative.
  ///
  /// Days have a minimum width of three digits; larger values are not
  /// truncated.
  /// The six fractional digits represent microseconds within the second.
  String get numericDisplay {
    final parts = _parts;
    final sign = parts.negative ? '-' : '';

    String pad(int value, int width) => value.toString().padLeft(width, '0');

    return '$sign${pad(parts.days, 3)}:'
        '${pad(parts.hours, 2)}:'
        '${pad(parts.minutes, 2)}:'
        '${pad(parts.seconds, 2)}.'
        '${pad(parts.milliseconds, 3)}'
        '${pad(parts.microseconds, 3)}';
  }

  ({
    bool negative,
    int days,
    int hours,
    int minutes,
    int seconds,
    int milliseconds,
    int microseconds,
  })
  get _parts {
    final total = inMicroseconds;
    final negative = total < 0;

    var days = total ~/ Duration.microsecondsPerDay;
    var remainder = total.remainder(Duration.microsecondsPerDay);

    // Divide before negating so the minimum native int is handled safely.
    // Subtract from zero to avoid producing negative zero on the web.
    if (negative) {
      days = 0 - days;
      remainder = 0 - remainder;
    }

    final hours = remainder ~/ Duration.microsecondsPerHour;
    remainder = remainder.remainder(Duration.microsecondsPerHour);

    final minutes = remainder ~/ Duration.microsecondsPerMinute;
    remainder = remainder.remainder(Duration.microsecondsPerMinute);

    final seconds = remainder ~/ Duration.microsecondsPerSecond;
    remainder = remainder.remainder(Duration.microsecondsPerSecond);

    final milliseconds = remainder ~/ Duration.microsecondsPerMillisecond;
    final microseconds = remainder.remainder(
      Duration.microsecondsPerMillisecond,
    );

    return (
      negative: negative,
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
      microseconds: microseconds,
    );
  }
}
