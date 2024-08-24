class Meta {
  final int? itemCount;
  final int? totalItems;
  final int? itemsPerPage;
  final int? totalPages;
  final int? currentPage;
  final bool? hasNextPage;

  const Meta({
    this.itemCount,
    this.totalItems,
    this.itemsPerPage,
    this.totalPages,
    this.currentPage,
    this.hasNextPage,
  });
}
