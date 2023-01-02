import 'package:beatboxnew/database/model/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Box<List> getPlaylistBox() {
  return Hive.box<List>('Playlist');
}

Box<Songs> getSongBox() {
  return Hive.box<Songs>('Songs');
}
