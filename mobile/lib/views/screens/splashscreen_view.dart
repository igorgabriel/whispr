import 'package:flutter/material.dart';

import 'home_view.dart';
import 'login_view.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  static const String route = '/';

  @override
  SplashScreenViewState createState() => SplashScreenViewState();
}

void gotoLogin(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(seconds: 2),
      pageBuilder: (_, __, ___) => const LoginView(),
    ),
  );
}

class SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        gotoLogin(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          color: Colors.white,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Center(
              child: SizedBox(),

              // GestureDetector(
              //     child: Image.asset('assets/images/logo.png'),
              //     onTap: () => gotoLogin(context)))
            ),
          ),
        );
      },
    );
  }
}
