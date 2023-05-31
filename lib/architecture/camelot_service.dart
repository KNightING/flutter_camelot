import 'camelot_service_config.dart';

class CamelotService {
  static final CamelotService _singleton = CamelotService._();

  CamelotService._();

  factory CamelotService() {
    return _singleton;
  }

  CamelotServiceConfig config = CamelotServiceConfig(
    controller: DefaultLoadingOnDialogController(),
  );
}
