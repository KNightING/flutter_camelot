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

class ResultWork<T> {
  ResultWork(
    this.result, {
    this.successful,
    this.failure,
    this.loading,
  }) {
    if (result is Successful<T>) {
      successful?.call(result as Successful<T>);
      return;
    }

    if (result is Failure<T>) {
      failure?.call(result as Failure<T>);
      return;
    }

    if (result is Loading<T>) {
      loading?.call(result as Loading<T>);
      return;
    }
  }

  final Result<T> result;

  final OnSuccessful<T>? successful;

  final OnFailure<T>? failure;

  final OnLoading<T>? loading;
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
