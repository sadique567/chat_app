import 'package:chat_app/app/module/help/binding/help_binding.dart';
import 'package:chat_app/app/module/help/view/help_view.dart';
import 'package:chat_app/app/module/login_screen/login_binding/login_bindin.dart';
import 'package:chat_app/app/module/login_screen/login_view/login_view.dart';
import 'package:chat_app/app/module/splash_screen/splash_binding/splash_binding.dart';
import 'package:chat_app/app/module/splash_screen/splash_view/splash_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL_SCREEN = AppRoutes.SPLASH_SCREEN;

  static final myRoutes = [
    GetPage(
      name: _Path.SPLASH_SCREEN,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Path.LOGING_SCREEN,
      page: () => LoginView(),
      binding: LoginBindin(),
    ),
    GetPage(
      name: _Path.CHAT_SCREEN,
      page: () => HelpView(),
      binding: HelpBinding(),
    ),
  ];
}
