// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/items.dart';
import '../utils/screen_offset.dart';
import '../widgets/item_card.dart';
import '../widgets/text_reveal.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
      reverseDuration: const Duration(
        milliseconds: 375,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<DisplayOffset, ScrollOffset>(
          buildWhen: (previous, current) {
            if ((current.scrollOffsetValue >= 900 &&
                    current.scrollOffsetValue <= 1300) ||
                controller.isAnimating) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            if (state.scrollOffsetValue > 1100.0) {
              controller.forward();
            } else {
              controller.reverse();
            }
            return TextReveal(
              controller: controller,
              maxHeight: 70.0,
              child: Text(
                'Menu',
                style: GoogleFonts.quicksand(
                  fontSize: 55.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 100.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
          child: Center(
            child: Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 70.0,
              spacing: 180.0,
              children: items
                  .map(
                    (item) => ItemCard(
                      image: item.image,
                      title: item.title,
                      subtitle: item.subtitle,
                      description: item.description,
                      price: item.price,
                      index: items.indexOf(item) + 1,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(
          height: 100.0,
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFBE133C),
          ),
          onPressed: () {},
          child: Text(
            'View More',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
