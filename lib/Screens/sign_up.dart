import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weight_tracker/Services/firebase_authentication.dart';
import 'package:weight_tracker/Utilis/navigation.dart';
import 'package:weight_tracker/widgets/custom_blue_button.dart';
import 'package:weight_tracker/widgets/custom_text.dart';
import 'package:weight_tracker/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          title: "Sign Up",
          textColor: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        leading: IconButton(onPressed: (){
          AppNavigation.navigatorPop(context);
        },icon: const Icon(Icons.arrow_back_ios,color: Colors.red,)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
                    CustomTextField(
                      controller: fullNameController,
                      inputType: TextInputType.name,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.person,
                        size: 14,
                        color: Colors.black,
                      ),
                      labelText: "Full Name",
                      enabled: true,
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: confirmPasswordController,
                      inputType: TextInputType.visiblePassword,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.lock,
                        size: 14,
                        color: Colors.black,
                      ),
                      labelText: "Confirm Password",
                      enabled: true,
                      obscureText: true,
                    ),

                  ],
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: CustomBlackButton(
                onPressed: (){
                  if(passwordController.text == confirmPasswordController.text){
                    AuthenticationService(FirebaseAuth.instance).signUp(email: emailController.text,password: passwordController.text,context: context,fullName: fullNameController.text);
                  }
                  else{
                    Fluttertoast.showToast(msg: "Passwords does not match");
                  }

                },
                color: Colors.black,
                text: "SignUp",
                textColor: Colors.white,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
