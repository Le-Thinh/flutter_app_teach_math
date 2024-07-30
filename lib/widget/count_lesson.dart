import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonCountCard extends StatelessWidget {
  final String title;
  final int count;

  const LessonCountCard({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.acme(
              textStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: GoogleFonts.acme(
              textStyle: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
