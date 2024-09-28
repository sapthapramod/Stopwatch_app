import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopwatchPage(),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  String _formattedTime() {
    final elapsed = _stopwatch.elapsed;
    final minutes = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    final milliseconds =
        (elapsed.inMilliseconds.remainder(1000) / 10).truncate().toString().padLeft(2, '0');
    return "$minutes:$seconds:$milliseconds";
  }

  void _startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
        setState(() {});
      });
      _stopwatch.start();
    }
  }

  void _stopTimer() {
    _stopwatch.stop();
    setState(() {});
  }

  void _resetTimer() {
    _stopwatch.reset();
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formattedTime(),
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _stopwatch.isRunning ? _stopTimer : _startTimer,
                child: Text(_stopwatch.isRunning ? 'Pause' : 'Start'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _resetTimer,
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
