import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beatboxnew/core/const.dart';
import 'package:flutter/cupertino.dart';

class Name extends StatelessWidget {
  const Name({
    Key? key,
    required this.audioPlayer,
  }) : super(key: key);

  final AssetsAudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
            child: Text(
          audioPlayer.getCurrentAudioTitle,
          style: kmyliststyle,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )),
        Center(
            child:
                Text(audioPlayer.getCurrentAudioArtist, style: kmyliststyle)),
      ],
    );
  }
}
