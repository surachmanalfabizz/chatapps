import 'package:chatapps/helper/theme.dart';
import 'package:chatapps/services/auth.dart';
import 'package:chatapps/views/chatroomscreen.dart';
import 'package:chatapps/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toogle;
  SignUp(this.toogle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthService authService = new AuthService();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passTextController = TextEditingController();

  signUp() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
    }

    await authService
        .signUpWithEmailAndPassword(
            emailTextController.text.trim(), passTextController.text)
        .then((value) {
      if (value != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ChatRoom(value.uid.toString())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 50,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: simpleTextStyle(),
                            controller: usernameTextController,
                            decoration: textInputDecoration("Username"),
                            validator: (val) => val.isEmpty || val.length < 3
                                ? "Enter Username 3+ characters"
                                : null,
                          ),
                          TextFormField(
                            style: simpleTextStyle(),
                            controller: emailTextController,
                            decoration: textInputDecoration("Email"),
                            validator: (val) =>
                                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Enter correct email",
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: passTextController,
                            validator: (val) {
                              return val.length > 6
                                  ? null
                                  : "Enter Password 6+ characters";
                            },
                            style: simpleTextStyle(),
                            decoration: textInputDecoration("password"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              "Forgot Password?",
                              style: simpleTextStyle(),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        signUp();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC)
                              ],
                            )),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Sign Up",
                          style: biggerTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Sign Up with Google",
                        style:
                            TextStyle(fontSize: 17, color: CustomTheme.textColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: simpleTextStyle(),
                        ),
                        GestureDetector(
                          onTap: (){
                            widget.toogle;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Sign In now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
          ),
    );
  }
}
