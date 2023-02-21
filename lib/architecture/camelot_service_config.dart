
import 'loading_on.dart';

abstract class CamelotServiceConfig {

  LoadingOnDialogController buildLoadingOnDialogController();

  loadingOnStart(String message);

  loadingOnEnd();
}

class DefaultLoadingOnDialogController extends LoadingOnDialogController{
  @override
  setMessage(String msg) {
  }
}


class DefaultCamelotServiceConfig extends CamelotServiceConfig{

  @override
  LoadingOnDialogController buildLoadingOnDialogController() {
    return DefaultLoadingOnDialogController();
  }

  @override
  loadingOnEnd() {

  }

  @override
  loadingOnStart(String message) {

  }

}