import 'dart:convert';

class Pagination {
  final int limit;
  final int page;
  final int offset;

  const Pagination({
    this.limit = 15,
    this.page = 1,
    this.offset = 0,
  });

  factory Pagination.fromJson(String str) =>
      Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        limit: json["limit"],
        page: json["page"],
        offset: json["offset"],
      );

  Map<String, dynamic> toMap() => {
        "limit": limit,
        "page": page,
        "offset": offset,
      };
}
