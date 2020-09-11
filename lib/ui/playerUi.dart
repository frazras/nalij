import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nalij/models/article.dart';
import 'package:nalij/services/player.dart';
import 'package:nalij/ui/sizeConfig.dart';

class PlayerUi extends StatefulWidget {
  final Player audioPlayer;
  final Article article;
  final double percentage;
  PlayerUi(
      {Key key,
      @required this.audioPlayer,
      @required this.article,
      this.percentage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PlayerUiState();
  }
}

class PlayerUiState extends State<PlayerUi> {
  bool semaphore = false;
  double _value = 0.0;

  Duration position = Duration(seconds: 0);
  Duration duration = Duration(seconds: 10);

  AudioPlayerState status = AudioPlayerState.STOPPED;

  @override
  void initState() {
    super.initState();
    initPlayer();
    print("Playing...");
    if (status != AudioPlayerState.PLAYING ) play();
    print(widget.article.narrationUrl);
  }

  void initPlayer() {
    widget.audioPlayer.onAudioPositionChanged((pos) {
      setState(() {
        position = pos;
      });
    });

    widget.audioPlayer.onDurationChanged((Duration d) {
      setState(() {
        duration = d;
      });
    });
    widget.audioPlayer.onPlayerStateChanged((pState) {
      if (pState == AudioPlayerState.STOPPED) {
        setState(() {
          status = AudioPlayerState.STOPPED;
        });
      }
    });
  }

  Future play() async {
    await widget.audioPlayer.play(widget.article.narrationUrl);
    setState(() {
      status = AudioPlayerState.PLAYING;
    });
  }

  Future pause() async {
    await widget.audioPlayer.pause();
    setState(() {
      status = AudioPlayerState.PAUSED;
    });
  }

  String fromDuration(Duration duration) {
    var durationText = duration.toString().split('.').first;
    if (durationText.split(":")[0] == "0") {
      return durationText.substring(2);
    }
    return durationText;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return widget.percentage == 1  ? fullPayer(context) : bottomPlayer(context);
  }

  Widget fullPayer(BuildContext context) {
    print(status);
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.keyboard_arrow_down)),
                  )
                ],
              ),
              Image.network(
                'https://picsum.photos/400/200?random=9',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: (SizeConfig.safeBlockHorizontal * 100),
                  //height: (SizeConfig.safeBlockVertical * 21),
                  child: AutoSizeText(
                    widget.article.title + widget.percentage.toString(),
                    style: TextStyle(
                      fontSize: (SizeConfig.safeBlockHorizontal * 5),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Stack(overflow: Overflow.visible, children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.blueAccent[700],
                    inactiveTrackColor: Colors.black45,
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 2.0,
                    thumbColor: Colors.blueAccent,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                    overlayColor: Colors.blueAccent.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 18.0),
                  ),
                  child: Slider(
                    value: semaphore ? _value : position.inSeconds.toDouble(),
                    max: duration.inSeconds.toDouble(),
                    min: 0,
                    onChanged: (double d) {
                      setState(() {
                        if (semaphore) {
                          _value = d;
                        } else {
                          widget.audioPlayer.seek(d);
                        }
                      });
                    },
                    onChangeStart: (double d) {
                      semaphore = true;
                      _value = d;
                    },
                    onChangeEnd: (double d) {
                      setState(() {
                        widget.audioPlayer.seek(d);
                      });
                      semaphore = false;
                    },
                  ),
                ),
                Positioned(
                  width: (SizeConfig.safeBlockHorizontal * 100),
                  top: 25,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(fromDuration(position)),
                        Text("-" + fromDuration(duration - position))
                      ],
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/images/prev.svg",
                        semanticsLabel: 'Rewind 10 seconds',
                        height: 42,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/images/rew10.svg",
                        semanticsLabel: 'Rewind 10 seconds',
                        height: 42,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: status == AudioPlayerState.PLAYING
                          ? InkWell(
                            onTap: () {
                              widget.audioPlayer.pause();
                              status = AudioPlayerState.PAUSED;
                            },
                            child: Icon(
                                Icons.pause_circle_outline,
                                size: 75,
                              ),
                          )
                          : InkWell(
                            onTap: () {
                              widget.audioPlayer.resume();
                              status = AudioPlayerState.PLAYING;
                            },
                            child: SvgPicture.asset(
                                "assets/images/play.svg",
                                semanticsLabel: 'Rewind 10 seconds',
                                height: 74,
                              ),
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/images/fwd10.svg",
                        semanticsLabel: 'Rewind 10 seconds',
                        height: 42,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/images/next.svg",
                        semanticsLabel: 'Rewind 10 seconds',
                        height: 42,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 24.0),
                  child: Text("Next Up: The Title of the Next Article in Line",
                      textAlign: TextAlign.right)),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomPlayer(context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, -6), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.all(8.0),
        child: Row(
            children: [
              Image.network(
                widget.article.image,
                width: 48,
                //'https://picsum.photos/48?image=19',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: (175),
                  //height: (SizeConfig.safeBlockVertical * 21),
                  child: AutoSizeText(widget.article.title,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  "assets/images/rew10.svg",
                  semanticsLabel: 'Rewind 10 seconds',
                  height: 32,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: status == AudioPlayerState.PLAYING
                    ? InkWell(
                  onTap: () {
                    widget.audioPlayer.pause();
                    status = AudioPlayerState.PAUSED;
                  },
                  child: Icon(
                    Icons.pause_circle_outline,
                    size: 32,
                  ),
                )
                    : InkWell(
                  onTap: () {
                    widget.audioPlayer.resume();
                    status = AudioPlayerState.PLAYING;
                  },
                  child: SvgPicture.asset(
                    "assets/images/play.svg",
                    semanticsLabel: 'Rewind 10 seconds',
                    height: 32,
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
