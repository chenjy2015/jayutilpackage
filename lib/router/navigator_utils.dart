import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jay_util_package/log/log_utils.dart';
import 'package:jay_util_package/text/text_utils.dart';

import 'animation_page_route.dart';
import 'animation_type.dart';
import 'fade_route.dart';

class NavigatorUtils {

  /// 解析路由数据并返回map
  Map<String, dynamic> parseRoute(String route) {
    LogUtils.d('parseRoute: $route');
    if (TextUtils.isEmpty(route)){
      return null;
    }
    String routeName = '', jsonData;
    if (route.contains('/')) {
      routeName = route.substring(0, route.indexOf("/"));
      jsonData = route.substring(route.indexOf("/") + 1);
    } else {
      routeName = route;
    }
    Map<String, dynamic> data =
    jsonData != null ? json.decode("$jsonData") : null;
    LogUtils.d('parseRoute: data=$data');
    return {'routeName': routeName, 'data': data};
  }

  /// 从window获取NA传递的路由参数
  // static Map<String, dynamic> parseRouter(Window window){
  //   // window.defaultRouteName就是获取Android传递过来的参数
  //   // 通过这个字段我们就可以进行Flutter页面的路由的分发
  //   String url = window.defaultRouteName;
  //   // route名称，路由path路径名称
  //   String route = url.indexOf('?') == -1 ? url : url.substring(0, url.indexOf('?'));
  //   // 参数Json字符串
  //   String paramsJson = url.indexOf('?') == -1 ? '{}' : url.substring(url.indexOf('?') + 1);
  //   // 解析参数
  //   Map<String, dynamic> params = json.decode(paramsJson);
  //   LogUtils.d('path---->' + route + " " + params.toString());
  //   params["route"] = route;
  //   return params;
  // }

  // 什么是路由管理？？？
  // 简单俩说，导航管理都会维护一个路由栈，
  // 路由入栈(push)操作对应打开一个新页面，
  // 路由出栈(pop)操作对应页面关闭操作，
  // 而路由管理主要是指如何来管理路由栈。
  /// 从根结点跳转页面
  static pushGlobal(GlobalKey<NavigatorState> navigatorKey, Widget scene) {
    // Another exception was thrown:
    // Navigator operation requested with a context that does not include a Navigator.
    // 因为flutter会根据这个context一直上溯，一直到根节点的widget，
    // 注意，上溯是根据context的，会上溯到这个context相关的widget的最根节点
    // 导航到新路由
    try {
      //执行build方法
      var currentState = navigatorKey.currentState;
      currentState.push(MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),);
    } catch (e, stack) {
      // 有异常时则弹出错误提示
      LogUtils.e("路由异常"+e.toString()+"-----"+stack.toString());
    }
  }

  static push(BuildContext context, Widget scene) {
    // 简单封装，导航到新路由
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  /// 跳转页面带动画
  /// 采用原生PageRouteBuilder，这个是一个渐变的效果
  static pushAnimation(BuildContext context, Widget scene) {
    Navigator.push(context, PageRouteBuilder(
        //动画时间为500毫秒
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return new FadeTransition(
            //使用渐隐渐入过渡,
            opacity: animation,
            //路由页面
            child: scene,
          );
        },
      ),
    );
  }

  /// 跳转页面带动画
  static pushAnimationFade(BuildContext context, Widget scene ) {
    Navigator.push(context, FadeRoute(builder: (context) {
      return scene;
    }));
  }

  /// 跳转页面带动画，传入type类型
  /// type ---> SlideRL       从右到左的滑动
  /// type ---> SlideLR       从左到右的滑动
  /// type ---> SlideTB       从上到下的滑动
  /// type ---> SlideBT       从下到上的滑动
  /// type ---> Fade          透明过渡
  static pushAnimationType(BuildContext context, Widget scene , AnimationType type) {
    AnimationPageRoute route = new AnimationPageRoute(
      builder: (context) {
        return scene;
      },
      animationType: type,
    );
    Navigator.push(context, route);
  }

  /// 导航到新路由
  static pushNamed(BuildContext context,String path) {
    // 简单封装，导航到新路由
    if(path!=null){
      //过路由名称来打开新路由，可以使用Navigator 的pushNamed方法
      Navigator.pushNamed(context,path);
    }
  }

  /// 导航到新路由并传入参数
  static pushNamedArguments(BuildContext context,String path,{Object arguments}) {
    // 简单封装，导航到新路由
    if(path!=null){
      //过路由名称来打开新路由，可以使用Navigator 的pushNamed方法
      Navigator.pushNamed(context,path,arguments: arguments);
    }
  }

  static replace(BuildContext context,Widget old, Widget scene) {
    // 简单封装，导航到新路由
    // Navigator.replace(context,oldRoute: old,newRoute: scene);
  }

  static pushAndRemoveUntil(BuildContext context, Widget scene) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ), (route) => route == null
    );
  }

  /// 跳转新页面并返回结果回调
  static pushResult(BuildContext context, Widget scene, Function(Object) function) {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    ).then((result){
      // 页面返回result为null
      if (result == null){
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }
}
