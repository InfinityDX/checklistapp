class Filter {
  final DateTime? startDate;
  final DateTime? endDate;
  final int order;
  final bool? isCompleted;

  const Filter({
    this.startDate,
    this.endDate,
    this.order = 0,
    this.isCompleted,
  });
}
