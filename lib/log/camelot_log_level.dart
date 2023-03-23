import 'package:flutter/material.dart';

enum CamelotLogLevel {
  debug('Ｄ', Colors.blue),
  info('Ｉ', Colors.green),
  warn('Ｗ', Colors.orange),
  error('Ｅ', Colors.red);

  const CamelotLogLevel(this.shortName, this.color);

  final String shortName;

  final Color color;
}
