import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import '/constants/text_styles.dart';

class BlinkingClock extends ConsumerStatefulWidget {
  const BlinkingClock({super.key});

  @override
  ConsumerState<BlinkingClock> createState() => _BlinkingClockState();
}

class _BlinkingClockState extends ConsumerState<BlinkingClock> {
  late Timer _timer;
  bool _showColon = true;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    // Cập nhật thời gian mỗi 500ms để nhấp nháy dấu hai chấm
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _showColon = !_showColon;
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNightMode = ref.watch(isNightModeProvider);
    final hour = _currentTime.hour.toString().padLeft(2, '0');
    final minute = _currentTime.minute.toString().padLeft(2, '0');

    return Text(
      '$hour${_showColon ? ":" : " "}$minute',
      style: isNightMode ? TextStyles.h2NightMode : TextStyles.h2DayMode,
    );
  }
}
