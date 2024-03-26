import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final GestureTapCallback onPressed;
  final String displayText;
  final Color? color;
  final Color? labelColor;
  final double? height;
  final double? width;
  final double? textSize;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.displayText,
      this.color,
      this.labelColor,
      this.height,
      this.textSize,
      this.width})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.indigo,
              Colors.cyan,
            ]),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          height: widget.height ?? 48,
          width: widget.width ?? MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            onPressed: widget.onPressed,
            child: Text(widget.displayText,
                style: TextStyle(
                    color: widget.labelColor ?? Colors.white,
                    fontSize: widget.textSize)),
          )),
    );
  }
}
