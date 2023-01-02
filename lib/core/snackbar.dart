import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/database/function/dbfunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showPlaylistDeleteAlert({required BuildContext context, required String key}) {
  final playlistBox = getPlaylistBox();
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: knavbar,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: const Text(
            'Confirm Deletion',
          ),
          content: const Text(
            'Do you want to delete this Playlist',
            style: TextStyle(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await playlistBox.delete(key);
              
              Get.back();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      });
}
