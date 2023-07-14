import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import "course_first_category.dart";
part 'course.g.dart';

@JsonSerializable()
class Course extends Equatable {
    const Course({
              this.brief,
        this.commentCount,
        this.courseType,
        this.discountInfo,
        this.expiryDay,
        this.finishedLessonsCount,
        this.firstCategory,
        this.h5site,
        this.id,
        this.imgUrl,
        this.isDistribution,
        this.isFree,
        this.isLive,
        this.lessonsCount,
        this.lessonsPlayedTime,
        this.name,
        this.nowPrice,
        this.pintuanInfo,
        this.website,

    });
  final String? brief;

  @JsonKey(name: "comment_count")
  final int? commentCount;

  @JsonKey(name: "course_type")
  final int? courseType;

  @JsonKey(name: "discount_info")
  final String? discountInfo;

  @JsonKey(name: "expiry_day")
  final int? expiryDay;

  @JsonKey(name: "finished_lessons_count")
  final int? finishedLessonsCount;

  @JsonKey(name: "first_category")
  final CourseFirstCategory? firstCategory;

  final String? h5site;

  final int? id;

  @JsonKey(name: "img_url")
  final String? imgUrl;

  @JsonKey(name: "is_distribution")
  final bool? isDistribution;

  @JsonKey(name: "is_free")
  final bool? isFree;

  @JsonKey(name: "is_live")
  final bool? isLive;

  @JsonKey(name: "lessons_count")
  final int? lessonsCount;

  @JsonKey(name: "lessons_played_time")
  final int? lessonsPlayedTime;

  final String? name;

  @JsonKey(name: "now_price")
  final double? nowPrice;

  @JsonKey(name: "pintuan_info")
  final String? pintuanInfo;

  final String? website;

  
  factory Course.fromJson(Map<String,dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                brief ?? "",
        commentCount ?? "",
        courseType ?? "",
        discountInfo ?? "",
        expiryDay ?? "",
        finishedLessonsCount ?? "",
        firstCategory ?? "",
        h5site ?? "",
        id ?? "",
        imgUrl ?? "",
        isDistribution ?? "",
        isFree ?? "",
        isLive ?? "",
        lessonsCount ?? "",
        lessonsPlayedTime ?? "",
        name ?? "",
        nowPrice ?? "",
        pintuanInfo ?? "",
        website ?? "",

    ];

  Course copyWith({
              String? brief,
        int? commentCount,
        int? courseType,
        String? discountInfo,
        int? expiryDay,
        int? finishedLessonsCount,
        CourseFirstCategory? firstCategory,
        String? h5site,
        int? id,
        String? imgUrl,
        bool? isDistribution,
        bool? isFree,
        bool? isLive,
        int? lessonsCount,
        int? lessonsPlayedTime,
        String? name,
        double? nowPrice,
        String? pintuanInfo,
        String? website,

    }){

     return Course(
               brief: brief ?? this.brief,
        commentCount: commentCount ?? this.commentCount,
        courseType: courseType ?? this.courseType,
        discountInfo: discountInfo ?? this.discountInfo,
        expiryDay: expiryDay ?? this.expiryDay,
        finishedLessonsCount: finishedLessonsCount ?? this.finishedLessonsCount,
        firstCategory: firstCategory ?? this.firstCategory,
        h5site: h5site ?? this.h5site,
        id: id ?? this.id,
        imgUrl: imgUrl ?? this.imgUrl,
        isDistribution: isDistribution ?? this.isDistribution,
        isFree: isFree ?? this.isFree,
        isLive: isLive ?? this.isLive,
        lessonsCount: lessonsCount ?? this.lessonsCount,
        lessonsPlayedTime: lessonsPlayedTime ?? this.lessonsPlayedTime,
        name: name ?? this.name,
        nowPrice: nowPrice ?? this.nowPrice,
        pintuanInfo: pintuanInfo ?? this.pintuanInfo,
        website: website ?? this.website,

     );
  }
}