import 'package:json_annotation/json_annotation.dart';
part 'pagination.g.dart';

///分页实体对象
///genericArgumentFactories：为范型类型参数生成工厂方法
@JsonSerializable(genericArgumentFactories: true)
class Pagination<T> {
  final int page;
  final int size;
  @JsonKey(name: "total_page")
  final int totalPage;
  final T datas;

  const Pagination(
      {required this.page,
      required this.size,
      required this.datas,
      required this.totalPage});


  factory Pagination.fromJson(
          Map<String, dynamic> json, T Function(dynamic datas) fromJsonT) =>
      _$PaginationFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T  datas) toJsonT) =>
      _$PaginationToJson(this, toJsonT);
}
