import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/database/function/dbfunctions.dart';
import 'package:beatboxnew/database/model/model.dart';
import 'package:beatboxnew/presentaion/home_screen/widgets/homeiconswidgets.dart';
import 'package:beatboxnew/presentaion/home_screen/widgets/homesongs.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

// ignore: must_be_immutable
class MyHome extends StatelessWidget {
  MyHome({super.key});

  Box<Songs> songBox = getSongBox();
  Box<List> playlistBox = getPlaylistBox();
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kheight20,
        const Expanded(
          flex: 1,
          child: Homeiconswidgets(),
        ),
        kheight20,
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'All Songs',
            style: kscafoldtextstyle,
          ),
        ]),
        kheight10,
        Expanded(
          flex: 2,
          child: ValueListenableBuilder(
            valueListenable: songBox.listenable(),
            builder: (BuildContext context, boxSongs, _) {
              List<Songs> songList = songBox.values.toList().cast<Songs>();
              return (songList.isEmpty)
                  ? const Text("No Songs Found")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Homesongs(
                          index: index,
                          audioPlayer: audioPlayer,
                          songList: songList,
                        );
                      },
                      itemCount: songBox.length,
                    );
            },
          ),
        )
      ],
    );
  }
}
