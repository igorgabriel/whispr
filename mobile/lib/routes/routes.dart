import 'package:flutter/material.dart';

import '../views/screens/diary_view.dart';
import '../views/screens/how_do_you_feel_view.dart';
import '../views/screens/ia_answer_view.dart';
import '../views/screens/login_view.dart';
import '../views/screens/splashscreen_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreenView.route:
        return MaterialPageRoute(
          settings: const RouteSettings(name: SplashScreenView.route),
          builder: (_) => const SplashScreenView(),
        );
      case LoginView.route:
        return MaterialPageRoute(
          settings: const RouteSettings(name: LoginView.route),
          builder: (_) => const LoginView(),
        );
      case HowDoYouFeelView.route:
        return MaterialPageRoute(
          settings: const RouteSettings(name: HowDoYouFeelView.route),
          builder: (_) => const HowDoYouFeelView(),
        );
      case IAAnswerView.route:
        return MaterialPageRoute(
          settings: const RouteSettings(name: IAAnswerView.route),
          builder: (_) => const IAAnswerView(),
        );
      case DiaryView.route:
        return MaterialPageRoute(
          settings: const RouteSettings(name: DiaryView.route),
          builder: (_) => const DiaryView(),
        );
      default:
        return MaterialPageRoute(
          settings: const RouteSettings(name: SplashScreenView.route),
          builder: (_) => const SplashScreenView(),
        );
    }
  }
}
