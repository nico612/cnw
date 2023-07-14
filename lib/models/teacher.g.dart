// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      brief: json['brief'] as String?,
      company: json['company'] as String?,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
      jobTitle: json['job_title'] as String?,
      logoUrl: json['logo_url'] as String?,
      teacherName: json['teacher_name'] as String?,
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'brief': instance.brief,
      'company': instance.company,
      'courses': instance.courses,
      'id': instance.id,
      'job_title': instance.jobTitle,
      'logo_url': instance.logoUrl,
      'teacher_name': instance.teacherName,
    };
