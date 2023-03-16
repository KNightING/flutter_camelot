//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_camelot/flutter_camelot_plugin.h>
#include <isar_flutter_libs/isar_flutter_libs_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) flutter_camelot_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterCamelotPlugin");
  flutter_camelot_plugin_register_with_registrar(flutter_camelot_registrar);
  g_autoptr(FlPluginRegistrar) isar_flutter_libs_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "IsarFlutterLibsPlugin");
  isar_flutter_libs_plugin_register_with_registrar(isar_flutter_libs_registrar);
}
