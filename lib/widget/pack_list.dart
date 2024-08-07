import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/tile/pack_tile.dart';

Widget packList(Stream<QuerySnapshot>? packStream) {
  return Container(
    height: 120,
    margin: const EdgeInsets.symmetric(horizontal: 24),
    child: StreamBuilder(
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

          List<PackTile> userPackTiles = [];

          for (var packDoc in packList) {
            var pack = packDoc.data();
            if (pack.containsKey("title") &&
                pack.containsKey("lessonName") &&
                pack.containsKey("img")) {
              userPackTiles.add(PackTile(
                packId: packDoc.id,
                img: pack["img"] as String,
                title: pack["title"] as String,
                lessonName: pack["lessonName"] as String,
              ));
            }
          }
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) {
                return userPackTiles[index];
              });
        }
      },
    ),
  );
}
