import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final bool? softWrap;
  final TextDecoration? textDecoration;

  CustomText(
      {Key? key,
        this.title,
        this.fontSize,
        this.textDecoration,
        this.softWrap,
        this.textOverflow,
        this.maxLines,
        this.textAlign,
        this.fontWeight,
        this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      softWrap: softWrap,
      textScaleFactor: 1.0,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
        decoration: textDecoration,
      ),
    );
  }
}
