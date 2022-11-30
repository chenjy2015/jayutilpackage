import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetUtil {
  ///创建一个带有毛玻璃背景的widget
  static Widget createGroundGlass({
    Widget? background,
    Widget? child,
    double? width,
    double? height,
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
    double opacity = 0.2,
    double sigmaX = 5.0,
    double sigmaY = 5.0,
    Color? glassColor,
  }) {
    ///圆角
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight),
    );

    ///毛玻璃背景
    BackdropFilter backdropFilter = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: Opacity(
        opacity: opacity,
        child: Container(
          decoration: BoxDecoration(
            color: glassColor ?? Color(0x80FFFFFF),
          ),
        ),
      ),
    );

    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          //约束性盒子
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: ClipRRect(
              child: background,
              borderRadius: borderRadius,
            ),
          ),
          Center(
            //可裁切的矩形
            child: ClipRRect(
              borderRadius: borderRadius,
              //背景过滤器
              child: backdropFilter,
            ),
          ),
          Center(
            child: child,
          ),
        ],
      ),
    );
  }
}
