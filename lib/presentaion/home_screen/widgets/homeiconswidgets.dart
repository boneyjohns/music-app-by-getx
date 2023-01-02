import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/presentaion/home_screen/widgets/homeicons.dart';
import 'package:beatboxnew/presentaion/likedscreen/liked_screen.dart';
import 'package:beatboxnew/presentaion/screenplaylist/usercreated_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Homeiconswidgets extends StatelessWidget {
  const Homeiconswidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(
          width: 5,
        ),
        Homeicons(
          ontap: () {
            Get.to(
              Screenplaylist(),
            );
          },
          playlistname: 'Playlist',
          imagepath: 'lib/asset/new.1.jpg',
        ),
        const SizedBox(
          width: 5,
        ),
        Homeicons(
          ontap: () {
            Get.to(ScreenFavourites(
              playlistName: 'Recent',
            ));
          },
          playlistname: 'Recent Songs',
          imagepath: 'lib/asset/new.2.jpg',
        ),
        kheight5,
        Homeicons(
          ontap: () {
            Get.to(ScreenFavourites(playlistName: 'Favourites'));
          },
          playlistname: 'Liked Songs',
          imagepath: 'lib/asset/new.jpg',
        )
      ],
    );
  }
}
