import 'package:flutter/material.dart';

enum CamelotLogLevel {
  debug('D', Colors.blue),
  info('I', Colors.green),
  warn('W', Colors.orange),
  error('E', Colors.red);

  const CamelotLogLevel(this.shortName, this.color);

  final String shortName;

  final Color color;
}
