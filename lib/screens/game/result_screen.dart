import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatefulWidget {
  final int countIncorrect;
  const ResultScreen(this.countIncorrect, {super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    String resultGame(int incorrect) {
      if (incorrect == 0) {
        return "Giỏi Vãi Lon";
      } else if (incorrect == 1) {
        return "Dẫy cũng sai";
      } else {
        return "Ngu";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result Game',
          style: GoogleFonts.acme(
              textStyle: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w400,
          )),
        ),
      ),
      body: Container(
        child: Center(
          child: Text(resultGame(widget.countIncorrect)),
        ),
      ),
    );
  }
}
