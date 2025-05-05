import 'dart:math';

import 'package:flutter/material.dart';

class ClockSecondTickMarker extends StatelessWidget {
  const ClockSecondTickMarker(
      {super.key, required this.radius, required this.seconds});

  final int seconds;
  final double radius;
  @override
  Widget build(BuildContext context) {
    final color = seconds % 5 == 0 ? Colors.white : Colors.grey[700];
    final width = 2.0;
    final height = 12.0;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate(-width / 2, -height / 2, 0)
        ..rotateZ(2 * pi * (seconds / 60))
        ..translate(0.0, radius - height / 2, 0.0),
      child: Container(
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}

class ClockTextMarker extends StatelessWidget {
  const ClockTextMarker(
      {super.key,
      required this.maxValue,
      required this.radius,
      required this.value});

  final double radius;
  final int value;
  final int maxValue;

  @override
  Widget build(BuildContext context) {
    const width = 40.0;
    const height = 30.0;
    return SizedBox(
      height: height,
      width: width,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translate(-width / 2, -height / 2, 0)
          ..rotateZ(pi + 2 * pi * (value / maxValue))
          ..translate(0.0, radius - 35, 0.0)
          ..rotateZ(pi - 2 * pi * (value / maxValue)),
        child: Text(
          value.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
