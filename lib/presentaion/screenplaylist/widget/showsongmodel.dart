import 'package:beatboxnew/core/addplaylist.dart';
import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/database/function/dbfunctions.dart';
import 'package:beatboxnew/database/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

showSongModalSheet({
  required BuildContext context,
  required String playlistKey,
}) {
  return showModalBottomSheet(
    backgroundColor: kblack.withOpacity(0.0),
    context: context,
    builder: (ctx) {
      final songBox = getSongBox();
      return Container(
        decoration: BoxDecoration(
          color: knavbar,
          borderRadius: BorderRadius.circular(50),
        ),
        height: 500,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text('Add Songs', style: kscafoldtextstyle),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: songBox.listenable(),
                builder:
                    (BuildContext context, Box<Songs> boxSongs, Widget? child) {
                  return ListView.builder(
                    itemCount: boxSongs.values.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      final List<Songs> songsList = boxSongs.values.toList();
                      final Songs song = songsList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: ListTile(
                          onTap: () {
                            UserPlaylist.addSongToPlaylist(
                              context: context,
                              songId: song.id,
                              playlistName: playlistKey,
                            );

                            Get.back();
                          },
                          leading: QueryArtworkWidget(
                            id: int.parse(song.id),
                            type: ArtworkType.AUDIO,
                            artworkBorder: BorderRadius.circular(10),
                            nullArtworkWidget: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'lib/asset/playing image.jpg',
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          title: Text(
                            song.songname,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: kmyliststyle,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
