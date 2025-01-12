import 'package:fancale/calender/components/graphic_section.dart';
import 'package:flutter/material.dart';

class GraphicArea extends StatelessWidget {
  const GraphicArea({super.key, required this.isTablet});
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 150,
      child: GraphicSection(),
    );
  }
}
