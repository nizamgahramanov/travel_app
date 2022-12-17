import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectCircular extends StatelessWidget {
  // const ShimmerEffect({Key? key, required this.height, required this.width}) : super(key: key);
  final double height;
  final double width;
  final ShapeBorder shapeBorder;

  const ShimmerEffectCircular.circular(
      {required this.width,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(right: 15, left: 5, top: 5, bottom: 5),
        decoration: ShapeDecoration(
          color: Colors.grey[200],
          shape: shapeBorder,
        ),
      ),
    );
  }
}
