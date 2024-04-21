import 'package:escape_anchovy/res/text/colors.dart';
import 'package:flutter/material.dart';

class CommonOutlineButton extends StatefulWidget {
  const CommonOutlineButton(
      {super.key,
      this.width = double.maxFinite,
      this.height = 50,
      this.onPressed,
      this.text = '',
      this.textStyle,
      this.textColor,
      this.borderColor,
      this.borderRadius = 10});

  final double width;
  final double height;
  final void Function()? onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? borderColor;
  final double borderRadius;

  @override
  State<CommonOutlineButton> createState() => _CommonOutlineButtonState();
}

class _CommonOutlineButtonState extends State<CommonOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: OutlinedButton(
          onPressed: widget.onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
                width: 1.0,
                color: widget.borderColor ??
                    (context.isLight
                        ? LightModeColors.blue
                        : DarkModeColors.blue)),
            padding: const EdgeInsets.all(0.0),
            foregroundColor: widget.textColor ??
                (context.isLight ? LightModeColors.blue : DarkModeColors.blue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ),
          child: Text(widget.text, style: widget.textStyle)),
    );
  }
}
