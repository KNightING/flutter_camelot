import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:brotli/brotli.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@internal
const brotliStr = 'br';

@internal
const gzipStr = 'gzip';

enum CamelotContentEncoding {
  none(),
  gzip(),
  brotli();
}

class CamelotContentEncodingTransformer extends BackgroundTransformer {
  CamelotContentEncoding _getCamelotContentEncoding(ResponseBody response) {
    for (final entry in response.headers.entries) {
      if (entry.key.toLowerCase() == 'content-encoding') {
        return switch (entry.value.first.toLowerCase()) {
          brotliStr => CamelotContentEncoding.brotli,
          gzipStr => CamelotContentEncoding.gzip,
          _ => CamelotContentEncoding.none
        };
      }
    }
    return CamelotContentEncoding.none;
  }

  @override
  Future transformResponse(
      RequestOptions options, ResponseBody response) async {
    final contentEncoding = _getCamelotContentEncoding(response);

    switch (contentEncoding) {
      case CamelotContentEncoding.brotli:
        response.stream = response.stream
            .cast<List<int>>()
            .transform(brotli.decoder)
            .map((b) => Uint8List.fromList(b));
        break;

      case CamelotContentEncoding.gzip:
        response.stream = response.stream
            .cast<List<int>>()
            .transform(gzip.decoder)
            .map((b) => Uint8List.fromList(b));
        break;

      default:
        break;
    }
    return super.transformResponse(options, response);
  }
}
