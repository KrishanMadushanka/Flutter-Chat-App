import 'package:chat_app/helper/helperfunctions.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

import 'chatRoomsScreen.dart';

class SignUp extends StatefulWidget {
  final Function toggle;

  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signMeUp() {
    Map<String, String> userInfoMap = {
      "name": userNameTextEditingController.text,
      "email": emailTextEditingController.text
    };

    HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);
    HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);

    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text,context)
          .then((val) {
        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (val) {
                                  return val.isEmpty || val.length < 2
                                      ? "wrong username"
                                      : null;
                                },
                                controller: userNameTextEditingController,
                                decoration:
                                    textFieldInputDecoration("username"),
                                style: simpleTextStyle(),
                              ),
                              TextFormField(
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Enter correct email";
                                },
                                controller: emailTextEditingController,
                                decoration: textFieldInputDecoration("email"),
                                style: simpleTextStyle(),
                              ),
                              TextFormField(
                                  obscureText: true,
                                  validator: (val) {
                                    return val.length < 6
                                        ? "Enter Password 6+ characters"
                                        : null;
                                  },
                                  controller: passwordTextEditingController,
                                  decoration:
                                      textFieldInputDecoration("password"),
                                  style: simpleTextStyle()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              "Forgot Password?",
                              style: simpleTextStyle(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            signMeUp();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  const Color(0xff007EF4),
                                  const Color(0xff2A75BC)
                                ]),
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Sign Up",
                              style: mediumTextStyle(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0xffffffff),
                                const Color(0xffffffff)
                              ]),
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "Sign Up with Google",
                            style: mediumBlackTextStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an account? ",
                              style: mediumTextStyle(),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  "SignIn Now",
                                  style: mediumUnderlinedTextStyle(),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    )),
              ),
            ),
    );
    ;
  }
}
