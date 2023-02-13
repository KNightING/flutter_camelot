#include "include/flutter_camelot/flutter_camelot_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_camelot_plugin.h"

void FlutterCamelotPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_camelot::FlutterCamelotPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
