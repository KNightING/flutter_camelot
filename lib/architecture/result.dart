import 'package:flutter/cupertino.dart';

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

  failure(
    Object error, {
    String? message,
    T? data,
    int? code,
    StackTrace? stackTrace,
  }) {
    this.call(Failure<T>(
      error,
      data: data,
      code: code,
      message: message,
      stackTrace: stackTrace ?? StackTrace.current,
    ));
  }

  /// seem [failure] and create [MessageError] by [message]
  failureMessage(
    String message, {
    StackTrace? stackTrace,
    T? data,
    int? code,
  }) {
    this.call(Failure<T>(
      MessageError(message),
      data: data,
      code: code,
      stackTrace: stackTrace ?? StackTrace.current,
    ));
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

  bool get hasCode => code != null;

  int get requireCode => code!;
}

class Failure<T> extends Result<T> {
  Failure(
    this.error, {
    this.data,
    this.code,
    String? message,
    this.stackTrace,
  }) : message = message ?? error.toString();

  final T? data;

  final String message;

  final int? code;

  final Object error;

  final StackTrace? stackTrace;

  bool get hasCode => code != null;

  int get requireCode => code!;

  bool get hasData => data != null;

  T get requireData => data!;

  Object get requireError => error;
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

class MessageError extends Error {
  MessageError(this.message) : super();

  final String message;

  @override
  String toString() => message;
}
