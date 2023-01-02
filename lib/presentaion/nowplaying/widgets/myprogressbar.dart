import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:beatboxnew/core/const.dart';

import 'package:flutter/material.dart';

ProgressBar myprogressbar(Duration position, Duration duration) {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  return ProgressBar(
    progress: position,
    total: duration,
    barCapShape: BarCapShape.round,
    barHeight: 5,
    baseBarColor: Color.fromARGB(255, 55, 126, 87),
    thumbColor: klightblue,
    progressBarColor: klightblue,
    thumbGlowColor: kwhite,
    thumbGlowRadius: 20,
    thumbRadius: 15,
    timeLabelTextStyle: TextStyle(color: kblack),
    timeLabelPadding: 10,
    onSeek: (duration) {
      audioPlayer.seek(duration);
    },
  );
}
