import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/view/view.dart';
import '../../models/watched/watch.dart';
import '../../repositories/view_repository.dart';
import '../../services/auth/user_service.dart';
import '../home/view/users/home_bloc/home_bloc.dart';
import '../play_pack/view/pack_play_screen.dart';

class SearchOverlay extends StatefulWidget {
  final String userId;
  const SearchOverlay(this.userId, {super.key});
  @override
  _SearchOverlayState createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  String searchQuery = "";
  Stream<QuerySnapshot>? searchResultsStream;
  UserService userService = UserService();
  ViewRepository viewRepository = ViewRepository();

  @override
  void initState() {
    super.initState();
  }

  void updateSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchQuery = query;
        searchResultsStream = FirebaseFirestore.instance
            .collection('packes')
            .where('title', isGreaterThanOrEqualTo: query)
            .where('title', isLessThanOrEqualTo: '$query\uf8ff')
            .snapshots();
      });
    } else {
      setState(() {
        searchQuery = "";
        searchResultsStream = null;
      });
    }
  }

  void onPackTileTap(String pack) {
    Views view = Views.empty;
    view.viewAt = DateTime.now();
    view.viewerId = widget.userId;

    view.packId = pack;

    context.read<HomeBloc>().add(ViewVideoEvent(view, view.packId.toString()));

    Watch watch = Watch.empty;
    watch.userId = widget.userId;
    watch.packId = pack;
    watch.watchAt = DateTime.now();

    context.read<HomeBloc>().add(WatchedVideoEvent(watch));

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlayPackScreen(
                  packId: pack,
                  userId: widget.userId,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            onChanged: updateSearchResults,
            decoration: InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: searchResultsStream != null
              ? StreamBuilder<QuerySnapshot>(
                  stream: searchResultsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No results found.'));
                    } else {
                      var results = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          var pack =
                              results[index].data() as Map<String, dynamic>;
                          var packId = pack['packId'];
                          return ListTile(
                            title: Text(pack['title']),
                            subtitle: Text(pack['lessonName']),
                            leading: Image.network(pack['img']),
                            onTap: () => onPackTileTap(packId),
                          );
                        },
                      );
                    }
                  },
                )
              : Center(child: Text('Enter a search term to start searching.')),
        ),
      ],
    );
  }
}
