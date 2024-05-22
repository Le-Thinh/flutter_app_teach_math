import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget titleList(Stream<List<DocumentSnapshot>>? titleStream) {
  return StreamBuilder<List<DocumentSnapshot>>(
    stream: titleStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text("No titles found"));
      } else {
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            DocumentSnapshot titleSnapshot = snapshot.data![index];
            return ListTile(
              title: Text(titleSnapshot['titleName']),
            );
          },
        );
      }
    },
  );
}
