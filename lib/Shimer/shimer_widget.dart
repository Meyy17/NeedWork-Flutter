import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  ShimmerWidget({super.key, required this.height, required this.width});
  final double height, width;
  final Color _baseColor = Color.fromARGB(245, 213, 210, 210);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: _baseColor,
        highlightColor: Color.fromARGB(245, 164, 157, 157),
        child: Container(
          height: height,
          width: width,
          color: _baseColor,
        ));
  }
}
