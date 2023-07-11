// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      brief: json['brief'] as String?,
      commentCount: json['comment_count'] as int?,
      courseType: json['course_type'] as int?,
      discountInfo: json['discount_info'] as String?,
      expiryDay: json['expiry_day'] as int?,
      finishedLessonsCount: json['finished_lessons_count'] as int?,
      firstCategory: json['first_category'] == null
          ? null
          : CourseFirstCategory.fromJson(
              json['first_category'] as Map<String, dynamic>),
      h5site: json['h5site'] as String?,
      id: json['id'] as int?,
      imgUrl: json['img_url'] as String?,
      isDistribution: json['is_distribution'] as bool?,
      isFree: json['is_free'] as bool?,
      isLive: json['is_live'] as bool?,
      lessonsCount: json['lessons_count'] as int?,
      lessonsPlayedTime: json['lessons_played_time'] as int?,
      name: json['name'] as String?,
      nowPrice: (json['now_price'] as num?)?.toDouble(),
      pintuanInfo: json['pintuan_info'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'brief': instance.brief,
      'comment_count': instance.commentCount,
      'course_type': instance.courseType,
      'discount_info': instance.discountInfo,
      'expiry_day': instance.expiryDay,
      'finished_lessons_count': instance.finishedLessonsCount,
      'first_category': instance.firstCategory,
      'h5site': instance.h5site,
      'id': instance.id,
      'img_url': instance.imgUrl,
      'is_distribution': instance.isDistribution,
      'is_free': instance.isFree,
      'is_live': instance.isLive,
      'lessons_count': instance.lessonsCount,
      'lessons_played_time': instance.lessonsPlayedTime,
      'name': instance.name,
      'now_price': instance.nowPrice,
      'pintuan_info': instance.pintuanInfo,
      'website': instance.website,
    };
