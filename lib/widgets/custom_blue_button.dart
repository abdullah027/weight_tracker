import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomBlackButton extends StatefulWidget {
  final Function()? onPressed;
  final Color? color,textColor;
  final String? text;
  final double? width;
  final BorderRadius? borderRadius;
  final ShapeBorder? shape;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  CustomBlackButton({Key? key,this.onPressed,this.color,this.text,this.width,this.borderRadius,this.shape,this.textColor,this.child,this.padding}) : super(key: key);

  @override
  _CustomBlackButtonState createState() => _CustomBlackButtonState();
}

class _CustomBlackButtonState extends State<CustomBlackButton> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: widget.width,
      child: MaterialButton(
        padding: widget.padding?? const EdgeInsets.symmetric(
            vertical: 15, horizontal: 20),
        color: widget.color??Colors.black,
        elevation: 5,
        shape: widget.shape??RoundedRectangleBorder(
            borderRadius:widget.borderRadius?? BorderRadius.circular(20)),
        textColor: widget.textColor??Colors.white,
        onPressed: widget.onPressed,
        child: widget.child??CustomText(
          title: widget.text,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
