import 'package:flutter/material.dart';

///去除水波纹listview
///使用方法：
/// @override
//   Widget build(BuildContext context) {
//     return ScrollConfiguration(
//       behavior: _OverScrollBehavior(),
//       child: ListView(
//         ...
//       ),
//     );
//   }
class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (getPlatform(context) == TargetPlatform.android ||
        getPlatform(context) == TargetPlatform.fuchsia) {
      return GlowingOverscrollIndicator(
        child: child,
        showLeading: false,
        showTrailing: false,
        axisDirection: axisDirection,
        color: Theme.of(context).accentColor,
      );
    } else {
      return child;
    }
  }
}
