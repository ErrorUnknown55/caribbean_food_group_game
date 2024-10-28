import 'dart:async';
import 'dart:math';

class TimerController {
  final Function onGameOver;
  Timer? _timer;
  int _timeRemaining = 60;

  TimerController({required this.onGameOver});

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        _timeRemaining--;
        if (_timeRemaining <= 0) {
          _timer?.cancel();
          onGameOver();
        }
      }
    });
  }

  void pauseTimer() => _timer?.cancel();

  void resumeTimer() => startTimer();

  void dispose() => _timer?.cancel();
}
