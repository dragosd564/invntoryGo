import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'modules/splash/splash_binding.dart';
import 'modules/splash/splash_page.dart';
import 'routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        rebuildFactor: (old, data) => true,
        child: GetMaterialApp(
          theme: ThemeData(
            fontFamily: 'aero',
            iconTheme: const IconThemeData(color: Colors.white),
            primaryIconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: 'Inventory GO',
          home: SplashPage(),
          initialBinding: SplashBinding(),
          getPages: AppPages.pages,
        ),
      ),
    );
  }
}
