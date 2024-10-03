import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.width, required this.height, required this.color,

    required this.text, required this.style,
  this.colorBorder = Colors.transparent,
    this.widthBorder = 0
  });
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color color;
  final String text;
  final TextStyle style;
  final Color colorBorder;
  final double widthBorder;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,

        decoration: BoxDecoration(
        color: color,
          border: Border.all(
            color: colorBorder,
            width: widthBorder
          ),
          borderRadius: BorderRadius.circular(4)
        ),
        child: Center(
          child:Text(text,style: style,)
        ),
      ),
    );
  }
}
