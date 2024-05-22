import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_teach2/dialog/title_dialog.dart';
import 'package:flutter_app_teach2/screens/auth/background.dart';
import 'package:flutter_app_teach2/screens/createPack/create_pack_bloc/createpack_bloc.dart';
import 'package:flutter_app_teach2/services/auth/user_service.dart';
import 'package:flutter_app_teach2/services/title/title_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pack_repository/pack_repository.dart';

import '../../../widget/my_text_view.dart';

class CreatePackScreen extends StatefulWidget {
  const CreatePackScreen({super.key});

  @override
  State<CreatePackScreen> createState() => _CreatePackScreenState();
}

class _CreatePackScreenState extends State<CreatePackScreen> {
  final TextEditingController lessonNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  String imageUrl = "";
  String videoUrl = "";
  String userId = "###########";
  String selectedTitle = "Select Default";
  UserSevice userSevice = UserSevice();
  StreamController<List<DocumentSnapshot>> titleStreamController =
      StreamController<List<DocumentSnapshot>>();

  TitleService titleService = TitleService();

  Future<void> _loadTitles() async {
    List<DocumentSnapshot> titles = await titleService.getTitlesByCurrentUser();
    titleStreamController.add(titles);
  }

  @override
  void initState() {
    //load Title
    _loadTitles();

    userSevice.initUserId().then((value) {
      setState(() {
        userId = userSevice.getCurrentUserId;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: const Text('Create New Pack'),
      ),
      body: Stack(
        children: <Widget>[
          const Background(),
          BlocListener<CreatepackBloc, CreatepackState>(
            listener: (context, state) {
              if (state is CreatePackImageUploaded) {
                setState(() {
                  imageUrl = state.imageUrl;
                });
              } else if (state is CreatePackVideoUploaded) {
                setState(() {
                  videoUrl = state.videoUrl;
                });
              }
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MyTextField(
                      controller: lessonNameController,
                      hintText: 'Lesson Name',
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(CupertinoIcons.text_bubble),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        MyTextField(
                          controller: titleController,
                          hintText: 'Title',
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          prefixIcon: const Icon(Icons.title_rounded),
                          onTap: () {
                            showTitleDialog(context, titleStreamController)
                                .then((value) {
                              setState(() {
                                if (value != null) {
                                  selectedTitle = value;

                                  titleController.text = selectedTitle;
                                }
                              });
                            });
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.arrow_drop_down),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MyTextField(
                      controller: descriptionController,
                      hintText: 'Description',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon:
                          const Icon(CupertinoIcons.text_badge_checkmark),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text('Upload File Video'),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: IconButton(
                                    onPressed: () {
                                      context
                                          .read<CreatepackBloc>()
                                          .add(UploadVideoEvent((uploadedUrl) {
                                        setState(() {
                                          videoUrl = uploadedUrl;
                                          print("Video URL updated: $videoUrl");
                                        });
                                      }));
                                    },
                                    icon: const Icon(Icons.file_upload)),
                              ),
                              SizedBox(
                                width: 70,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    videoUrl == "" ? "" : "Success",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text('Upload File Image'),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: IconButton(
                                  onPressed: () async {
                                    context
                                        .read<CreatepackBloc>()
                                        .add(UploadImageEvent((uploadedUrl) {
                                      setState(() {
                                        imageUrl = uploadedUrl;
                                        print("Image URL updated: $imageUrl");
                                      });
                                    }));
                                  },
                                  icon: const Icon(Icons.image),
                                ),
                              ),
                              SizedBox(
                                width: 70,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    imageUrl == "" ? "" : 'Success',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextButton(
                          onPressed: () async {
                            Pack myPack = Pack.empty;
                            myPack.createAt = DateTime.now();
                            myPack.createBy = userId;
                            myPack.description = descriptionController.text;
                            myPack.lessonName = lessonNameController.text;
                            myPack.title = titleController.text;
                            myPack.video = videoUrl.toString();
                            myPack.img = imageUrl.toString();
                            if (videoUrl != "" && imageUrl != "") {
                              context
                                  .read<CreatepackBloc>()
                                  .add(CreatePackFinishEvent(myPack));

                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please upload both image and video.'),
                                ),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                              elevation: 3.0,
                              backgroundColor:
                                  const Color.fromARGB(255, 83, 146, 198),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Text(
                              'Create',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
