// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherCourse _$TeacherCourseFromJson(Map<String, dynamic> json) =>
    TeacherCourse(
      id: json['id'] as int?,
      imgUrl: json['img_url'] as String?,
      lessonsPlayedTime: json['lessons_played_time'] as int?,
      name: json['name'] as String?,
      nowPrice: (json['now_price'] as num?)?.toDouble(),
      score: json['score'] as int?,
    );

Map<String, dynamic> _$TeacherCourseToJson(TeacherCourse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'img_url': instance.imgUrl,
      'lessons_played_time': instance.lessonsPlayedTime,
      'name': instance.name,
      'now_price': instance.nowPrice,
      'score': instance.score,
    };
