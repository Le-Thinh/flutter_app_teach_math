import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/screens/title/view/create_title_provider.dart';
import 'package:flutter_app_teach2/screens/title/view/title_list.dart';

showTitleDialog(BuildContext context,
    StreamController<List<DocumentSnapshot>> titleStreamController) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Select a Title"),
        content: titleList(titleStreamController.stream),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateTitleProvider()),
                  );
                },
                child: const Text("Add New Title"),
              ),
            ],
          )
        ],
      );
    },
  );
}
