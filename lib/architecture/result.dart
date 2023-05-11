typedef OnResult<T> = Function(Result<T> result);

typedef OnSuccessful<T> = Function(Successful<T> result);

typedef OnFailure<T> = Function(Failure<T> result);

typedef OnLoading<T> = Function(Loading<T> result);

extension OnResultExtension<T> on OnResult<T> {
  loading({
    String? message,
  }) {
    this.call(Loading(message));
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

extension OnBoolResultExtension on OnResult<bool> {
  successfulData({
    String? message,
    int? code,
  }) {
    this.call(Successful<bool>(true, message: message, code: code));
  }

  failureData({
    required String message,
    int? code,
  }) {
    this.call(Failure<bool>(message, data: false, code: code));
  }
}

abstract class Result<T> {}

class Loading<T> extends Result<T> {
  Loading(this.message);

  final String? message;
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

extension ResultExtension<T> on Result<T> {
  void when({
    OnSuccessful<T>? successful,
    OnFailure<T>? failure,
    OnLoading<T>? loading,
  }) {
    if (this is Successful<T>) {
      successful?.call(this as Successful<T>);
      return;
    }

    if (this is Failure<T>) {
      failure?.call(this as Failure<T>);
      return;
    }

    if (this is Loading<T>) {
      loading?.call(this as Loading<T>);
      return;
    }
  }
}
