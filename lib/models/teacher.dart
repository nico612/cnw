import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import "course.dart";
part 'teacher.g.dart';

@JsonSerializable()
class Teacher extends Equatable {
    const Teacher({
              this.brief,
        this.company,
        this.courses,
        this.id,
        this.jobTitle,
        this.logoUrl,
        this.teacherName,

    });
  final String? brief;

  final String? company;

  final List<Course>? courses;

  final int? id;

  @JsonKey(name: "job_title")
  final String? jobTitle;

  @JsonKey(name: "logo_url")
  final String? logoUrl;

  @JsonKey(name: "teacher_name")
  final String? teacherName;

  
  factory Teacher.fromJson(Map<String,dynamic> json) => _$TeacherFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                brief ?? "",
        company ?? "",
        courses ?? "",
        id ?? "",
        jobTitle ?? "",
        logoUrl ?? "",
        teacherName ?? "",

    ];

  Teacher copyWith({
              String? brief,
        String? company,
        List<Course>? courses,
        int? id,
        String? jobTitle,
        String? logoUrl,
        String? teacherName,

    }){

     return Teacher(
               brief: brief ?? this.brief,
        company: company ?? this.company,
        courses: courses ?? this.courses,
        id: id ?? this.id,
        jobTitle: jobTitle ?? this.jobTitle,
        logoUrl: logoUrl ?? this.logoUrl,
        teacherName: teacherName ?? this.teacherName,

     );
  }
}