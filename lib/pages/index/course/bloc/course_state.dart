
part of 'course_bloc.dart';


class CourseState extends Equatable {
  
  const CourseState({
    this.courses = const [],
    this.noMore = false,
    this.isLoading = false
  });

  final List<Course> courses;
  final bool noMore;
  final bool isLoading;
  
  @override
  List<Object?> get props => [courses, noMore];

  CourseState copyWith({List<Course>? courses, bool? noMore, bool? isLoading}) {
      return CourseState(
        courses: courses ?? this.courses,
        noMore: noMore ?? this.noMore,
        isLoading: isLoading ?? this.isLoading
        );
  }
  

}