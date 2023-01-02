import 'package:beatboxnew/controller/favouritecontroller.dart';
import 'package:beatboxnew/core/addplaylist.dart';
import 'package:beatboxnew/core/addtoplaylist.dart';
import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/core/recent.dart';
import 'package:beatboxnew/database/function/dbfunctions.dart';
import 'package:beatboxnew/database/model/model.dart';
import 'package:beatboxnew/presentaion/home_screen/widgets/miniplayer.dart';
import 'package:beatboxnew/presentaion/searchscreen/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class Homesongs extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Homesongs({
    super.key,
    required this.index,
    required this.audioPlayer,
    required this.songList,
    this.onPressed,
  });

  final int index;
  final AssetsAudioPlayer audioPlayer;
  final List<Songs> songList;
  final void Function()? onPressed;
//   @override
//   State<Homesongs> createState() => _HomesongsState();
// }

// class _HomesongsState extends State<Homesongs> {
  Box<Songs> songBox = getSongBox();
  Box<List> playlistBox = getPlaylistBox();

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback(
    //     (timeStamp) => Favourites.isThisFavourite(id: songList[index].id));
    return InkWell(
      onTap: () {
        Recents.addSongsToRecents(songId: songList[index].id);
        showBottomSheet(
            backgroundColor: kblack.withOpacity(0),
            context: context,
            builder: (ctx) => Miniplayer(
                  index: index,
                  songList: songList,
                  audioPlayer: audioPlayer,
                ));
      },
      child: Card(
        shape: null,
        elevation: 0,
        color: kwhite.withOpacity(0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              topRight: Radius.circular(50),
            ),
            color: klightblue,
          ),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 50,
                width: 60,
                child: QueryArtworkWidget(
                  artworkBorder: BorderRadius.circular(10),
                  id: int.parse(songList[index].id),
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'lib/asset/playing image.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      songList[index].songname,
                      style: kmyliststyle,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    Text(songList[index].songartist,
                        style: kmyliststyle,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start),
                  ],
                ),
              ),
              GetBuilder<Favor>(
                  init: Favor(),
                  builder: (c) {
                    return IconButton(
                      onPressed: () {
                        Get.find<Favor>().addSongToFavourites(
                          context: context,
                          id: songList[index].id,
                        );

                        Get.find<Favor>().isThisFavourite(
                          id: songList[index].id,
                        );
                      },
                      icon: Icon(
                        c.isThisFavourite(id: songList[index].id),
                        color: kblack,
                        size: 25,
                      ),
                    );
                  }),
              IconButton(
                  onPressed: () {
                    showPlaylistModalSheet(
                        context: context, song: songList[index]);
                  },
                  icon: const Icon(Icons.playlist_add))
            ],
          ),
        ),
      ),
    );
  }
}
