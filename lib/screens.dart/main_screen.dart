import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/screen_offset.dart';
import 'footer.dart';
import 'header.dart';
import 'order.dart';
import 'menu.dart';

import 'payment.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ScrollController controller;
  @override
  void initState() {
    controller = ScrollController();

    controller.addListener(() {
      context.read<DisplayOffset>().changeDisplayOffset(
          (MediaQuery.of(context).size.height + controller.position.pixels)
              .toInt());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: const Column(
        children: [
          Header(),
          SizedBox(
            height: 100.0,
          ),
          Menu(),
          SizedBox(
            height: 100.0,
          ),
          Payment(),
          SizedBox(
            height: 120.0,
          ),
          Order(),
          SizedBox(
            height: 100.0,
          ),
          SizedBox(
            height: 100,
          ),
          Footer(),
        ],
      ),
    );
  }
}
