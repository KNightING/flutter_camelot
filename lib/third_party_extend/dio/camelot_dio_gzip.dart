import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

List<int> dioGzipEncoder(String request, RequestOptions options) {
  options.headers.putIfAbsent('Content-Encoding', () => 'gzip');
  return gzip.encode(utf8.encode(request));
}
