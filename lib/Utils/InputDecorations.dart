import 'package:flutter/material.dart';

import 'Colors.dart';

InputDecoration field1Decoration({required String hintText, label}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
    hintText: hintText,
    labelText: label,
    counterText: '',
    // counterStyle: const TextStyle(fontSize: 0),
    hintStyle:
        const TextStyle(color: dullFontColor, fontWeight: FontWeight.normal),
    labelStyle: const TextStyle(
        color: pureBlackColor, fontSize: 11, fontWeight: FontWeight.normal),

    border: InputBorder.none,
  );
}

InputDecoration field2Decoration({required String hintText, label}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
    hintText: hintText,
    labelText: label,

    counterText: '',
    // counterStyle: const TextStyle(fontSize: 0),
    hintStyle:
        const TextStyle(color: dullFontColor, fontWeight: FontWeight.normal),
    labelStyle: const TextStyle(
        color: pureBlackColor, fontSize: 14, fontWeight: FontWeight.normal),

    border: InputBorder.none,
  );
}

InputDecoration field3Decoration({required String hintText, label}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
    hintText: hintText,
    labelText: label,
    counterText: '',
    // counterStyle: const TextStyle(fontSize: 0),
    hintStyle:
        const TextStyle(color: dullFontColor, fontWeight: FontWeight.normal),
    labelStyle: const TextStyle(
        color: pureBlackColor, fontSize: 14, fontWeight: FontWeight.normal),

    border: OutlineInputBorder(),
  );
}
