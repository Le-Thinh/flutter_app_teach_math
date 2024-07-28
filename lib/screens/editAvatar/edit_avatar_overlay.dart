import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app_teach2/models/avatar/avatar.dart';
import 'package:flutter_app_teach2/repositories/avatar_repository.dart';
import 'package:flutter_app_teach2/services/account/account_service.dart';

class EditAvatarOverlay extends StatefulWidget {
  final String userId;
  final Function(String)
      onAvatarChanged; // Callback to update avatar immediately

  EditAvatarOverlay(
      {required this.userId, required this.onAvatarChanged, super.key});

  @override
  State<EditAvatarOverlay> createState() => _EditAvatarOverlayState();
}

class _EditAvatarOverlayState extends State<EditAvatarOverlay> {
  AccountService accountService = AccountService();
  AvatarRepository avatarRepository = AvatarRepository();
  String? avatarUrl = "";
  String? currentAvatar = "";

  @override
  void initState() {
    super.initState();
    accountService.getAvatarUrl(widget.userId).then((value) {
      setState(() {
        currentAvatar = accountService.getCurrentAvatarUrl ?? "";
      });
    });
  }

  Future<void> _selectAvatar() async {
    String? avatar = await accountService.uploadImage();
    if (avatar != null) {
      setState(() {
        avatarUrl = avatar;
        currentAvatar = avatar;
      });
      widget.onAvatarChanged(avatar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 24),
          child: SizedBox(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 36, 128, 190),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          child: Center(
            child: Stack(
              children: [
                ClipOval(
                  child: currentAvatar != null && currentAvatar!.isNotEmpty
                      ? Image.network(
                          currentAvatar!,
                          scale: 1,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/logonumberblocks.jpg',
                          scale: 1,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned.fill(
                  child: Center(
                    child: TextButton(
                      onPressed: _selectAvatar,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 219, 219, 221),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Text(
                          "Edit",
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24.0, top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Avatar avatarDoc = Avatar.empty;
                  avatarDoc.avatar = avatarUrl;
                  avatarDoc.updateAt = DateTime.now();
                  avatarDoc.userId = widget.userId;

                  avatarRepository.setDataAvatar(avatarDoc);

                  Navigator.of(context).pop();
                },
                child: Text(
                  "Save",
                  style: GoogleFonts.abel(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 36, 128, 190),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
