import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget itemInAccount(BuildContext context, String text, Icon icon) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Theme.of(context).cardColor,
    ),
    width: MediaQuery.of(context).size.width * 1,
    height: MediaQuery.of(context).size.width * 0.14,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 16),
          Text(
            text,
            style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyText1?.color)),
          )
        ],
      ),
    ),
  );
}
