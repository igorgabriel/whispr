import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff1E2A38),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Desabafos"),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Diário"),
        BottomNavigationBarItem(
          icon: Icon(Icons.sentiment_satisfied),
          label: "Emoções",
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/whispy_icon.png', width: 25),
          label: "Whispy",
        ),
      ],
    );
  }
}
