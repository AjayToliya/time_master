import 'package:time_master/screen/Alarm.dart';
import 'package:time_master/screen/analog.dart';
import 'package:time_master/screen/homepage.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:time_master/screen/lap.dart';
import 'package:time_master/screen/timer.dart';

void main() {
  runApp(
    NeumorphicApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        'Stop': (context) => StopWatch(),
        'Alarms': (context) => AlarmPage(),
        'lap': (context) => LapWatch(),
        'aa': (context) => analogueClock(),
      },
    ),
  );
}
