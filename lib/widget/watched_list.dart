import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/services/watched/watch_service.dart';

import '../tile/pack_tile.dart';

Widget watchedPackList(String userId, WatchService watchService) {
  return StreamBuilder<List<Map<String, dynamic>>>(
    stream: watchService.getPackWatched(userId),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Lỗi: ${snapshot.error}'));
      } else if (!snapshot.hasData ||
          snapshot.data == null ||
          snapshot.data!.isEmpty) {
        return const Center(child: Text('Không có dữ liệu.'));
      } else {
        var topPacks = snapshot.data!;
        List<PackTile> topList = topPacks.map((pack) {
          return PackTile(
            packId: pack['packId'],
            img: pack['img'],
            title: pack['title'],
            lessonName: pack['lessonName'],
          );
        }).toList();
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: topList.length,
          itemBuilder: (context, index) {
            return topList[index];
          },
        );
      }
    },
  );
}
