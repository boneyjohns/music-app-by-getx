import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/database/function/dbfunctions.dart';
import 'package:beatboxnew/database/model/model.dart';
import 'package:beatboxnew/presentaion/screenplaylist/created_playlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

// ignore: must_be_immutable
class Screenplaylist extends StatelessWidget {
  Screenplaylist({
    super.key,
  });
  Box<Songs> songBox = getSongBox();
  Box<List> playlistBox = getPlaylistBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          backgroundColor: kblack,
          shape: kappbarshape,
          title: Text('Created Playlists', style: kmaintextstyle),
          centerTitle: true,
          toolbarHeight: 60,
        ),
        body: Column(children: [
          kheight20,
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: playlistBox.listenable(),
              builder: (context, value, child) {
                List keys = playlistBox.keys.toList();
                keys.removeWhere((key) => key == 'Favourites');
                keys.removeWhere((key) => key == 'Recent');
                keys.removeWhere((key) => key == 'Most Played');
                return (keys.isEmpty)
                    ? const Center(
                        child: Text('No Created Playlist..'),
                      )
                    : GridView.builder(
                        itemCount: keys.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 1.25,
                        ),
                        itemBuilder: (context, index) {
                          final String playlistName = keys[index];

                          final List<Songs> songList = playlistBox
                              .get(playlistName)!
                              .toList()
                              .cast<Songs>();

                          final int songListlength = songList.length;

                          return CreatedPlaylist(
                            playlistImage: 'lib/asset/playlist.jpg',
                            playlistName: playlistName,
                            playlistSongNum: '$songListlength Songs',
                          );
                        },
                      );
              },
            ),
          )
        ]));
  }
}
