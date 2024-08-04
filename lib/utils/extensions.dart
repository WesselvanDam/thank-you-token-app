import 'package:flutter/material.dart';

extension FirstWhereExt<T> on List<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension CustomColors on Colors {
  static const Color tytRed = Color(0xFFEB5353);
  static const Color tytGreen = Color(0xFF36AE7C);
  static const Color tytBlue = Color(0xFF187498);
  static const Color tytYellow = Color(0xFFF9D923);
}