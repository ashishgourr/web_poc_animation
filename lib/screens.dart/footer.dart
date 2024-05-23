import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/footer.dart';
import '../utils/constants.dart';
import '../widgets/footer_links.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: footer
                  .map((footer) => FooterLink(
                        footer: footer,
                      ))
                  .toList(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 50.0,
              right: 80.0,
            ),
            height: 200.0,
            width: 250.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Subscribe Now',
                  style: GoogleFonts.quicksand(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.person_outline_rounded,
                      color: Colors.black,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    hintText: 'Your Email',
                    hintStyle: GoogleFonts.quicksand(
                      color: Colors.black45,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black26,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black26,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 50.0,
                  width: 250.0,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Subscribe Now',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
