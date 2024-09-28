import 'package:editing_app/text_info.dart';
import 'package:flutter/material.dart';

class ImageText extends StatelessWidget {
  final TextInfo textInfo;
  const ImageText({
    super.key,
    required this.textInfo,
    });

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      textAlign: textInfo.textAlign,
      style: TextStyle(
        fontSize: textInfo.fontSize,
        fontWeight: textInfo.fontWeight,
        fontStyle: textInfo.fontStyle,
        color:textInfo.color,
      ),

    );
  }
}