import 'package:flutter/material.dart';

InputDecoration mFieldDecor({required String hint, required String heading, IconData? mIcon,String? mPrefixText}){
  return InputDecoration(
      hintText: hint,
      prefixIcon: mIcon != null ? Icon(mIcon) : null,
      prefixText: mPrefixText,
      label: Text(heading),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21)
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21)
      )
  );

}