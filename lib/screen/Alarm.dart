import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '../utils/alram.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
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

  String formatTime(int time) {
    if (time < 10) {
      return '0$time';
    } else {
      return '$time';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
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
          "Alram Clock",
          style: NeumorphicStyle(
            color: Colors.white,
          ),
          textStyle: NeumorphicTextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: Colors.purple,
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: 1,
                        intensity: 1,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Container(
                        width: 370,
                        height: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NeumorphicText(
                                  style: NeumorphicStyle(
                                    color: Colors.black,
                                    depth: 1,
                                    intensity: 1,
                                  ),
                                  "${formatTime(hourDigital)}",
                                  textStyle: NeumorphicTextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 56,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    top: 20,
                                  ),
                                  child: NeumorphicText(
                                    style: NeumorphicStyle(
                                      color: Colors.black,
                                      depth: 3,
                                      intensity: 1,
                                    ),
                                    "Hour",
                                    textStyle: NeumorphicTextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                NeumorphicText(
                                  style: NeumorphicStyle(
                                    color: Colors.black,
                                    depth: 1,
                                    intensity: 1,
                                  ),
                                  " : ${formatTime(minDigital)}",
                                  textStyle: NeumorphicTextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 56,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, top: 20),
                                  child: NeumorphicText(
                                    style: NeumorphicStyle(
                                      color: Colors.black,
                                      depth: 3,
                                      intensity: 1,
                                    ),
                                    "Min",
                                    textStyle: NeumorphicTextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              color: Colors.purple,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...Clock.allalarm.map(
                      (e) => Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Neumorphic(
                                    style: NeumorphicStyle(
                                      depth: 2,
                                      intensity: 1,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(22),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      height: 80,
                                      width: 370,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                NeumorphicText(
                                                  "${e['time']}",
                                                  textStyle:
                                                      NeumorphicTextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 30,
                                                  ),
                                                  style: NeumorphicStyle(
                                                    color: Colors.black,
                                                    depth: 3,
                                                    intensity: 1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8, left: 5),
                                                  child: NeumorphicText(
                                                    "AM",
                                                    textStyle:
                                                        NeumorphicTextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 17,
                                                    ),
                                                    style: NeumorphicStyle(
                                                      color: Colors.black,
                                                      depth: 3,
                                                      intensity: 1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      e['switch'] =
                                                          !e['switch'];
                                                    });
                                                  },
                                                  child: Switch(
                                                    activeColor: Colors.purple,
                                                    inactiveThumbColor:
                                                        Colors.white,
                                                    value: e['switch'],
                                                    onChanged: (val) {
                                                      setState(() {
                                                        e['switch'] = val;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
