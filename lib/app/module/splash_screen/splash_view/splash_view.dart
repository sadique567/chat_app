import 'package:chat_app/app/module/splash_screen/splash_controller/splash_controller.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/utils/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class SplashView extends GetView<SplashController> {
  final List<Widget> _list = <Widget>[
    Center(child: AppNameSplashScreen()),
    Center(child: LoginScreenProcess()),
  ];

  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // final double fontSize_splas = 34;

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: _list,
      ),
    );
  }
}

// -----------------2nd  Login screen Process ======================
class LoginScreenProcess extends StatelessWidget {
  const LoginScreenProcess({super.key});

  @override
  Widget build(BuildContext context) {
    final double appnameSize = 24;
    final double headingSize = 16;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // Image.asset(
              //   "asset/image/logo.png",
              //   height: MediaQuery.of(context).size.height / 3,
              // ),
              Text(
                "HELLO 👋",
                style: TextStyle(
                  fontSize: appnameSize,
                  fontWeight: FontWeight.w900,
                  color: Colors.green,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 10),
              RichText(
                maxLines: 2,
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: headingSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: "Welcome to "),
                    TextSpan(
                      text: "Reliwell",
                      style: TextStyle(
                        fontSize: appnameSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.2,
                      ),
                    ),
                    TextSpan(
                      text: "Technologies",
                      style: TextStyle(
                        fontSize: appnameSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: 1.2,
                      ),
                    ),
                    TextSpan(text: "where you manage your daily trading"),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),

              MyButton(
                height: 50,
                width: Get.width,
                buttonName: "Login",
                textColor: Colors.white,
                fontSize: 18,
                borderRadius: 12,
                backgroundColor: Colors.blue,
                onTap: () {
                  EasyLoading.showInfo("Login");
                  Get.offAndToNamed(AppRoutes.LOGING_SCREEN);
                },
              ),
              SizedBox(height: 20),
              MyButton(
                height: 50,
                width: Get.width,
                buttonName: "Sign Up",
                textColor: Colors.blue,
                fontSize: 18,
                borderRadius: 12,
                backgroundColor: Colors.white,
                borderColor: Colors.blue,
                onTap: () {
                  EasyLoading.showInfo("Pending");
                  // Get.offAndToNamed(AppRoutes.SIGNUP_SCREEN);
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),

              Text(
                "Sign Up using",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  // letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // _circleIconButton(
                  //   image: "asset/socialmedia/linkedin.png",
                  //   onTap: () {},
                  // ),

                  // SizedBox(width: 10),
                  // _circleIconButton(
                  //   image: "asset/socialmedia/google.png",
                  //   onTap: () {},
                  // ),
                  SizedBox(width: 10),

                  // _circleIconButton(
                  //   image: "asset/socialmedia/facebook.png",
                  //   onTap: () {},
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------Circle Image Button ------------
Widget _circleIconButton({String? image, Callback? onTap}) {
  return Container(
    height: 60,
    width: 60,
    padding: EdgeInsets.all(2),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
    child: InkWell(onTap: onTap, child: Image.asset(image!, scale: 9)),
  );
}

// ============= 1st Screen ---------

class AppNameSplashScreen extends StatefulWidget {
  const AppNameSplashScreen({super.key});

  @override
  State<AppNameSplashScreen> createState() => _AppNameSplashScreenState();
}

class _AppNameSplashScreenState extends State<AppNameSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Text(
          "Chat App",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
