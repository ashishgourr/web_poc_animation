import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/infos.dart';
import '../utils/constants.dart';
import '../utils/screen_offset.dart';
import '../widgets/info_card.dart';
import '../widgets/text_reveal.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> with TickerProviderStateMixin {
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
    return Container(
      height: 510,
      color: backgroundColor,
      child: Column(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          BlocBuilder<DisplayOffset, ScrollOffset>(
              buildWhen: (previous, current) {
            if ((current.scrollOffsetValue >= 1900 &&
                    current.scrollOffsetValue <= 2300) ||
                controller.isAnimating) {
              return true;
            } else {
              return false;
            }
          }, builder: (context, state) {
            if (state.scrollOffsetValue > 2100.0) {
              controller.forward();
            } else {
              controller.reverse();
            }
            return TextReveal(
              controller: controller,
              maxHeight: 55.0,
              child: Text(
                'How It Works',
                style: GoogleFonts.quicksand(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          }),
          const SizedBox(
            height: 40.0,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: infos
                  .map((info) => InfoCard(
                        info: info,
                      ))
                  .toList()),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
