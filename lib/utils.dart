import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

//Colors
const black = CupertinoColors.black;
const white = CupertinoColors.white;

//Font
final font = GoogleFonts.montserrat(
  color: black,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

//Reusable Widget
Widget buildPage({
  required Color color,
  required String urlImage,
  required String title,
  required String desc,
}) =>
    Container(
      color: color,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 150.0,
            ),
          ),
          Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: CupertinoColors.black,
              fontSize: 18,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(desc, textAlign: TextAlign.center, style: font),
        ],
      ),
    );
