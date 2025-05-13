import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'routes/routes.dart';
import 'viewmodels/view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initSingletons();

  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ViewModel())],
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
