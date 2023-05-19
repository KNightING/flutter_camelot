import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RiverpodExtension<T> on AsyncValue<T> {
  /// check the value is has data or error and not in refreshing
  ///
  /// [isRefreshing] will set to true and not clear exist value and error when call [WidgetRef.refresh] or [WidgetRef.invalidate]
  ///
  bool get isDone => !isRefreshing && (hasValue || hasError);
}
