import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'dart:async';

void main() => runApp(selmanApp());

class selmanApp extends StatelessWidget {
  const selmanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Baba meraba sanane",
      home: Iskele(),
    );
  }
}

class Iskele extends StatelessWidget {
  const Iskele({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ece uygulama"),
      ),
      body: selmanBody(),
    );
  }
}

class selmanBody extends StatefulWidget {
  const selmanBody({Key? key}) : super(key: key);

  @override
  _selmanBodyState createState() => _selmanBodyState();
}

class _selmanBodyState extends State<selmanBody> {
  String lorem =
  "                                             Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500'lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960'larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur."
      .toLowerCase()
      .replaceAll(",", "")
      .replaceAll(".", "");
  var shonwWidget;
  int step = 0;
  int score = 0;
  late int lastTypedAt;
  String username = "";

  updateLastTypeAd() {
    lastTypedAt = DateTime.now().millisecondsSinceEpoch;
  }

  onType(String value) {
    updateLastTypeAd();
    String trimedValue = lorem.trimLeft();
    setState(() {
      if (trimedValue.indexOf(value) != 0) {
        step = 2;
      } else {
        score = value.length;
      }
    });
    print(value);
  }

  onUserName(String value) {
    setState(() {
      username = value;
      print(username);
    });
  }

  step2at() {
    setState(() {
      score = 0;
      step = 0;
    });
  }

  baslat() {
    setState(() {
      updateLastTypeAd();
      step++;
    });
    var timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      int now = DateTime.now().millisecondsSinceEpoch;
      //Oyun bittiginde
      if (step != 1) timer.cancel();
      if (step == 1 && now - lastTypedAt > 4500) step++;

      setState(() {
        if (step != 2) ;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (step == 0) {
      shonwWidget = [
        TextWidget(
          text: "Oyuna basla canim",
          fontWeight: FontWeight.bold,
        ),

        TextField(
          autofocus: true,
          onChanged: onUserName,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              labelText: "Yaz bakam",
              labelStyle: TextStyle(
                fontSize: 25,
                color: Colors.blue,
              )),
        ),
        RaisedButton(
          onPressed: username.length==0 ? null:baslat,
          child: Text("Basla agam!"),
        )
      ];
    } else if (step == 1) {
      shonwWidget = [
        TextWidget(text: "$score"),
        Container(
          height: 20,
          child: Marquee(
            text: lorem,
            style: TextStyle(fontWeight: FontWeight.bold),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 75.0,
            startPadding: 0,
            accelerationDuration: Duration(seconds: 15),
            accelerationCurve: Curves.linear,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          autofocus: true,
          onChanged: onType,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              labelText: "Yaz bakam",
              labelStyle: TextStyle(
                fontSize: 25,
                color: Colors.blue,
              )),
        ),
      ];
    } else if (step == 2) {
      shonwWidget = [
        TextWidget(text: "Yandın oç ya $score aldin mubarek"),
        RaisedButton(
          onPressed: step2at,
          child: TextWidget(text: "Yeniden dene agam"),
        )
      ];
    }

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: shonwWidget,
          ),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  TextWidget({
    Key? key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 25,
    this.fontColor = Colors.red,
  }) : super(key: key);
  double fontSize;
  Color fontColor;
  String text;
  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
              color: fontColor,
              letterSpacing: 2,
              fontSize: fontSize,
              fontFamily: "Arial"),
          maxLines: 1,
          softWrap: false,
        )
      ],
    );
  }
}
