import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shop/app/initials/bindings/app_bindings.dart';
import 'package:shop/app/utils/pages/app_pages.dart';
import 'package:shop/app/utils/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        builder: (context, _) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            getPages: AppPages.pages,
            initialRoute: Routes.INITIAL,
            initialBinding: AppInitialBindings(),
            themeMode: ThemeMode.light,
            theme: KAppTheme.light,
            darkTheme: KAppTheme.dark,
          );
        });
  }
}
