import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/tile/pack_tile.dart';
import 'package:flutter_app_teach2/tile/pack_tile_vertical.dart';

Widget packListVertical(
    Stream<QuerySnapshot>? packStream, String title, String currentPackId) {
  return StreamBuilder(
    stream: packStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data == null) {
        return const Center(child: Text('No data available.'));
      } else {
        var querySnapshot =
            snapshot.data as QuerySnapshot<Map<String, dynamic>>;
        var packList = querySnapshot.docs;

        List<PackTileVertical> userPackTiles = [];

        for (var packDoc in packList) {
          var pack = packDoc.data();
          if (packDoc.id != currentPackId &&
              pack.containsKey("title") &&
              pack['title'] == title &&
              pack.containsKey("lessonName") &&
              pack.containsKey("img")) {
            userPackTiles.add(PackTileVertical(
              packId: packDoc.id,
              img: pack["img"] as String,
              title: pack["title"] as String,
              lessonName: pack["lessonName"] as String,
            ));
          }
        }
        return Column(
          children: List.generate(userPackTiles.length, (index) {
            return userPackTiles[index];
          }),
        );
      }
    },
  );
}
