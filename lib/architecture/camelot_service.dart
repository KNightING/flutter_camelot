import 'camelot_service_config.dart';

class CamelotService {
  static final CamelotService _singleton = CamelotService._privateConstructor();

  CamelotService._privateConstructor();

  factory CamelotService() {
    return _singleton;
  }

  CamelotServiceConfig config = CamelotServiceConfig(
    controller: DefaultLoadingOnDialogController(),
  );
}
