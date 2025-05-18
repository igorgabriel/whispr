import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'how_do_you_feel_view.dart';
import 'shared/bottom_navigation_widget.dart';

class WhispyView extends StatefulWidget {
  const WhispyView({super.key});
  static const String route = '/Whispy';

  @override
  WhispyViewState createState() => WhispyViewState();
}

class WhispyViewState extends State<WhispyView> {
  final whispyBadges = [
    {
      "id": 1,
      "name": "Primeira Confissão",
      "description": "Enviou o primeiro desabafo no app",
    },
    {
      "id": 2,
      "name": "Três Dias Seguidos",
      "description": "Usou o app por 3 dias consecutivos",
    },
    {
      "id": 3,
      "name": "Sete Dias Seguidos",
      "description": "Usou o app por 7 dias consecutivos",
    },
    {
      "id": 4,
      "name": "Desabafou 5 vezes",
      "description": "Enviou 5 confissões no total",
    },
    {
      "id": 5,
      "name": "Desabafou 10 vezes",
      "description": "Enviou 10 confissões no total",
    },
    {
      "id": 6,
      "name": "Confissão Noturna",
      "description": "Enviou uma confissão entre 0h e 5h",
    },
    {
      "id": 7,
      "name": "Consistência Semanal",
      "description": "Abrir o app pelo menos 1x em 7 dias diferentes",
    },
    {
      "id": 8,
      "name": "Texto Profundo",
      "description": "Enviou uma confissão com mais de 300 caracteres",
    },
    {
      "id": 9,
      "name": "Renasceu Calmo",
      "description": "Confessou risco e depois teve uma emoção 'calma'",
    },
    {
      "id": 10,
      "name": "Usuário Pioneiro",
      "description": "Usou o app no período de lançamento (beta)",
    },
  ];
  Future<void> nextScreen() async {
    if (mounted) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (_, __, ___) => const WhispyView(),
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
              'Whispy',
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
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: Color(0xff4b5560),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Olá! Lembre-se que até os dias nublados passam.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Card(
                        color: Color(0xff18222d),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Conquistas',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 110,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: whispyBadges.length,
                                  itemBuilder: (item, index) {
                                    return SizedBox(
                                      width: 150,
                                      child: Card(
                                        color: Color(0xff6e7b8f),

                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Color(0xffb8c6d4),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/heart-octagon.png',
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      whispyBadges[index]["name"]!
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.quicksand(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                whispyBadges[index]["description"]!
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Card(
                        color: Color(0xff4b5560),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.lock_open, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text(
                                    'Privacidade com proteção',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.quicksand(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Aqui no Whispy, você é único, mesmo permanecendo completamente anônimo.\nUtilizamos a tecnologia XxVerifiy para garantir, de forma segura e privada, que cada pessoa que usa o app é real e única sem precisar criar conta, sem rastreamento, sem exposição. Essa prova de identidade protege o espaço emocional de todos, evitando spam e duplicidade, enquanto respeita totalmente sua privacidade.',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
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
