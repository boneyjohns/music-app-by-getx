import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beatboxnew/controller/favouritecontroller.dart';
import 'package:beatboxnew/core/addtoplaylist.dart';
import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/core/favorate.dart';
import 'package:beatboxnew/database/model/model.dart';
import 'package:beatboxnew/presentaion/nowplaying/widgets/myprogressbar.dart';
import 'package:beatboxnew/presentaion/nowplaying/widgets/nowplayingbutton.dart';
import 'package:beatboxnew/presentaion/nowplaying/widgets/songnameandartist.dart';
import 'package:beatboxnew/presentaion/searchscreen/seachbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Nowplaying extends StatelessWidget {
  Nowplaying({
    required this.songaudio,
    required this.index,
    required this.audioPlayer,
    required this.id,
    super.key,
  });
  final List<Audio> songaudio;
  final int index;
  final String id;
  final AssetsAudioPlayer audioPlayer;
  var isLoop = true;
  bool isShuffle = true;

  void shuffleButtonPressed() {
    //   setState(() {
    audioPlayer.toggleShuffle();
    isShuffle = !isShuffle;
    //   });
  }

  void repeatButtonPressed() {
    if (isLoop == true) {
      audioPlayer.setLoopMode(LoopMode.single);
    } else {
      audioPlayer.setLoopMode(LoopMode.playlist);
    }
    // setState(() {
    //   isLoop = !isLoop;
    // });
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) {
      return element.path == fromPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderCurrent(builder: (context, playing) {
      final myAudio = find(songaudio, playing.audio.assetAudioPath);
      final Size = MediaQuery.of(context).size;
      return GetBuilder<Favor>(
          init: Favor(),
          builder: (favorCtrl) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.arrow_back), onPressed: () => Get.back()),
                backgroundColor: kblack,
                shape: kappbarshape,
                title: Text('BEAT BOX', style: kmaintextstyle),
                centerTitle: true,
                toolbarHeight: Size.height * 0.08,
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to(Searchbar());
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              body: Column(children: [
                SizedBox(height: Size.height * 0.01),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Mynowplayingbutton(
                        onPressed: () {
                          final song = Songs(
                            id: myAudio.metas.id!,
                            songname: myAudio.metas.title!,
                            songartist: myAudio.metas.artist!,
                            path: myAudio.path,
                          );

                          showPlaylistModalSheet(
                            context: context,
                            song: song,
                          );
                        },
                        nowplayingbutton: Icons.add,
                      ),
                      SizedBox(
                        width: Size.width * 0.2,
                      ),
                      Mynowplayingbutton(
                        nowplayingbutton: favorCtrl.isThisFavourite(
                          id: myAudio.metas.id!,
                        ),
                        onPressed: () {
                          Favourites.addSongToFavourites(
                            context: context,
                            id: myAudio.metas.id!,
                          );
                        },
                      ),
                    ]),
                SizedBox(height: Size.height * 0.02),
                SizedBox(
                  width: Size.width * 0.9,
                  height: Size.height * 0.4,
                  child: QueryArtworkWidget(
                    artworkBorder: BorderRadius.circular(50),
                    id: int.parse(myAudio.metas.id!),
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Image.asset(
                      'lib/asset/frog.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(
                  height: Size.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Name(audioPlayer: audioPlayer),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10, left: 40, right: 40, top: 10),
                  child: audioPlayer.builderRealtimePlayingInfos(
                      builder: (context, info) {
                    final duration = info.current!.audio.duration;
                    final position = info.currentPosition;
                    {
                      return myprogressbar(position, duration);
                    }
                  }),
                ),
                SizedBox(height: Size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Mynowplayingbutton(
                      nowplayingbutton:
                          (isLoop == true) ? Icons.repeat : Icons.repeat_one,
                      onPressed: () {
                        repeatButtonPressed();
                      },
                    ),
                    Mynowplayingbutton(
                        nowplayingbutton: Icons.skip_previous,
                        onPressed: () async {
                          await audioPlayer.previous();
                        }),
                    PlayerBuilder.isPlaying(
                        player: audioPlayer,
                        builder: (context, isPlaying) {
                          return Mynowplayingbutton(
                            nowplayingbutton: (isPlaying == true)
                                ? Icons.pause
                                : Icons.play_arrow,
                            onPressed: () async {
                              await audioPlayer.playOrPause();
                            },
                          );
                        }),
                    Mynowplayingbutton(
                        nowplayingbutton: Icons.skip_next,
                        onPressed: () async {
                          await audioPlayer.next();
                        }),
                    Mynowplayingbutton(
                      nowplayingbutton: (isShuffle == true)
                          ? Icons.shuffle
                          : Icons.arrow_forward,
                      onPressed: () {
                        //               shuffleButtonPressed();
                      },
                    ),
                  ],
                )
              ]),
            );
          });
    });
  }
}
