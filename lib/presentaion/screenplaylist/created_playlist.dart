import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/core/snackbar.dart';
import 'package:beatboxnew/presentaion/screenplaylist/screenplaylist.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreatedPlaylist extends StatelessWidget {
  const CreatedPlaylist({
    Key? key,
    required this.playlistImage,
    required this.playlistName,
    required this.playlistSongNum,
  }) : super(key: key);
  final String playlistImage;
  final String playlistName;
  final String playlistSongNum;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          ScreenCreatedPlaylist(
            playlistName: playlistName,
          ),
        );
      },
      onLongPress: () {
        showPlaylistDeleteAlert(context: context, key: playlistName);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Image.asset(
              playlistImage,
              fit: BoxFit.cover,
              height: 155,
            ),
          ),
          Positioned(
            bottom: 32,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playlistName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: kplayliststyle,
                ),
                Text(playlistSongNum, style: kplayliststyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
