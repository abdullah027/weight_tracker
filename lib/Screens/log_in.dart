import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/Screens/sign_up.dart';
import 'package:weight_tracker/Services/firebase_authentication.dart';
import 'package:weight_tracker/Utilis/navigation.dart';
import 'package:weight_tracker/widgets/custom_blue_button.dart';
import 'package:weight_tracker/widgets/custom_text.dart';
import 'package:weight_tracker/widgets/custom_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          title: "Log In",
          textColor: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.email,
                      size: 14,
                      color: Colors.black,
                    ),
                    labelText: "Email",
                    enabled: true,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    inputType: TextInputType.visiblePassword,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 14,
                      color: Colors.black,
                    ),
                    labelText: "Password",
                    enabled: true,
                    obscureText: true,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: Column(
                children: [
                  CustomBlackButton(
                    onPressed: (){
                      AuthenticationService(FirebaseAuth.instance).signIn(emailController.text, passwordController.text, context);
                    },
                    text: "Log in",
                    textColor: Colors.white,
                    width: MediaQuery.of(context).size.width,

                  ),
                  const SizedBox(height: 20,),
                  CustomBlackButton(
                    onPressed: (){
                      AppNavigation.navigateTo(context, const SignUpScreen());
                    },
                    color: Colors.white,
                    text: "SignUp",
                    textColor: Colors.black,
                    width: MediaQuery.of(context).size.width,

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
