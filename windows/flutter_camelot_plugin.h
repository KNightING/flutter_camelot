#ifndef FLUTTER_PLUGIN_FLUTTER_CAMELOT_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_CAMELOT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_camelot {

class FlutterCamelotPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterCamelotPlugin();

  virtual ~FlutterCamelotPlugin();

  // Disallow copy and assign.
  FlutterCamelotPlugin(const FlutterCamelotPlugin&) = delete;
  FlutterCamelotPlugin& operator=(const FlutterCamelotPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_camelot

#endif  // FLUTTER_PLUGIN_FLUTTER_CAMELOT_PLUGIN_H_
