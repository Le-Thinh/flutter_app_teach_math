import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/models/watched/watch.dart';
import 'package:flutter_app_teach2/repositories/view_repository.dart';
import 'package:flutter_app_teach2/screens/home/view/users/home_bloc/home_bloc.dart';
import 'package:flutter_app_teach2/screens/play_pack/play_pack_bloc/play_pack_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/play_pack/view/pack_play_screen.dart';
import '../services/auth/user_service.dart';
import 'package:flutter_app_teach2/models/view/view.dart';

class PackTileVertical extends StatefulWidget {
  final String packId;
  final String img;
  final String title;
  final String lessonName;

  const PackTileVertical({
    super.key,
    required this.packId,
    required this.img,
    required this.title,
    required this.lessonName,
  });

  @override
  State<PackTileVertical> createState() => _PackTileState();
}

class _PackTileState extends State<PackTileVertical> {
  String userId = "###########";
  UserService userService = new UserService();
  ViewRepository viewRepository = new ViewRepository();

  @override
  void initState() {
    userService.initUserId().then((value) {
      userId = userService.getCurrentUserId;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Views view = Views.empty;
        view.viewAt = DateTime.now();
        view.viewerId = userId;
        view.packId = widget.packId.toString();

        context
            .read<HomeBloc>()
            .add(ViewVideoEvent(view, view.packId.toString()));

        Watch watch = Watch.empty;
        watch.userId = userId;
        watch.packId = widget.packId;
        watch.watchAt = DateTime.now();

        context.read<HomeBloc>().add(WatchedVideoEvent(watch));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayPackScreen(
                      packId: widget.packId,
                      userId: userId,
                    )));
        print(widget.packId.toString());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        alignment: Alignment.topLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.img,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.lessonName,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
