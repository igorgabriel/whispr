import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'how_do_you_feel_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String route = '/Home';

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  Future<void> nextScreen() async {
    if (mounted) {
      Navigator.of(context).pushNamed(HowDoYouFeelView.route);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          backgroundColor: Color(0xff6E7B8F),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Color(0xff6E7B8F),
                child: FractionallySizedBox(
                  widthFactor:
                      MediaQuery.of(context).size.width > 600 ? 0.60 : 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.png', scale: 1.5),
                      Text(
                        'Aqui você pode desabafar',
                        style: GoogleFonts.quicksand(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'em segurança',
                        style: GoogleFonts.quicksand(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 100),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffB8AEE0),
                            textStyle: const TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'Começar agora',
                            style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () async {
                            await nextScreen();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
