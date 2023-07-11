import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_module.g.dart';

@JsonSerializable()
class PageModule extends Equatable {
    const PageModule({
              this.createdTime,
        this.datas,
        this.id,
        this.isShowMore,
        this.layout,
        this.moreRedirectUrl,
        this.scroll,
        this.subTitle,
        this.title,
        this.type,

    });
  @JsonKey(name: "created_time")
  final DateTime? createdTime;

  final List? datas;

  final int? id;

  @JsonKey(name: "is_show_more")
  final int? isShowMore;

  final int? layout;

  @JsonKey(name: "more_redirect_url")
  final String? moreRedirectUrl;

  final int? scroll;

  @JsonKey(name: "sub_title")
  final String? subTitle;

  final String? title;

  final int? type;

  
  factory PageModule.fromJson(Map<String,dynamic> json) => _$PageModuleFromJson(json);
  Map<String, dynamic> toJson() => _$PageModuleToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
                createdTime ?? "",
        datas ?? "",
        id ?? "",
        isShowMore ?? "",
        layout ?? "",
        moreRedirectUrl ?? "",
        scroll ?? "",
        subTitle ?? "",
        title ?? "",
        type ?? "",

    ];

  PageModule copyWith({
              DateTime? createdTime,
        List? datas,
        int? id,
        int? isShowMore,
        int? layout,
        String? moreRedirectUrl,
        int? scroll,
        String? subTitle,
        String? title,
        int? type,

    }){

     return PageModule(
               createdTime: createdTime ?? this.createdTime,
        datas: datas ?? this.datas,
        id: id ?? this.id,
        isShowMore: isShowMore ?? this.isShowMore,
        layout: layout ?? this.layout,
        moreRedirectUrl: moreRedirectUrl ?? this.moreRedirectUrl,
        scroll: scroll ?? this.scroll,
        subTitle: subTitle ?? this.subTitle,
        title: title ?? this.title,
        type: type ?? this.type,

     );
  }
}