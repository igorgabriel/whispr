import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/replyAI.dart';
import 'diary_view.dart';
import 'how_do_you_feel_view.dart';

class AIAnswerView extends StatefulWidget {
  final String question;
  final ReplyAI replyAI;

  const AIAnswerView({
    super.key,
    required this.question,
    required this.replyAI,
  });
  static const String route = '/AIAnswer';

  @override
  AIAnswerViewState createState() => AIAnswerViewState();
}

class AIAnswerViewState extends State<AIAnswerView> {
  Future<void> nextScreenDiary() async {
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

  Future<void> nextScreenHowDoYouFeel() async {
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
                      SizedBox(height: 50),
                      ChatBubble(message: widget.question, isSender: true),
                      SizedBox(height: 10),
                      ChatBubble(
                        message: widget.replyAI.reply,
                        isSender: false,
                      ),

                      SizedBox(height: 200),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffB8AEE0),
                                textStyle: const TextStyle(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  'Desabafar novamente',
                                  style: GoogleFonts.quicksand(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                await nextScreenHowDoYouFeel();
                              },
                            ),
                          ),
                          SizedBox(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffB8AEE0),
                                textStyle: const TextStyle(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  'Escrever no diário',
                                  style: GoogleFonts.quicksand(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                await nextScreenDiary();
                              },
                            ),
                          ),
                        ],
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
