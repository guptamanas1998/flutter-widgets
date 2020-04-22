import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GunshotsApp(),
  ));
}

class GunshotsApp extends StatefulWidget {
  @override
  _GunshotsAppState createState() => _GunshotsAppState();
}

class _GunshotsAppState extends State<GunshotsApp> {
  List<Widget> _gunshots;
  static AudioCache _audioCache;

  @override
  void initState() {
    super.initState();
    this._gunshots = <Widget>[Container(color: Colors.white)];
    _audioCache = new AudioCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: _shotsFired,
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.clip,
          children: this._gunshots
        ),
      ),
    );
  }

  _shotsFired(TapDownDetails tapDetails) {
    _audioCache.play("sounds/gunshot.mp3");
    setState(() {
      this._gunshots.add(Positioned(
          left: tapDetails.localPosition.dx - 25.0,
          top: tapDetails.localPosition.dy - 25.0,
          child: Image.asset("assets/images/gunshot.png", height: 50.0, width: 50.0, fit: BoxFit.cover)));
    });
  }
}
