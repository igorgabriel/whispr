import 'package:flutter/material.dart';

import '../models/replyAI.dart';
import '../views/screens/diary_view.dart';
import '../views/screens/how_do_you_feel_view.dart';
import '../views/screens/ai_answer_view.dart';
import '../views/screens/login_view.dart';
import '../views/screens/splashscreen_view.dart';
import '../views/screens/whispy_view.dart';

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
      case AIAnswerView.route:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AIAnswerView.route),
          builder: (_) {
            List<dynamic> args = settings.arguments as List<dynamic>;
            return AIAnswerView(
              question: args[0] as String,
              replyAI: args[1] as ReplyAI,
            );
          },
        );
      case DiaryView.route:
        return MaterialPageRoute(
          settings: const RouteSettings(name: DiaryView.route),
          builder: (_) => const DiaryView(),
        );
      case WhispyView.route:
        return MaterialPageRoute(
          settings: const RouteSettings(name: WhispyView.route),
          builder: (_) => const WhispyView(),
        );
      default:
        return MaterialPageRoute(
          settings: const RouteSettings(name: SplashScreenView.route),
          builder: (_) => const SplashScreenView(),
        );
    }
  }
}
