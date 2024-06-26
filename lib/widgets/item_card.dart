import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';
import '../utils/screen_offset.dart';

class ItemCard extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final String description;
  final String price;
  final int index;
  const ItemCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.index,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> with TickerProviderStateMixin {
  bool isHovered = false;

  late AnimationController controller;

  late Animation<double> imageReveal;
  late Animation<double> imageOpacity;
  late Animation<double> headingTextOpacity;
  late Animation<double> subTextOpacity;
  late Animation<double> descriptionOpacity;
  late Animation<double> priceOpacity;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
        reverseDuration: const Duration(milliseconds: 500));

    imageReveal = Tween<double>(begin: 00.0, end: 170.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.50, curve: Curves.easeInOutCubic)));

    imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));

    headingTextOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.3, 0.5, curve: Curves.easeOut)));

    subTextOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.4, 0.6, curve: Curves.easeOut)));

    descriptionOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 0.8, curve: Curves.easeOut)));

    priceOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.8, 1.0, curve: Curves.easeOut)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerHeight = constraints.maxWidth < 600 ? 160.0 : 180.0;
        double containerWidth =
            constraints.maxWidth < 600 ? constraints.maxWidth * 0.9 : 520.0;
        // double imageSize = constraints.maxWidth < 600 ? 130.0 : 170.0;
        double fontSizeTitle = constraints.maxWidth < 600 ? 18.0 : 20.0;
        double fontSizeSubtitle = constraints.maxWidth < 600 ? 13.0 : 15.0;
        double fontSizeDescription = constraints.maxWidth < 600 ? 11.0 : 12.0;
        double fontSizePrice = constraints.maxWidth < 600 ? 12.0 : 13.0;
        double verticalSpacing = constraints.maxWidth < 600 ? 5.0 : 10.0;

        return MouseRegion(
          onEnter: (event) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHovered = false;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 375),
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: isHovered
                  ? [
                      const BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 20.0,
                        color: Colors.black12,
                      ),
                    ]
                  : [],
            ),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              clipBehavior: Clip.antiAlias,
              color: Colors.white,
              child: InkWell(
                hoverColor: Colors.white,
                highlightColor: Colors.white,
                splashColor: Colors.black12,
                onTap: () {},
                child: BlocBuilder<DisplayOffset, ScrollOffset>(
                    buildWhen: (previous, current) {
                  if ((current.scrollOffsetValue >= 1000 &&
                          current.scrollOffsetValue <= 1950) ||
                      controller.isAnimating) {
                    return true;
                  } else {
                    return false;
                  }
                }, builder: (context, state) {
                  if (state.scrollOffsetValue >=
                      (1100 + (widget.index * 100))) {
                    controller.forward();
                  } else {
                    controller.reverse();
                  }
                  return AnimatedBuilder(
                      animation: imageOpacity,
                      builder: (context, child) {
                        return SingleChildScrollView(
                          child: Row(
                            children: [
                              SizedBox(
                                height: containerHeight,
                                width: containerHeight,
                                child: Center(
                                  child: FadeTransition(
                                    opacity: imageOpacity,
                                    child: SizedBox(
                                      height: imageReveal.value,
                                      width: imageReveal.value,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          widget.image,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.medium,
                                          scale: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FadeTransition(
                                      opacity: headingTextOpacity,
                                      child: Text(
                                        widget.title,
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w700,
                                          fontSize: fontSizeTitle,
                                        ),
                                      ),
                                    ),
                                    FadeTransition(
                                      opacity: subTextOpacity,
                                      child: Text(
                                        widget.subtitle,
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w500,
                                          fontSize: fontSizeSubtitle,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: verticalSpacing,
                                    ),
                                    FadeTransition(
                                      opacity: descriptionOpacity,
                                      child: Text(
                                        widget.description,
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizeDescription,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: verticalSpacing,
                                    ),
                                    FadeTransition(
                                      opacity: priceOpacity,
                                      child: Text(
                                        widget.price,
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w700,
                                          fontSize: fontSizePrice,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
