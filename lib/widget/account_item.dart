import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget itemInAccount(BuildContext context, String text, Icon icon) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    width: MediaQuery.of(context).size.width * 0.9,
    height: MediaQuery.of(context).size.width * 0.12,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 7),
          Text(
            text,
            style: GoogleFonts.aBeeZee(
                textStyle: const TextStyle(
              fontSize: 16,
            )),
          )
        ],
      ),
    ),
  );
}
