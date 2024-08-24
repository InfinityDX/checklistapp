extension DateExtensions on DateTime? {
  bool isBetween(DateTime? startDate, DateTime? endDate) {
    final date = this;
    if (date == null) return false;
    if (startDate == null) return false;
    if (endDate == null) return false;

    final startDateInclusive =
        date.isAfter(startDate) || date.isAtSameMomentAs(startDate);
    final endDateInclusive =
        date.isBefore(endDate) || date.isAtSameMomentAs(endDate);

    return startDateInclusive && endDateInclusive;
  }
}
