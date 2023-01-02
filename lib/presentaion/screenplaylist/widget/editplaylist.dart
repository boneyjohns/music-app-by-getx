import 'package:beatboxnew/database/function/dbfunctions.dart';
import 'package:beatboxnew/database/model/model.dart';
import 'package:beatboxnew/presentaion/searchscreen/search.dart';
import 'package:flutter/material.dart';

showEditingPlaylistDialoge({
  required BuildContext context,
  required String playlistName,
  required List<Songs> playlistSongs,
}) {
  final TextEditingController textController =
      TextEditingController(text: playlistName);
  return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        final formKey = GlobalKey<FormState>();
        return Form(
          key: formKey,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: const Color.fromARGB(255, 119, 182, 145),
            title: const Text(
              'Edit playlist',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: SearchField(
              textController: textController,
              hintText: 'Playlist Name',
              icon: Icons.playlist_add,
              validator: (value) {
                final keys = getPlaylistBox().keys.toList();
                if (value == null || value.isEmpty) {
                  return 'Field is empty';
                }
                if (keys.contains(value)) {
                  return '$value already exist in playlist';
                }
                return null;
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              // TextButton(
              //   onPressed: () async {
              //     if (formKey.currentState!.validate()) {
              //       final playlistBox = getPlaylistBox();
              //       setState(() {
              //         newPlaylistName = textController.text.trim();
              //       });
              //       await playlistBox.put(newPlaylistName, playlistSongs);
              //       playlistBox.delete(playlistName);
              //       Navigator.pop(context);
              //     }
              //   },
              //   child: const Text(
              //     'Confirm',
              //     style: TextStyle(fontSize: 15),
              //   ),
              // ),
            ],
          ),
        );
      });
}
