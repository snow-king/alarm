import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

class AlarmHomeShortcutButton extends StatefulWidget {
  final void Function() refreshAlarms;

  const AlarmHomeShortcutButton({super.key, required this.refreshAlarms});

  @override
  State<AlarmHomeShortcutButton> createState() =>
      _AlarmHomeShortcutButtonState();
}

class _AlarmHomeShortcutButtonState
    extends State<AlarmHomeShortcutButton> {
  bool showMenu = false;

  Future<void> onPressButton(int delayInHours) async {
    DateTime dateTime = DateTime.now().add(Duration(hours: delayInHours));

    if (delayInHours != 0) {
      dateTime = dateTime.copyWith(second: 0, millisecond: 0);
    }

    setState(() => showMenu = false);

    alarmPrint(dateTime.toString());

    final alarmSettings = AlarmSettings(
      id: DateTime.now().millisecondsSinceEpoch % 10000,
      dateTime: dateTime,
      assetAudioPath: 'assets/marimba.mp3',
      volumeMax: true,
    );

    await Alarm.set(alarmSettings: alarmSettings);

    widget.refreshAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onLongPress: () {
            setState(() => showMenu = true);
          },
          child: FloatingActionButton(
            onPressed: () => onPressButton(0),
            backgroundColor: Colors.red,
            heroTag: null,
            child: const Text("RING NOW", textAlign: TextAlign.center),
          ),
        ),
        if (showMenu)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => onPressButton(24),
                child: const Text("+24h"),
              ),
              TextButton(
                onPressed: () => onPressButton(36),
                child: const Text("+36h"),
              ),
              TextButton(
                onPressed: () => onPressButton(48),
                child: const Text("+48h"),
              ),
            ],
          ),
      ],
    );
  }
}