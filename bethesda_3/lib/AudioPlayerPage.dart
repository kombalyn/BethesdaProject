import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPlayerPage extends StatefulWidget {
  final String url;

  AudioPlayerPage({required this.url});

  @override
  _AudioControlsState createState() => _AudioControlsState(url);
}

class _AudioControlsState extends State<AudioPlayerPage> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  double _sliderValue = 0.0;
  bool _isDraggingSlider = false;
  late Duration _currentPosition = Duration.zero;
  late Duration maxPosition = Duration.zero;
  double _maxDuration = 100.0;
  String url;
  double _currentSliderValue = 0.0;
  bool isPlaying = false;

  _AudioControlsState(this.url);

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer.open(
      Audio.network(url),
      autoStart: false,
      showNotification: true,
    );

    _assetsAudioPlayer.currentPosition.listen((duration) {
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
          maxPosition = Duration(seconds: _maxDuration.toInt());
        } else {
          _maxDuration = 100.0;
        }
      });
    });

    _assetsAudioPlayer.isPlaying.listen((playing) {
      setState(() {
        isPlaying = playing;
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return [if (hours > 0) hours, twoDigits(minutes), twoDigits(seconds)].join(':');
  }

  void _togglePlayPause() {
    if (isPlaying) {
      _assetsAudioPlayer.pause();
    } else {
      _assetsAudioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100, // Grey background color
        borderRadius: BorderRadius.circular(30), // Rounded corners
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _togglePlayPause,
              ),
              Text(
                '${_formatDuration(_currentPosition)} / ${_formatDuration(maxPosition)}',
                style: TextStyle(fontSize: 14),
              ),
              Expanded(
                child: Slider(
                  value: _sliderValue,
                  min: 0.0,
                  max: _maxDuration,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                      _isDraggingSlider = true;
                      _currentSliderValue = value; // Update _currentSliderValue here
                    });
                  },
                  onChangeEnd: (value) {
                    _assetsAudioPlayer.seek(Duration(seconds: value.toInt()));
                    setState(() {
                      _isDraggingSlider = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
