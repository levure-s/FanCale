import 'package:fancale/calender/components/graphic_section.dart';
import 'package:flutter/material.dart';

class GraphicArea extends StatelessWidget {
  const GraphicArea({super.key, required this.isTablet});
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: isTablet ? double.infinity : 150,
      child: const GraphicSection(),
    );
  }
}
