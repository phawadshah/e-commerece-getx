import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shop/app/initials/bindings/app_bindings.dart';
import 'package:shop/app/utils/pages/app_pages.dart';
import 'package:shop/app/utils/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      initialRoute: Routes.INITIAL,
      theme: AppTheme.lightThemedata,
      darkTheme: AppTheme.darkThemedata,
      themeMode: ThemeMode.light,
      initialBinding: AppInitialBindings(),
    );
  }
}
