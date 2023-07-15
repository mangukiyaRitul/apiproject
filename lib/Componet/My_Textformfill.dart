
import 'package:flutter/material.dart';

import '../Color_Fonts_Error/Fonts.dart';

class My_TextFormField extends StatelessWidget {
  final int maxLine;
  final int? maxlenght;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String hintText;

  const My_TextFormField({super.key,
    this.maxLine =1,
    this.onTap,
    this.maxlenght,
    this.focusNode,
    required this.controller,
    required this.hintText,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      maxLines: maxLine,
      onTap: onTap,
      style: MyTextStyle.medium.copyWith(
      fontSize: 14.5,
      color: Colors.black,
    ),
      maxLength: maxlenght,
      focusNode: focusNode,
      controller: controller,
      cursorHeight: 12,
      cursorWidth: 1,
      readOnly: true,

      decoration: InputDecoration(
        hintText: hintText,
          isCollapsed: true,
          isDense: true,
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
      ),

    );
  }
}
