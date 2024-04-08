import 'dart:math';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime time = DateTime.now();
  double sec = (3 * pi) / 2;
  int secDigital = 0;
  double min = (3 * pi) / 2;
  int minDigital = 0;
  double hour = (3 * pi) / 2;
  int hourDigital = 0;
  int hourtemp = 0;

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
    Future.delayed(Duration(seconds: 1), () {
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

        if (hourDigital > 12) (hourDigital = hourDigital - 12);
        hourtemp = hourDigital;
        if (hourDigital > 11) (hourtemp = hourDigital - 12);
      });
      timer();
    });
  }

  String formatTime(int time) {
    if (time < 10) {
      return '0$time';
    } else {
      return '$time';
    }
  }

  bool onOff = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        color: Colors.purple,
        title: NeumorphicText(
          "Strap Watch",
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
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.purple,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.white,
                          // backgroundImage: NetworkImage(
                          //     'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTEyL3Jhd3BpeGVsX29mZmljZV8yN19yZWFsaXN0aWNfcGhvdG9fb2Zfc21pbGluZ19oYW5kc29tZV95b3VuZ19pbl8xNWExMTE1ZC0xZTBiLTQ4YjAtOGEyNi01ZDE1ZmE3Njg2MzYucG5n.png'),
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.purple,
                            size: 140,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Hi Ajay...',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "How's The Day",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.purple,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeumorphicButton(
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pushNamed('Alarms');
                        });
                      },
                      style: NeumorphicStyle(color: Colors.white),
                      child: Text(
                        "Alarm ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    NeumorphicButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('Stop');
                      },
                      style: NeumorphicStyle(color: Colors.white),
                      child: Text(
                        "Timer",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    NeumorphicButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('lap');
                      },
                      style: NeumorphicStyle(color: Colors.white),
                      child: Text(
                        "Stop Watch",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    NeumorphicButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('aa');
                      },
                      style: NeumorphicStyle(color: Colors.white),
                      child: Text(
                        "Analog",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                Container(
                  color: Colors.purple,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Neumorphic(
                            style: NeumorphicStyle(
                              depth: -10,
                              intensity: 5,
                              boxShape: NeumorphicBoxShape.circle(),
                            ),
                            child: Container(
                              color: Colors.purple,
                              height: 390,
                              width: 390,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  (onOff == true)
                                      ? NeumorphicText(
                                          style: NeumorphicStyle(
                                            color: Colors.white,
                                            depth: 3,
                                            intensity: 1,
                                          ),
                                          "${formatTime(hourDigital)} : ${formatTime(minDigital)} : ${formatTime(secDigital)}",
                                          textStyle: NeumorphicTextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 30,
                                          ),
                                        )
                                      : Text(""),
                                  CircularProgressIndicator(
                                    value: hourtemp * (1 / 12),
                                    color: Color(0xffFFFF99),
                                    strokeWidth: 16,
                                    strokeAlign: 14,
                                    strokeCap: StrokeCap.round,
                                  ),
                                  CircularProgressIndicator(
                                    value: minDigital * (1 / 60),
                                    color: Color(0xffE6E6FA),
                                    strokeWidth: 12,
                                    strokeAlign: 23,
                                    strokeCap: StrokeCap.round,
                                  ),
                                  CircularProgressIndicator(
                                    value: secDigital * (1 / 60),
                                    color: Color(0xffFFC0CB),
                                    strokeWidth: 10,
                                    strokeAlign: 32,
                                    strokeCap: StrokeCap.round,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.purple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NeumorphicText(
                        "Start Digital Watch",
                        style: NeumorphicStyle(color: Colors.white),
                        textStyle: NeumorphicTextStyle(fontSize: 30),
                      ),
                      NeumorphicSwitch(
                        value: onOff,
                        style: NeumorphicSwitchStyle(
                            thumbShape: NeumorphicShape.concave,
                            activeTrackColor: Colors.purple,
                            trackBorder: (onOff == true)
                                ? NeumorphicBorder(
                                    color: Colors.white, width: 2)
                                : NeumorphicBorder(
                                    color: Colors.purple, width: 2)),
                        onChanged: (value) {
                          setState(() {
                            onOff = !onOff;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
