import 'package:apiproject/Color_Fonts_Error/Color-const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Color_Fonts_Error/Fonts.dart';

class My_TextFormField2 extends StatelessWidget {
  final int maxLine;
  final int? maxlenght;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String? label,hinttext;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;

  const My_TextFormField2({super.key,
    this.maxLine = 1,
    this.onTap,
    this.maxlenght,
    this.focusNode,
    required this.controller,
    this.label,
    this.hinttext = '',
     this.validator,
     this.inputFormatters,
    this.keyboardType,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onChanged,

  });

  @override
  Widget build(BuildContext context) {

    return Theme(data: ThemeData(
      useMaterial3: false
    ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if (label != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  "$label",
                  style: MyTextStyle.semiBold.copyWith(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),

            TextFormField(

              onChanged: onChanged,
              maxLines: maxLine,
              onTap: onTap,
              maxLength: maxlenght,
              focusNode: focusNode,
              controller: controller,
              // cursorHeight: 15,
              cursorWidth: 1,
              validator: validator,
              inputFormatters:inputFormatters,
              keyboardType: keyboardType,
              onFieldSubmitted: onFieldSubmitted,
              textInputAction:textInputAction ,
              decoration: InputDecoration(
                counterText: "",
                  hintText: "$hinttext",
                  isDense: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppPrimary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))
              ),

            ),
          ],
        ));
  }
}