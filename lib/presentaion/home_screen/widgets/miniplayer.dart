import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beatboxnew/controller/favouritecontroller.dart';
import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/core/recent.dart';
import 'package:beatboxnew/database/model/model.dart';
import 'package:beatboxnew/presentaion/nowplaying/nowplaying.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class Miniplayer extends StatelessWidget {
  Miniplayer({
    super.key,
    required this.songList,
    required this.index,
    required this.audioPlayer,
  });
  final List<Songs> songList;
  int index;
  final AssetsAudioPlayer audioPlayer;

  List<Audio> songAudio = [];

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) {
      return element.path == fromPath;
    });
  }

  void convertSongMode() {
    for (var song in songList) {
      songAudio.add(
        Audio.file(
          song.path,
          metas: Metas(
            id: song.id.toString(),
            title: song.songname,
            artist: song.songartist,
          ),
        ),
      );
    }
  }

  Future<void> openAudioPLayer() async {
    convertSongMode();

    await audioPlayer.open(
      Playlist(
        audios: songAudio,
        startIndex: index,
      ),
      autoStart: true,
      showNotification: true,
      loopMode: LoopMode.playlist,
      playInBackground: PlayInBackground.enabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      openAudioPLayer();
    });

    return audioPlayer.builderCurrent(builder: (context, playing) {
      final myAudio = find(songAudio, playing.audio.assetAudioPath);
      Recents.addSongsToRecents(songId: songList[index].id);
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: klightblue,
        ),
        height: 75,
        child: InkWell(
          onTap: () => Get.to(
            Nowplaying(
                audioPlayer: audioPlayer,
                id: myAudio.metas.id!,
                index: index,
                songaudio: songAudio),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: QueryArtworkWidget(
                  artworkBorder: BorderRadius.circular(10),
                  id: int.parse(songList[index].id),
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'lib/asset/mini.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child:
                        audioPlayer.builderCurrent(builder: (context, playing) {
                      return Text(
                        audioPlayer.getCurrentAudioTitle,
                        style: kmyliststyle,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      );
                    }),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PlayerBuilder.isPlaying(
                            player: audioPlayer,
                            builder: (context, isPlaying) {
                              return IconButton(
                                  onPressed: () {
                                    audioPlayer.previous();
                                  },
                                  icon: const Icon(
                                    Icons.skip_previous,
                                    color: kwhite,
                                  ));
                            }),
                        PlayerBuilder.isPlaying(
                            player: audioPlayer,
                            builder: (context, isPlaying) {
                              return IconButton(
                                onPressed: () {
                                  if (isPlaying == false) {
                                    audioPlayer.play();

                                    isPlaying = true;
                                  } else if (isPlaying == true) {
                                    audioPlayer.pause();

                                    isPlaying = false;
                                  }
                                },
                                icon: isPlaying
                                    ? const Icon(
                                        Icons.pause_rounded,
                                      )
                                    : const Icon(
                                        Icons.play_arrow_rounded,
                                      ),
                              );
                            }),
                        IconButton(
                            onPressed: () {
                              audioPlayer.next();
                            },
                            icon: const Icon(Icons.skip_next, color: kwhite)),
                      ],
                    ),
                  )
                ],
              ),
              GetBuilder<Favor>(
                  init: Favor(),
                  builder: (c) {
                    return IconButton(
                        onPressed: () {
                          c.addSongToFavourites(
                            context: context,
                            id: songList[index].id,
                          );
                        },
                        icon:Icon( c.isThisFavourite(
                          id: songList[index].id,
                    )));
                  }),
              kheight10
            ],
          ),
        ),
      );
    });
  }
}
