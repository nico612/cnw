import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teacher_course.g.dart';

@JsonSerializable()
class TeacherCourse extends Equatable {
    const TeacherCourse({
              this.id,
        this.imgUrl,
        this.lessonsPlayedTime,
        this.name,
        this.nowPrice,
        this.score,

    });
  final int? id;

  @JsonKey(name: "img_url")
  final String? imgUrl;

  @JsonKey(name: "lessons_played_time")
  final int? lessonsPlayedTime;

  final String? name;

  @JsonKey(name: "now_price")
  final double? nowPrice;

  final int? score;

  
  factory TeacherCourse.fromJson(Map<String,dynamic> json) => _$TeacherCourseFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherCourseToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                id ?? "",
        imgUrl ?? "",
        lessonsPlayedTime ?? "",
        name ?? "",
        nowPrice ?? "",
        score ?? "",

    ];

  TeacherCourse copyWith({
              int? id,
        String? imgUrl,
        int? lessonsPlayedTime,
        String? name,
        double? nowPrice,
        int? score,

    }){

     return TeacherCourse(
               id: id ?? this.id,
        imgUrl: imgUrl ?? this.imgUrl,
        lessonsPlayedTime: lessonsPlayedTime ?? this.lessonsPlayedTime,
        name: name ?? this.name,
        nowPrice: nowPrice ?? this.nowPrice,
        score: score ?? this.score,

     );
  }
}