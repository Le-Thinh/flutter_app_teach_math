import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget titleList(Stream<QuerySnapshot<Map<String, dynamic>>>? titleStream) {
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: titleStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Center(child: Text("No titles found"));
      } else {
        var titleList = snapshot.data!.docs;

        return ListView.builder(
          itemCount: titleList.length,
          itemBuilder: (context, index) {
            DocumentSnapshot<Map<String, dynamic>> titleSnapshot =
                titleList[index];
            return ListTile(
              title: Text(titleSnapshot['titleName']),
              onTap: () {
                Navigator.of(context).pop(titleSnapshot['titleName']);
              },
            );
          },
        );
      }
    },
  );
}
