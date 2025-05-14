import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ia_answer_view.dart';

class HowDoYouFeelView extends StatefulWidget {
  const HowDoYouFeelView({super.key});
  static const String route = '/HowDoYouFeel';

  @override
  HowDoYouFeelViewState createState() => HowDoYouFeelViewState();
}

class HowDoYouFeelViewState extends State<HowDoYouFeelView> {
  TextEditingController textController = TextEditingController();

  Future<void> nextScreen() async {
    if (mounted) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (_, __, ___) => const IAAnswerView(),
        ),
      );
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
          backgroundColor: Color(0xff1E2A38),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Color(0xff1E2A38),
                child: FractionallySizedBox(
                  widthFactor:
                      MediaQuery.of(context).size.width > 600 ? 0.60 : 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Como você está se',
                        style: GoogleFonts.quicksand(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'sentindo hoje?',
                        style: GoogleFonts.quicksand(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 70),
                      SizedBox(
                        child: TextFormField(
                          controller: textController,
                          keyboardType: TextInputType.text,
                          maxLength: 255,
                          maxLines: 10,
                          decoration: InputDecoration(
                            counterText: '',
                            errorStyle: const TextStyle(height: 0),
                            filled: true,
                            fillColor: Color(0xffA4B1C0),
                            hintText:
                                'Escreva aqui o que está sentindo, sem julgamentos',
                            hintStyle: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Color(0xff6E7B8F),
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 200),
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
                            'Desabafar',
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
