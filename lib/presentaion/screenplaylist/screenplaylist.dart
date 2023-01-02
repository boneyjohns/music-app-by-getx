import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/database/function/dbfunctions.dart';
import 'package:beatboxnew/database/model/model.dart';
import 'package:beatboxnew/presentaion/home_screen/widgets/homesongs.dart';
import 'package:beatboxnew/presentaion/screenplaylist/widget/editplaylist.dart';
import 'package:beatboxnew/presentaion/screenplaylist/widget/librarysongs.dart';
import 'package:beatboxnew/presentaion/screenplaylist/widget/showsongmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class ScreenCreatedPlaylist extends StatefulWidget {
  const ScreenCreatedPlaylist({super.key, required this.playlistName});
  final String playlistName;

  @override
  State<ScreenCreatedPlaylist> createState() => _ScreenCreatedPlaylistState();
}

class _ScreenCreatedPlaylistState extends State<ScreenCreatedPlaylist> {
  String? newPlaylistName;
  @override
  void initState() {
    newPlaylistName = widget.playlistName;
    super.initState();
  }

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  Box<Songs> songBox = getSongBox();
  Box<List> playlistBox = getPlaylistBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: kblack,
        shape: kappbarshape,
        title: Text(newPlaylistName!, style: kmaintextstyle),
        actions: [
          IconButton(
            onPressed: () {
              final List<Songs> playlistSongs =
                  playlistBox.get(newPlaylistName)!.toList().cast<Songs>();
              showEditingPlaylistDialoge(
                context: context,
                playlistName: newPlaylistName!,
                playlistSongs: playlistSongs,
              );
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: () {
              showSongModalSheet(
                context: context,
                playlistKey: newPlaylistName!,
              );
            },
            icon: const Icon(
              Icons.add,
              size: 27,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ValueListenableBuilder<Box<List<dynamic>>>(
          valueListenable: playlistBox.listenable(),
          builder: (context, boxSongList, _) {
            final List<Songs> songList =
                boxSongList.get(newPlaylistName)!.cast<Songs>();

            if (songList.isEmpty) {
              return const Center(
                child: Text('No Songs Found'),
              );
            }
            return ListView.builder(
              itemCount: songList.length,
              itemBuilder: (ctx, index) {
                return Librarysongs(
                    playlistname: widget.playlistName,
                    songList: songList,
                    index: index,
                    audioPlayer: audioPlayer);
              },
            );
          },
        ),
      ),
    );
  }
}
