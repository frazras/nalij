import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Player with ChangeNotifier {
  AudioPlayer audioPlayer;
  //int index = store.state.playState['playingData']['index'];
  //final playlist = store.state.playState['playingData']['playList'];

  Player() {
    _init();
  }

  _init() {
    /*audioPlayer = store.state.playState['playingData']['controller'];
    if (audioPlayer == null) {
      store.state.playState['playingData']['controller'] = new AudioPlayer();
      audioPlayer = store.state.playState['playingData']['controller'];
      audioPlayer.setVolume(1);
    }*/
    audioPlayer = new AudioPlayer();
  }

  /*_playByIndex() async {
    String id = playlist[index]['id'].toString();
    //await getSongDetail(id);
    //await getSongUrl(id);
    //await getLyric(id);
    store.dispatch({'type': 'changePlay', 'playload': 'play'});
    store.dispatch({
      'type': 'setPlayingData',
      'playload': {'index': index}
    });
  }*/

  void onDurationChanged(Function callback) {
    audioPlayer.onDurationChanged.listen(callback);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => notifyListeners());
  }

  void onAudioPositionChanged(Function callback) {
    audioPlayer.onAudioPositionChanged.listen(callback);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => notifyListeners());
  }

  void onPlayerStateChanged(Function callback) {
    audioPlayer.onPlayerStateChanged.listen(callback);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => notifyListeners());

  }

  void audioPlayerHandler(AudioPlayerState value) => print('state => $value');

  void play(String url) async {
    if (Platform.isIOS) {
      audioPlayer.monitorNotificationStateChanges(audioPlayerHandler);
    }
    await audioPlayer.play(url);
    notifyListeners();
  }

  void pause() async {
    await audioPlayer.pause();
    notifyListeners();
  }

  void resume() async {
    await audioPlayer.resume();
    notifyListeners();
  }

  void stop() async {
    await audioPlayer.stop();
    notifyListeners();
  }

  void seek(d) async {
    audioPlayer.seek(Duration(seconds: d.toInt()));
    notifyListeners();
  }

  void destroy() async {
    audioPlayer = null;
    notifyListeners();
  }

  void next() async {
    /*
    if (index < playlist.length - 1) {
      index++;
    } else
      index = 0;
    try {
      _playByIndex();
    } catch (e) {
      next();
    }*/
  }

  void prev() async {
    /*if (index > 0) {
      index--;
    } else {
      index = playlist.length - 1;
    }
    try {
      _playByIndex();
    } catch (e) {
      prev();
    }*/
  }
}
