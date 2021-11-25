import 'package:flutter/widgets.dart';

/// @author : WangYaJun (kiit@hellotalk.com)
/// @date   : 25/11/2020
/// @description : assets图片资源全局定义

class GlobalAssets {
  static const AssetsPath = 'images/';

  static const DefaultSize = 30.0;

  static const package = "newspackage";

  /// 本地资源assets加载
  /// 设置宽、高,h,w
  /// 如果是正方形，则可以直接设置size值
  static Image asset({
    String assetsPath = AssetsPath,
    @required String assetName,
    @required String packageName,
    double w,
    double h,
    Color color,
    BoxFit fit,

    /// 如果是正方形，则可以直接设置size值
    double size,
  }) {
    if (size != null) {
      w = h = size;
    } else {
      if (w == null || h == null) {
        w = h = size = DefaultSize;
      }
    }

    return Image.asset(
      '$assetsPath$assetName',
      width: w,
      height: h,
      color: color,
      package: packageName ?? package,
      fit: fit,
    );
  }

  static AssetImage assetImage({
    String assetsPath = AssetsPath,
    @required String assetName,
    @required String packageName,
  }) {
    return AssetImage(
      '$assetsPath$assetName',
      package: packageName ?? package,
    );
  }
}
