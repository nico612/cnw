

import 'dart:js';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

Handler homeHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return Container();
});

Handler loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return Container();
});

Handler courseDetailHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  // return CourseDetailPage(
  //   courseId: int.parse(parameters['courseId']![0]),
  // );
  return Container();
});

Handler lessonPlayHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  // return LessonPlayPage(
  //   courseId: int.parse(parameters['courseId']![0]),
  //   lessonKey: parameters['lessonKey']?[0],
  // );
  return Container();
});

Handler webViewPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  // return WebViewPage(
  //   url: parameters["url"]![0],
  //   title: parameters["title"]?.first,
  //   isLocalUrl: false,
  // );
  return Container();
});

Handler emptyHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return Container();
});
