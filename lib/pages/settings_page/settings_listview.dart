import 'package:emotional_chat/pages/settings_page/settings_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../helper/helper_function.dart';
import '../../services/auth_service.dart';
import '../profile_page/profile_page.dart';

class SettingsListView extends StatefulWidget {
  const SettingsListView({super.key});

  @override
  State<SettingsListView> createState() => _SettingsListViewState();
}

class _SettingsListViewState extends State<SettingsListView> {
  final user = FirebaseAuth.instance.currentUser!;
  String userName = "";
  String email = "";
  String number = "";
  String durum = "";
  AuthService authService = AuthService();

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
    return Column(
      children: [
        //Profil bolumu
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: SizedBox(
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("lib/images/Kedy.jpg"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        userName,
                        style: const TextStyle(fontSize: 25),
                      ),
                      Text(durum, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ProfilePage();
            }));
          },
        ),
        //secenekler bolumu
        const Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: SizedBox(
            height: 330,
            child: SettingsList(),
          ),
        ),
      ],
    );
  }
}
