import 'package:beatboxnew/database/function/dbfunctions.dart';
import 'package:beatboxnew/database/model/model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SearchController extends GetxController {
  Box<Songs> songBox = getSongBox();
  List<Songs>? dbSongs;
  List<Songs>? searchedSongs;

  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  void onInit() {
    // Here you can fetch you product from server
    super.onInit();
    dbSongs = songBox.values.toList().cast<Songs>();
    searchedSongs = List<Songs>.from(dbSongs!).toList().cast<Songs>();
  }

  searchSongfomDb(String searchSong) {
    searchedSongs = dbSongs!
        .where((song) =>
            song.songname.toLowerCase().contains(searchSong.toLowerCase()))
        .toList();
    update();
  }
}
