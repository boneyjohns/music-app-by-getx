import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:beatboxnew/controller/searchcontroller.dart';
import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/presentaion/home_screen/widgets/homesongs.dart';
import 'package:beatboxnew/presentaion/searchscreen/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final TextEditingController searchController = TextEditingController();

AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

class Searchbar extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Searchbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        init: SearchController(),
        builder: (c) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kblack,
              shape: kappbarshape,
              title: Text('BEAT BOX', style: kmaintextstyle),
              centerTitle: true,
              toolbarHeight: 60,
            ),
            body: Column(
              children: [
                SearchField(
                  validator: (value) {
                    return null;
                  },
                  textController: searchController,
                  hintText: 'Search Songs Here',
                  icon: Icons.search,
                  onChanged: (value) {
                    c.searchSongfomDb(value);
                  },
                ),
                Expanded(
                  child: (c.searchedSongs!.isEmpty)
                      ? const Center(
                          child: Text('No Songs Found'),
                        )
                      : ListView.builder(
                          itemCount: c.searchedSongs!.length,
                          itemBuilder: (context, index) {
                            return Homesongs(
                              songList: c.searchedSongs!,
                              index: index,
                              audioPlayer: audioPlayer,
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        });
  }
}
