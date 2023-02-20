extension KotlinLikeExtension<T> on T {
  R let<R>(R Function(T it) f) {
    return f(this);
  }

  T also(Function(T it) f) {
    f(this);
    return this;
  }
}
