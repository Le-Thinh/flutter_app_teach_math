import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/models/account_info/info.dart';
import 'package:flutter_app_teach2/repositories/info_user_repository.dart';
import 'package:flutter_app_teach2/services/account/account_service.dart';
import 'package:flutter_app_teach2/services/auth/user_service.dart';
import 'package:flutter_app_teach2/widget/my_text_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditInfoScreen extends StatefulWidget {
  String userId;
  EditInfoScreen({required this.userId, super.key});

  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  String nameUser = "Guest";
  String? phoneUser = "";
  String? addressUser = "";
  String? emailUser = "...@gmail.com";
  DateTime? birthday;
  UserService userService = UserService();
  AccountService accountService = AccountService();
  InfoUserRepository infoUserRepository = InfoUserRepository();

  @override
  void initState() {
    userService.initUserName().then((value) {
      setState(() {
        nameUser = userService.getCurrentUserName;
        _nameController.text = nameUser;
      });
    });

    userService.initUserEmail().then((value) {
      setState(() {
        emailUser = userService.getCurrentUserEmail;
      });
    });

    accountService.getPhone(widget.userId).then((_) {
      setState(() {
        phoneUser = accountService.getCurrentUserPhone;
        _phoneController.text = phoneUser!;
      });
    });

    accountService.getAddress(widget.userId).then((_) {
      setState(() {
        addressUser = accountService.getCurrentUserAddress;
        _addressController.text = addressUser!;
      });
    });

    accountService.getBirthDay(widget.userId).then((_) {
      setState(() {
        birthday =
            accountService.getCurrentUserBirthday ?? DateTime(2000, 1, 1);
        _dateOfBirthController.text =
            birthday != null ? DateFormat('yyyy-MM-dd').format(birthday!) : '';
      });
    });

    super.initState();
  }

  void _saveChanges() async {
    try {
      Info info = Info.empty;

      // Parse the date string
      DateTime? dateOfBirth;
      if (_dateOfBirthController.text.isNotEmpty) {
        dateOfBirth =
            DateFormat('yyyy-MM-dd').parse(_dateOfBirthController.text);
      }

      info.userId = widget.userId;
      info.name = _nameController.text;
      info.phone = _phoneController.text;
      info.address = _addressController.text;
      info.dateOfBirth = dateOfBirth;
      info.email = emailUser!;
      info.lastUpdateAt = DateTime.now();

      await infoUserRepository.setDataInfoUser(info);
      await accountService.updateName(widget.userId, _nameController.text);
    } catch (e) {
      print("Error saving changes: $e");
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Edit Personal Information',
          style: GoogleFonts.acme(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                  controller: _nameController,
                  hintText: 'Name',
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle2?.color,
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Theme.of(context).textTheme.subtitle2?.color,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                  controller: _phoneController,
                  hintText: 'Phone',
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle2?.color,
                  ),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Theme.of(context).textTheme.subtitle2?.color,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                  controller: _addressController,
                  hintText: 'Address',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle2?.color,
                  ),
                  obscureText: false,
                  keyboardType: TextInputType.streetAddress,
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Theme.of(context).textTheme.subtitle2?.color,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                  controller: _dateOfBirthController,
                  hintText: 'BirthDay',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle2?.color,
                  ),
                  obscureText: false,
                  keyboardType: TextInputType.datetime,
                  prefixIcon: Icon(
                    Icons.cake,
                    color: Theme.of(context).textTheme.subtitle2?.color,
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _saveChanges();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Update",
                        style: GoogleFonts.actor(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
