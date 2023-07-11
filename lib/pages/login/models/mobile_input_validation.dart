

import 'package:cniao/utils/regex.utils.dart';
import 'package:formz/formz.dart';

class MobileValidation extends FormzInput<String, String> {

  const MobileValidation.pure() : super.pure(''); //初始值

  const MobileValidation.dirty([String value = '']) : super.dirty(value); //值发生改变时调用该方法

  @override
  String? validator(String value) {
    // 验证输入值，如果返回value null 则验证通过，否则返回错误信息
    if (value.isEmpty) return "手机号不能为空";
    return RegexUtils.isMobileSimple(value) ?  "手机号格式错误" : null;
  }

}