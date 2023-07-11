
import 'package:formz/formz.dart';

class PasswordInputValidation extends FormzInput<String, String> {

  // //输入字段的初始值，即尚未进行任何更改或验证。当用户号开始与该字段进行交互时，输入字段的状态将转变为 FormzInput.dirty。
  const PasswordInputValidation.pure() : super.pure('');

  //表示输入字段的已被用户修改或进行验证，这个状态用于确定是否应该显示错误消息或执行其他表单验证逻辑
  const PasswordInputValidation.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String value) {
    if (value.isEmpty) return "请输入登录密码";
    if (value.length < 6) return "密码不能少于6个字符";

  }



}