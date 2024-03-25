import 'package:flutter/material.dart';

class CustomScrollPhysics extends ScrollPhysics {
  final double maxScrollSpeed;

  const CustomScrollPhysics({ScrollPhysics? parent, required this.maxScrollSpeed}) : super(parent: parent);

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor), maxScrollSpeed: maxScrollSpeed);
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // Limit the scroll speed here
    if (offset.abs() > maxScrollSpeed) {
      return maxScrollSpeed * offset.sign;
    }
    return super.applyPhysicsToUserOffset(position, offset);
  }
}
