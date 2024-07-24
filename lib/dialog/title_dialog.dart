import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/title/view/create_title_provider.dart';

Future<String?> showTitleDialog(BuildContext context,
    Stream<QuerySnapshot<Map<String, dynamic>>> titleStream) async {
  String? selectedTitle;

  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Select a Title"),
        content: SizedBox(
          width: double.maxFinite,
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: titleStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text("No titles found"));
              } else {
                var titleList = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: titleList.length,
                  itemBuilder: (context, index) {
                    var titleDoc = titleList[index];
                    return ListTile(
                      title: Text(titleDoc['titleName']),
                      onTap: () {
                        selectedTitle = titleDoc['titleName'];
                        Navigator.of(context).pop(selectedTitle);
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateTitleProvider()),
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
