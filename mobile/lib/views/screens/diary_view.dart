import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'how_do_you_feel_view.dart';
import 'shared/bottom_navigation_widget.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({super.key});
  static const String route = '/Diary';

  @override
  DiaryViewState createState() => DiaryViewState();
}

class DiaryViewState extends State<DiaryView> {
  final List<Map<String, String>> entries = const [
    {
      "date": "04 de maio de 2025",
      "text":
          "Hoje foi um dia estranho. Tive momentos bons, mas por dentro parecia que algo estava fora do lugar...",
    },
    {
      "date": "02 de maio de 2025",
      "text":
          "Hoje me ouvi. Respirei fundo, reconheci minhas emoções e aceitei que está tudo bem não estar bem...",
    },
    {
      "date": "30 de abril de 2025",
      "text":
          "Consegui acordar mais leve hoje. Não sei se foi a conversa com o Whispr ou o simples fato de ter escrito, mas...",
    },
  ];

  Future<void> nextScreen() async {
    if (mounted) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (_, __, ___) => const DiaryView(),
        ),
      );
    }
  }

  Future<void> gotoHowDoYouFeel() async {
    if (mounted) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (_, __, ___) => const HowDoYouFeelView(),
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
          appBar: AppBar(
            backgroundColor: Color(0xffB8AEE0),
            automaticallyImplyLeading: false,
            title: Text(
              'Diário',
              style: GoogleFonts.quicksand(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: BottomNavigationWidget(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xffB8AEE0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            onPressed: () {
              gotoHowDoYouFeel();
            },
            child: Image.asset('assets/images/message-plus-circle.png'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Color(0xff1E2A38),
                child: FractionallySizedBox(
                  widthFactor:
                      MediaQuery.of(context).size.width > 600 ? 0.60 : 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: entries.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entries[index]["date"]!,
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    entries[index]["text"]!,
                                    style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/calm.png',
                                  width: 50,
                                ),
                              ],
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
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

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  const ChatBubble({super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isSender ? Color(0xffB8AEE0) : Color(0xffA6E3C8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
