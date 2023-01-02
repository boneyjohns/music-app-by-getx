import 'package:beatboxnew/core/addplaylist.dart';
import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/core/creatingplaylist.dart';
import 'package:beatboxnew/database/function/dbfunctions.dart';
import 'package:beatboxnew/database/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

showPlaylistModalSheet({
  required BuildContext context,
  required Songs song,
}) {
  Box<List> playlistBox = getPlaylistBox();
  return showModalBottomSheet(
      backgroundColor: kblack.withOpacity(0.0),
      context: context,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: knavbar,
            borderRadius: BorderRadius.circular(130),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  showCreatingPlaylistDialoge(context: ctx);
                },
                icon: const Icon(
                  Icons.playlist_add,
                  color: kblack,
                ),
                label: const Text(
                  'Create Playlist',
                  style: TextStyle(
                    color: kblack,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: klightblue,
                  shape: const StadiumBorder(),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: playlistBox.listenable(),
                  builder: (context, boxSongList, _) {
                    final List<dynamic> keys = playlistBox.keys.toList();

                    keys.removeWhere((key) => key == 'Favourites');
                    keys.removeWhere((key) => key == 'Recent');
                    keys.removeWhere((key) => key == 'Most Played');

                    return Expanded(
                      child: (keys.isEmpty)
                          ? const Center(
                              child: Text("No Playlist Found"),
                            )
                          : ListView.builder(
                              itemCount: keys.length,
                              itemBuilder: (ctx, index) {
                                final String playlistKey = keys[index];

                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    onTap: () async {
                                      UserPlaylist.addSongToPlaylist(
                                          context: context,
                                          songId: song.id,
                                          playlistName: playlistKey);

                                      Get.back();
                                    },
                                    leading: const Text(
                                      '🎧',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    title: Text(playlistKey),
                                  ),
                                );
                              },
                            ),
                    );
                  })
            ],
          ),
        );
      });
}
