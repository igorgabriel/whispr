import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'di/injector.dart';
import 'routes/routes.dart';
import 'viewmodels/how_do_you_feel_view_model.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await initSingletons();

  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HowDoYouFeelViewModel()),
      ],
      child: MaterialApp(
        title: 'Whispr',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff330099)),
          useMaterial3: true,
          fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
