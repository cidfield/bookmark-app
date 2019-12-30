

import 'package:flutter/material.dart';

class ValidationMixins {
  String validateName(String value) {
    if(value.isEmpty) {
      return "الرجاء قم بإدخال إسم";
    } else if(_isNumeric(value)) {
      return "الرجاء قم بإدخال الإسم بشكل صحيح (خالي من أرقام او رموز)";
    }
    else if(value.length < 3) {
      return "الرجاء قم بإدخال الإسم بشكل صحيح";
    }
    return null;
  }

  String validateNumber(String value) {
    if(value.isEmpty) {
      return "الرجاء قم بإدخال رقم";
    } else if(!_isNumeric(value) || !RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value)) {
      return "الرجاء قم بإدخال الرقم بشكل صحيح (خالي من الحروف او رموز)";
    }
  }

  bool _isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}