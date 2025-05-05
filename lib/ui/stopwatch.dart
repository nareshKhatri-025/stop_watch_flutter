import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stop_watch_flutter/ui/elapsed_time_text.dart';
import 'package:stop_watch_flutter/ui/reset_button.dart';
import 'package:stop_watch_flutter/ui/stop_watch_renderer.dart';
import 'elapsed_time_text_basic.dart';
import 'start_stop_button.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  _StopwatchState createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch>
    with SingleTickerProviderStateMixin {
  Duration _currentlyElapsed = Duration.zero;
  Duration _previouslyElapsed = Duration.zero;

  Duration get _elapsed => _currentlyElapsed + _previouslyElapsed;
  late Ticker _ticker;
  @override
  void initState() {
    _ticker = createTicker((elapsed) {
      _currentlyElapsed = elapsed;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _reset() {
    _ticker.stop();
    setState(() {
      _currentlyElapsed = Duration.zero;
      _previouslyElapsed = Duration.zero;
      _isRunning = false;
    });
  }

  bool _isRunning = false;
  _toggleRunning() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        _ticker.start();
      } else {
        _ticker.stop();
        _previouslyElapsed = _elapsed;
        _currentlyElapsed = Duration.zero;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constaints) {
        final radius = constaints.maxWidth / 2;
        return Stack(
          children: [
            StopwatchRenderer(
              elapsed: _elapsed,
              radius: radius,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: ResetButton(
                    onPressed: _reset,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: StartStopButton(
                    isRunning: _isRunning,
                    onPressed: _toggleRunning,
                  ),
                ),
              ),
            ])
          ],
        );
      },
    );
  }
}
