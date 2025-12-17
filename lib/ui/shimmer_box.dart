import 'package:flutter/material.dart';

class ShimmerBox extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  const ShimmerBox({super.key, this.height, this.width, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(12);

    return ClipRRect(
      borderRadius: radius,
      child: SizedBox(
        height: height,
        width: width,
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Color(0xFFEDEDED)),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
