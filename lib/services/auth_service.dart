import 'package:firebase_auth/firebase_auth.dart';
import '../helper/helper_function.dart';
import 'database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login
  Future signInWithEmailandPassword(String email, String password) async {
    try {
      User user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } catch (e) {
      return (e);
    }
  }

  //register
  Future registerUserWithEmailandPassword(String name, String number,
      String email, String password, String durum) async {
    try {
      User user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user!;

      if (user != null) {
        //update the user data
        await DatabaseService(uid: user.uid)
            .savingUserData(name, number, email, password, durum);
        return true;
      }
    } catch (e) {
      return (e);
    }
  }

  //signout
  Future signOut() async {
    await HelperFunctions.saveUserLoggedInStatus(false);
    await HelperFunctions.saveUserEmailSF("");
    await HelperFunctions.saveUserNameSF("");
    await HelperFunctions.saveUserNumberSF("");
    //await HelperFunctions.saveUserNumberSF("");
    FirebaseAuth.instance.signOut();
  }
}
