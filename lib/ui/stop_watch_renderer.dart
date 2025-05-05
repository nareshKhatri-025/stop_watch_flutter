import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stop_watch_flutter/ui/clock_markers.dart';
import 'package:stop_watch_flutter/ui/elapsed_time_text.dart';
import 'clock_hand.dart';

class StopwatchRenderer extends StatelessWidget {
  const StopwatchRenderer(
      {super.key, required this.elapsed, required this.radius});
  final Duration elapsed;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < 60; i++)
          Positioned(
            left: radius,
            top: radius,
            child: ClockSecondTickMarker(radius: radius, seconds: i),
          ),
        for (int i = 5; i <= 60; i += 5)
          Positioned(
            left: radius,
            top: radius,
            child: ClockTextMarker(
              radius: radius,
              value: i,
              maxValue: 60,
            ),
          ),
        Positioned(
          left: radius,
          top: radius,
          child: ClockHand(
            handLength: radius,
            handThickness: 2,
            rotationZAngle: (pi + (2 * pi / 60000) * elapsed.inMilliseconds),
            color: Colors.orange,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: radius * 1.3,
          child: ElapsedTimeText(
            elapsed: elapsed,
          ),
        ),
       
      ],
    );
  }
}
