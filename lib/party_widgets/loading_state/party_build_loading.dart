import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PartyBuildLoading extends StatelessWidget {
  PartyBuildLoading({this.height = 100, this.margin = const EdgeInsets.fromLTRB(10, 0, 10, 10)});
  double height;
  EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100],
      highlightColor: Colors.grey[300],
      child: Container(
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}