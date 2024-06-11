// audio_controls.dart

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPlayerPage extends StatefulWidget {
  String filename = "assets/sound/A_gondtalan_tengerpart_hangositott.mp3";
  AudioPlayerPage(String s){
    filename = s;
  }

  @override
  _AudioControlsState createState() => _AudioControlsState(filename);
}

class _AudioControlsState extends State<AudioPlayerPage> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  double _sliderValue = 0.0;
  bool _isDraggingSlider = false;
  // Helyettesítsd az alábbi változót az aktuális pozícióval
  late Duration _currentPosition = Duration.zero;
  late Duration maxPosition = Duration.zero;
  bool isOpened = false;
  double _maxDuration = 100.0;
  String fajlnev = "assets/sound/A_gondtalan_tengerpart_hangositott.mp3";

  _AudioControlsState(String filename){
    fajlnev = filename;
  } // Kezdeti érték, amit később frissítünk

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer.open(Audio(fajlnev),
      autoStart: false, // Nem indul el automatikusan
      showNotification: true,
    );
    //_assetsAudioPlayer.pause();

    //_assetsAudioPlayer = AssetsAudioPlayer();
    _assetsAudioPlayer.currentPosition.listen((duration) {
      //_currentPosition = 0;
      setState(() {
        if (!_isDraggingSlider) {
          _currentPosition = duration;
          _sliderValue = _currentPosition.inSeconds.toDouble();
        }
      });
    });

    _assetsAudioPlayer.current.listen((playingAudio) {
      setState(() {
        if (playingAudio != null) {
          _maxDuration = playingAudio.audio.duration.inSeconds.toDouble();
          maxPosition = Duration(hours: (_maxDuration/60).toInt(), seconds: (_maxDuration%60).toInt());
        } else {
          _maxDuration = 100.0; // Alapértelmezett érték, ha nincs lejátszás
        }
      });
    });



  }

  void _playAudio() {
    print("play");
    /*if (isOpened == false){
      _assetsAudioPlayer.open(Audio("assets/sound/A_gondtalan_tengerpart_hangositott.mp3"));
      isOpened = true;
    }*/
    _assetsAudioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Idő: ${_currentPosition.toString()} / ${maxPosition.toString()} ',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Slider(
            value: _sliderValue,
            min: 0.0,
            max: _maxDuration,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
                _isDraggingSlider = true;
              });
            },
            onChangeEnd: (value) {
              _assetsAudioPlayer.seek(Duration(seconds: value.toInt()));
              setState(() {
                _isDraggingSlider = false;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  _playAudio();
                },
              ),
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () {
                  _assetsAudioPlayer.pause();
                },
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () {
                  _assetsAudioPlayer.stop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}