import 'package:flutter/material.dart';

class Styles {
  static final buttonRadius = BorderRadius.circular(8);
  static final cardRadius = BorderRadius.circular(16);

  static final inputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white10,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );
}
