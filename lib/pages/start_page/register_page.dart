import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../helper/helper_function.dart';
import '../../services/auth_service.dart';
import '../../shared/local_parameters.dart';
import '../snack_bar.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  AuthService authService = AuthService();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
        .hasMatch(_numberController.text)) {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_emailController.text)) {
        if (_passwordController.text.length >= 8) {
          if (_passwordController.text.trim() ==
              _confirmPasswordController.text.trim()) {
            await authService
                .registerUserWithEmailandPassword(
                    _nameController.text,
                    _numberController.text,
                    _emailController.text,
                    _passwordController.text,
                    "Hello There...")
                .then((value) async {
              if (value == true) {
                //saving the shared preference state
                await HelperFunctions.saveUserLoggedInStatus(true);
                await HelperFunctions.saveUserNameSF(_nameController.text);
                await HelperFunctions.saveUserNumberSF(_numberController.text);
                await HelperFunctions.saveUserEmailSF(_emailController.text);
                await HelperFunctions.saveUserDurumSF("Hello There...");
              } else {
                mySnackBar(context, value);
              }
            });
          } else {
            mySnackBar(context, "Passwords don't match.");
          }
        } else {
          mySnackBar(context, "Password length must be longer than 8");
        }
      } else {
        mySnackBar(context, "Please enter a valid email");
      }
    } else {
      mySnackBar(context, "Please enter a valid number");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration:
            const BoxDecoration(color: Color.fromRGBO(238, 238, 238, 0)),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),

                  //name textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                      child: TextField(
                        cursorColor: Parameters().appbar_BColor,
                        controller: _nameController,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Parameters().appbar_BColor),
                            ),
                            labelText: 'Name',
                            labelStyle:
                                TextStyle(color: Parameters().appbar_BColor)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  //number textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                      child: TextField(
                        maxLength: 10,
                        cursorColor: Parameters().appbar_BColor,
                        controller: _numberController,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Parameters().appbar_BColor),
                            ),
                            labelText: 'Number',
                            labelStyle:
                                TextStyle(color: Parameters().appbar_BColor)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),

                  //email textfield
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
                  const SizedBox(height: 15),

                  //confirm password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                      child: TextField(
                        cursorColor: Parameters().appbar_BColor,
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Parameters().appbar_BColor),
                            ),
                            labelText: 'Confirm password',
                            labelStyle:
                                TextStyle(color: Parameters().appbar_BColor)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  //sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Parameters().navbar_IColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            'Sign In',
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
                        'I am a member!',
                        style: TextStyle(
                            color: Parameters().appbar_BColor.withOpacity(0.6)),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text(
                          '   Login now',
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
        ),
      ),
    );
  }
}
