import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../shared/local_parameters.dart';
import '../profile_page/profile_page.dart';
import '../start_page/main_page.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.key),
          title: const Text("Account"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ProfilePage();
            }));
          },
        ),
        const ListTile(
          leading: Icon(Icons.lock),
          title: Text("Privacy"),
        ),
        const ListTile(
          leading: Icon(Icons.message),
          title: Text("Chats"),
        ),
        const ListTile(
          leading: Icon(Icons.notifications),
          title: Text("Notifications"),
        ),
        const ListTile(
          leading: Icon(Icons.people),
          title: Text("Invite Friend"),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: () {
            logoutDialog(context);
          },
        ),
      ],
    );
  }
}

logoutDialog(BuildContext context) {
  AuthService authService = AuthService();
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: Parameters().navbar_IColor),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child:
        Text("Continue", style: TextStyle(color: Parameters().navbar_IColor)),
    onPressed: () {
      authService.signOut();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainPage()),
          (Route<dynamic> route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Logging out"),
    content: const Text("Are you sure?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
