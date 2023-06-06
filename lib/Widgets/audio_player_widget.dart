import 'package:http/http.dart'as http;

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  String url;
  AudioPlayerWidget(this.url);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration();
  Duration position = Duration();
  bool playing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleAudio();
  }

  handleAudio() async {
    if (playing) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          playing = false;
        });
      }
    } else {
      var res = await audioPlayer.play(widget.url);
      if (res == 1) {
        setState(() {
          playing = true;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((Duration dd) {
      if (mounted) {
        setState(() {
          duration = dd;
        });
      }
    });
    audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      if (mounted) {
        setState(() {
          position = dd;
        });
      }
    });
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 65,
            width: 65,
            fit: BoxFit.cover,
            image: AssetImage("assets/mp3.png"),
          ),
          SizedBox(
            height: 40,
          ),
          Slider.adaptive(
              max: duration.inSeconds.toDouble(), min: 0.0, value: position.inSeconds.toDouble(), onChanged: (double value) {
                setState(() {
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                });
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {audioPlayer.seek(Duration(seconds: position.inSeconds-15));},
                icon: Icon(Icons.fast_rewind_rounded),
                color: Colors.white,
                iconSize: 32,
              ),
              IconButton(
                onPressed: () {handleAudio();},
                icon:
                playing ==false?
                Icon(Icons.play_circle_fill):Icon(Icons.pause),
                color: Colors.white,
                iconSize: 56,
              ),
              IconButton(
                onPressed: () {audioPlayer.seek(Duration(seconds: position.inSeconds+15));},
                icon: Icon(Icons.fast_forward_rounded),
                color: Colors.white,
                iconSize: 32,
              ),
            ],
          )
        ],
      ),
    );
  }
}
