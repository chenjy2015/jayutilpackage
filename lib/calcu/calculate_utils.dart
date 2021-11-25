import 'package:flutter/material.dart';

/// 计算工具类
class CalculateUtils {

  ///计算字符长度
  static Size textWidth(BuildContext context, String value, double fontSize,
      FontWeight fontWeight, String fontFamily, {textHeight = 1.0}) {
    TextPainter painter = TextPainter(

      ///AUTO：华为手机如果不指定locale的时候，该方法算出来的文字高度是比系统计算偏小的。
        locale: Localizations.localeOf(context),
        maxLines: 1,
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: value,
            style: TextStyle(
              // height: textHeight,
                fontWeight: fontWeight,
                fontSize: fontSize,
                fontFamily: fontFamily)));
    painter.layout(maxWidth: 1000);

    ///文字的宽度:painter.width
    return Size(painter.width.toDouble(), painter.height.toDouble());
  }


}