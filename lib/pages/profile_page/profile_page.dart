import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../helper/helper_function.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../shared/local_parameters.dart';
import '../bottomnav_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  String userName = "";
  String email = "";
  String number = "";
  String durum = "";
  AuthService authService = AuthService();
  final statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    await HelperFunctions.getUserDurumFromSF().then((val) {
      setState(() {
        durum = val!;
      });
    });
    await HelperFunctions.getUserNumberFromSF().then((val) {
      setState(() {
        number = val!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.of(context)
                  .pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => NavBar(finalindex: 1)),
                      (Route<dynamic> route) => false)
                  .whenComplete(gettingUserData);
            },
          ),
          title: const Text(
            "Profile",
          ),
          centerTitle: false,
          backgroundColor: Parameters().appbar_BColor,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("lib/images/Kedy.jpg"),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Change your profile photo",
                  style: TextStyle(color: Parameters().navbar_IColor)),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 250,
              child: ListView(children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(userName),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(
                    email,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(number),
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: TextField(
                    onSubmitted: (value) {
                      setState(() {
                        durum = value;
                      });
                      DatabaseService(
                              uid: FirebaseAuth.instance.currentUser!.uid)
                          .updateStatus(value);
                      HelperFunctions.saveUserDurumSF(value);
                    },
                    cursorColor: Parameters().appbar_BColor,
                    controller: statusController,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Parameters().appbar_BColor),
                        ),
                        labelText: durum,
                        labelStyle:
                            TextStyle(color: Parameters().appbar_BColor)),
                  ),
                ),
              ]),
            )
          ],
        ));
  }
}
