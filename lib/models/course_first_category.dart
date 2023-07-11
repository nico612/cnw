import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_first_category.g.dart';

@JsonSerializable()
class CourseFirstCategory extends Equatable {
    const CourseFirstCategory({
              this.code,
        this.id,
        this.title,

    });
  final String? code;

  final int? id;

  final String? title;

  
  factory CourseFirstCategory.fromJson(Map<String,dynamic> json) => _$CourseFirstCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CourseFirstCategoryToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                code ?? "",
        id ?? "",
        title ?? "",

    ];

  CourseFirstCategory copyWith({
              String? code,
        int? id,
        String? title,

    }){

     return CourseFirstCategory(
               code: code ?? this.code,
        id: id ?? this.id,
        title: title ?? this.title,

     );
  }
}