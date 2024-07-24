import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/models/title/model.dart';
import 'package:flutter_app_teach2/screens/auth/background.dart';
import 'package:flutter_app_teach2/screens/title/title_bloc/title_bloc.dart';
import 'package:flutter_app_teach2/services/auth/user_service.dart';
import 'package:flutter_app_teach2/widget/my_text_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTitleScreen extends StatefulWidget {
  const CreateTitleScreen({super.key});

  @override
  State<CreateTitleScreen> createState() => _CreateTitleScreenState();
}

class _CreateTitleScreenState extends State<CreateTitleScreen> {
  final nameTitleController = TextEditingController();
  final descriptionTitleController = TextEditingController();
  String userId = "###########";

  UserService userService = UserService();

  @override
  void initState() {
    //Get Id user
    userService.initUserId().then((value) {
      setState(() {
        userId = userService.getCurrentUserId;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text(
          "New Title",
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          const Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                    controller: nameTitleController,
                    hintText: 'Title',
                    obscureText: false,
                    keyboardType: TextInputType.text),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                    controller: descriptionTitleController,
                    hintText: 'Description',
                    obscureText: false,
                    keyboardType: TextInputType.text),
              ),
              const SizedBox(height: 8),
              SizedBox(
                child: TextButton(
                  onPressed: () async {
                    title Title = title.empty;
                    Title.titleName = nameTitleController.text;
                    Title.titleDescription = descriptionTitleController.text;
                    Title.titleCreateBy = userId;
                    Title.titleCreateAt = DateTime.now();
                    context.read<TitleBloc>().add(CreateTitle(Title));
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                      elevation: 3.0,
                      backgroundColor: Color.fromARGB(255, 83, 146, 198),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text(
                      'Create',
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
