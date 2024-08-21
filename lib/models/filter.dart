class Filter {
  final DateTime? startDate;
  final DateTime? endDate;
  final int order;

  const Filter({
    this.startDate,
    this.endDate,
    this.order = 0,
  });
}
