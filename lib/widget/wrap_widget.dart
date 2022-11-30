import 'package:flutter/material.dart';

/*
* 可以让子控件自动换行的控件
*
* */

typedef Widget WrapItemWidget<T>(T value, int index);

class WrapWidget<T> extends StatelessWidget {
  final List<T> data;
  final double spacing;
  final double runSpacing;
  final WrapItemWidget? itemWidget;

  const WrapWidget(
      {Key? key,
      required this.data,
      this.spacing = 12,
      this.runSpacing = 12,
      required this.itemWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*一个渐变颜色的正方形集合*/
    List<Widget> children() => List.generate(data.length, (index) {
          return itemWidget!(data[index], index);
        }).cast();

    return Wrap(
      spacing: spacing, //主轴上子控件的间距
      runSpacing: runSpacing, //交叉轴上子控件之间的间距
      children: children(), //要显示的子控件集合
    );
  }
}
