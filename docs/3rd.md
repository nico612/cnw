- json_serializable： 自动生成`json`和对象的解析文件, example见[官方文档](https://pub.dev/packages/json_serializable)，需要安装`build_runner`插件， `flutter pub add dev:build_runner`, 生成.g.dart文件：`flutter pub run build_runner build`, 
  项目中推荐使用json_serializable + [JSONConverter](https://github.com/vvkeep/JSONConverter) 完成服务端返回的JSON数据解析工
- shared_preferences：数据持久化
- encript：加解密
- Formz：表单验证