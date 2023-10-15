import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Widget label;
  final GestureTapCallback onPressed;
  final double width;
  const AppButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: width,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Color(0xff021B79),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Center(child: label),
        ),
      ),
    );
  }
}
