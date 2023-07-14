import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import "course.dart";
part 'grade.g.dart';

@JsonSerializable()
class Grade extends Equatable {
    const Grade({
              this.applyDeadlineTime,
        this.balancePaymentTime,
        this.buttonDesc,
        this.course,
        this.createdTime,
        this.currentPrice,
        this.graduateTime,
        this.id,
        this.isApplyStop,
        this.learningMode,
        this.lessonsCount,
        this.lessonsTime,
        this.number,
        this.originalPrice,
        this.startClassTime,
        this.status,
        this.stopUseDownPaymentTime,
        this.studentCount,
        this.studentLimit,
        this.studyExpiryDay,
        this.teacherIds,
        this.title,

    });
  @JsonKey(name: "apply_deadline_time")
  final DateTime? applyDeadlineTime;

  @JsonKey(name: "balance_payment_time")
  final String? balancePaymentTime;

  @JsonKey(name: "button_desc")
  final String? buttonDesc;

  final Course? course;

  @JsonKey(name: "created_time")
  final DateTime? createdTime;

  @JsonKey(name: "current_price")
  final double? currentPrice;

  @JsonKey(name: "graduate_time")
  final DateTime? graduateTime;

  final int? id;

  @JsonKey(name: "is_apply_stop")
  final int? isApplyStop;

  @JsonKey(name: "learning_mode")
  final int? learningMode;

  @JsonKey(name: "lessons_count")
  final int? lessonsCount;

  @JsonKey(name: "lessons_time")
  final int? lessonsTime;

  final int? number;

  @JsonKey(name: "original_price")
  final double? originalPrice;

  @JsonKey(name: "start_class_time")
  final DateTime? startClassTime;

  final int? status;

  @JsonKey(name: "stop_use_down_payment_time")
  final String? stopUseDownPaymentTime;

  @JsonKey(name: "student_count")
  final int? studentCount;

  @JsonKey(name: "student_limit")
  final int? studentLimit;

  @JsonKey(name: "study_expiry_day")
  final int? studyExpiryDay;

  @JsonKey(name: "teacher_ids")
  final String? teacherIds;

  final String? title;

  
  factory Grade.fromJson(Map<String,dynamic> json) => _$GradeFromJson(json);
  Map<String, dynamic> toJson() => _$GradeToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                applyDeadlineTime ?? "",
        balancePaymentTime ?? "",
        buttonDesc ?? "",
        course ?? "",
        createdTime ?? "",
        currentPrice ?? "",
        graduateTime ?? "",
        id ?? "",
        isApplyStop ?? "",
        learningMode ?? "",
        lessonsCount ?? "",
        lessonsTime ?? "",
        number ?? "",
        originalPrice ?? "",
        startClassTime ?? "",
        status ?? "",
        stopUseDownPaymentTime ?? "",
        studentCount ?? "",
        studentLimit ?? "",
        studyExpiryDay ?? "",
        teacherIds ?? "",
        title ?? "",

    ];

  Grade copyWith({
              DateTime? applyDeadlineTime,
        String? balancePaymentTime,
        String? buttonDesc,
        Course? course,
        DateTime? createdTime,
        double? currentPrice,
        DateTime? graduateTime,
        int? id,
        int? isApplyStop,
        int? learningMode,
        int? lessonsCount,
        int? lessonsTime,
        int? number,
        double? originalPrice,
        DateTime? startClassTime,
        int? status,
        String? stopUseDownPaymentTime,
        int? studentCount,
        int? studentLimit,
        int? studyExpiryDay,
        String? teacherIds,
        String? title,

    }){

     return Grade(
               applyDeadlineTime: applyDeadlineTime ?? this.applyDeadlineTime,
        balancePaymentTime: balancePaymentTime ?? this.balancePaymentTime,
        buttonDesc: buttonDesc ?? this.buttonDesc,
        course: course ?? this.course,
        createdTime: createdTime ?? this.createdTime,
        currentPrice: currentPrice ?? this.currentPrice,
        graduateTime: graduateTime ?? this.graduateTime,
        id: id ?? this.id,
        isApplyStop: isApplyStop ?? this.isApplyStop,
        learningMode: learningMode ?? this.learningMode,
        lessonsCount: lessonsCount ?? this.lessonsCount,
        lessonsTime: lessonsTime ?? this.lessonsTime,
        number: number ?? this.number,
        originalPrice: originalPrice ?? this.originalPrice,
        startClassTime: startClassTime ?? this.startClassTime,
        status: status ?? this.status,
        stopUseDownPaymentTime: stopUseDownPaymentTime ?? this.stopUseDownPaymentTime,
        studentCount: studentCount ?? this.studentCount,
        studentLimit: studentLimit ?? this.studentLimit,
        studyExpiryDay: studyExpiryDay ?? this.studyExpiryDay,
        teacherIds: teacherIds ?? this.teacherIds,
        title: title ?? this.title,

     );
  }
}