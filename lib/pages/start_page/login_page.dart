import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../helper/helper_function.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../shared/local_parameters.dart';
import '../snack_bar.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthService authService = AuthService();

  Future signIn() async {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
      if (_passwordController.text.length >= 8) {
        try {
          await authService
              .signInWithEmailandPassword(
                  _emailController.text, _passwordController.text)
              .then((value) async {
            if (value == true) {
              QuerySnapshot snapshot = await DatabaseService(
                      uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(_emailController.text);
              //saving the values to do shared preferences
              await HelperFunctions.saveUserLoggedInStatus(true);
              await HelperFunctions.saveUserEmailSF(_emailController.text);
              await HelperFunctions.saveUserNameSF(
                  snapshot.docs[0]['fullName']);
              await HelperFunctions.saveUserNumberSF(
                  snapshot.docs[0]['number']);
              await HelperFunctions.saveUserDurumSF(snapshot.docs[0]['durum']);
            } else {
              mySnackBar(context, value);
            }
          });
        } catch (e) {
          mySnackBar(context, "Invalid login or password.\nPlease try again.");
        }
      } else {
        mySnackBar(context, "Password length must be longer than 8");
      }
    } else {
      mySnackBar(context, "Please enter a valid email");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(238, 238, 238, 0)),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                  child: TextField(
                    cursorColor: Parameters().appbar_BColor,
                    controller: _emailController,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Parameters().appbar_BColor),
                        ),
                        labelText: 'E-mail',
                        labelStyle:
                            TextStyle(color: Parameters().appbar_BColor)),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              //password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: TextField(
                      cursorColor: Parameters().appbar_BColor,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Parameters().appbar_BColor),
                          ),
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: Parameters().appbar_BColor)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              //sign in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Parameters().navbar_IColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Parameters().appbar_BColor.withOpacity(0.6)),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(
                      '   Register now',
                      style: TextStyle(
                        color: Parameters().appbar_BColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
