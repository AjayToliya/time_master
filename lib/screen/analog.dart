import 'dart:math';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:one_clock/one_clock.dart';

class analogueClock extends StatefulWidget {
  const analogueClock({super.key});

  @override
  State<analogueClock> createState() => _analogueClockState();
}

class _analogueClockState extends State<analogueClock> {
  DateTime time = DateTime.now();
  double sec = (3 * pi) / 2;
  int secDigital = 0;
  double min = (3 * pi) / 2;
  int minDigital = 0;
  double hour = (3 * pi) / 2;
  int hourDigital = 0;
  @override
  void initState() {
    super.initState();

    setState(() {
      minDigital = time.minute;
      secDigital = time.second;
      hourDigital = time.hour;

      sec = sec + secDigital * (pi / 30);
      min = min + minDigital * (pi / 30);
      hour = hour + hourDigital * (pi / 6);
    });

    timer();
  }

  void timer() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (secDigital >= 59) {
          sec = (3 * pi) / 2;
          secDigital = 0;
          minDigital++;
          min = min + (pi / 30);
        } else if (minDigital >= 59) {
          min = (3 * pi) / 2;
          minDigital = 0;
          hour = hour + (pi / 6);
          hourDigital++;
        } else {
          secDigital++;
          sec = sec + (pi / 30);
        }
      });
      timer();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        color: Colors.purple,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
        title: NeumorphicText(
          "Analog Clock",
          style: NeumorphicStyle(
            color: Colors.white,
            depth: 1,
            intensity: 1,
          ),
          textStyle: NeumorphicTextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        color: Colors.purple,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Neumorphic(
            style: NeumorphicStyle(
              depth: -10,
              intensity: 5,
              shadowDarkColorEmboss: Colors.black.withOpacity(.5),
              shadowLightColorEmboss: Colors.black.withOpacity(.5),
              boxShape: NeumorphicBoxShape.circle(),
            ),
            child: Container(
              color: Colors.purple,
              child: Align(
                alignment: Alignment.center,
                child: AnalogClock(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                    ),
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  width: 300,
                  isLive: true,
                  tickColor: Colors.white,
                  hourHandColor: Colors.white,
                  minuteHandColor: Colors.white,
                  showSecondHand: true,
                  numberColor: Colors.white,
                  showNumbers: true,
                  showAllNumbers: true,
                  textScaleFactor: 1.4,
                  showTicks: true,
                  secondHandColor: Colors.white,
                  showDigitalClock: false,
                  datetime: DateTime.now(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
