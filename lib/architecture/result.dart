typedef OnResult<T> = Function(Result<T> result);

extension OnResultExtension<T> on OnResult<T> {
  loading(
    String? message,
  ) {
    this.call(Loading(''));
  }

  successful({
    required T data,
    String? message,
    int? code,
  }) {
    this.call(Successful<T>(data, message: message, code: code));
  }

  failure({
    required String message,
    T? data,
    int? code,
  }) {
    this.call(Failure<T>(message, data: data, code: code));
  }
}

abstract class Result<T> {}

class Loading<T> extends Result<T> {
  Loading(this.message);

  final String message;
}

class Successful<T> extends Result<T> {
  Successful(
    this.data, {
    this.message,
    this.code,
  });

  final T data;

  final String? message;

  final int? code;
}

class Failure<T> extends Result<T> {
  Failure(
    this.message, {
    this.data,
    this.code,
  });

  final T? data;

  final String message;

  final int? code;
}
