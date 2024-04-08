import 'dart:async';
import 'dart:math';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class LapWatch extends StatefulWidget {
  const LapWatch({Key? key}) : super(key: key);

  @override
  State<LapWatch> createState() => _LapWatchState();
}

class _LapWatchState extends State<LapWatch> {
  late Stopwatch stopwatch;
  late Timer timer;

  double sec = (3 * pi) / 2;
  int secDigital = 0;
  double min = (3 * pi) / 2;
  int minDigital = 0;
  double hour = (3 * pi) / 2;
  int hourDigital = 0;
  int milliseconds = 0;

  List<String> lapTimes = [];

  @override
  void initState() {
    super.initState();

    stopwatch = Stopwatch();

    timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      setState(() {
        secDigital = stopwatch.elapsed.inSeconds % 60;
        minDigital = stopwatch.elapsed.inMinutes % 60;
        hourDigital = stopwatch.elapsed.inHours % 12;
        milliseconds = stopwatch.elapsedMilliseconds % 1000;

        sec = (3 * pi) / 2 + secDigital * (pi / 30);
        min = (3 * pi) / 2 + minDigital * (pi / 30);
        hour = (3 * pi) / 2 + hourDigital * (pi / 6);
      });
    });
  }

  String formatTime(int time) {
    if (time < 10) {
      return '0$time';
    } else {
      return '$time';
    }
  }

  void lapTime() {
    if (stopwatch.isRunning) {
      String lapTime =
          "${lapTimes.length + 1})  ${formatTime(hourDigital)} : ${formatTime(minDigital)} : ${formatTime(secDigital)} : ${milliseconds.toString().padLeft(3, '0')}";
      setState(() {
        lapTimes.add(lapTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
        color: Colors.purple,
        title: NeumorphicText(
          "Stop Watch",
          curve: Curves.bounceOut,
          style: NeumorphicStyle(
            color: Colors.white,
            depth: 2,
            intensity: 1,
          ),
          textStyle: NeumorphicTextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.purple,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NeumorphicText(
                      "${formatTime(hourDigital)} : ${formatTime(minDigital)} : ${formatTime(secDigital)} : ${milliseconds.toString().padLeft(3, '0')}",
                      style: NeumorphicStyle(color: Colors.white),
                      textStyle: NeumorphicTextStyle(fontSize: 40),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NeumorphicButton(
                        onPressed: () {
                          setState(() {
                            lapTime();
                          });
                        },
                        style: NeumorphicStyle(color: Colors.white),
                        child: Text(
                          "Lap",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      NeumorphicButton(
                        onPressed: () {
                          setState(() {
                            if (stopwatch.isRunning) {
                              stopwatch.stop();
                            } else {
                              stopwatch.start();
                            }
                          });
                        },
                        style: NeumorphicStyle(color: Colors.white),
                        child: Text(
                          stopwatch.isRunning ? "Pause" : "Start",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      NeumorphicButton(
                        onPressed: () {
                          setState(() {
                            stopwatch.reset();
                            lapTimes.clear();
                          });
                        },
                        style: NeumorphicStyle(color: Colors.white),
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.purple,
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: lapTimes
                          .map(
                            (lapTime) => Text(
                              lapTime,
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.white,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
