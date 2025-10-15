import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String? buttonName;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final double? fontSize;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;

  const MyButton({
    super.key,
    this.buttonName,
    this.onTap,
    this.fontSize,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(1),
          backgroundColor: WidgetStateProperty.all(
            backgroundColor ?? Colors.transparent,
          ),
          padding: WidgetStateProperty.all(padding),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
              side: BorderSide(
                width: 1,
                color: borderColor ?? Colors.transparent,
              ),
            ),
          ),
        ),
        child: Text(
          maxLines: 1,
          buttonName ?? '',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
