import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/Providers/user_accounts_provider.dart';
import 'package:weight_tracker/Services/firebase_authentication.dart';
import 'package:weight_tracker/Utilis/navigation.dart';
import 'package:weight_tracker/widgets/custom_blue_button.dart';
import 'package:weight_tracker/widgets/custom_text.dart';
import 'package:weight_tracker/widgets/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController weightController = TextEditingController();
  List users = [];



  @override
  void initState() {
    AuthenticationService(FirebaseAuth.instance).getAccounts(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var accountsProvider = Provider.of<AccountProvider>(context,listen: true);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: CustomText(
            title: "Home Screen",
            textColor: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          actions: [
            IconButton(
              onPressed: () {
                AuthenticationService(FirebaseAuth.instance).signOut(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.black,
                          Colors.grey,
                        ]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(
                          inputType: TextInputType.number,
                          controller: weightController,
                          hintText: 'Weight in Kg',
                          fillColor: Colors.white,
                          enabled: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomBlackButton(
                          onPressed: () {
                            AuthenticationService(FirebaseAuth.instance)
                                .updateUser(weightController.text, context).then((value) {
                                  setState(() {
                                    AuthenticationService(FirebaseAuth.instance).getAccounts(context);
                                  });
                            });
                          },
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          text: "Submit",
                          textColor: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  height: 0,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: accountsProvider.accounts.length,
                      itemBuilder: (BuildContext context, index) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide.none,
                              ),
                              tileColor: Colors.white,
                              title: CustomText(
                                title: 'Weight: '+ accountsProvider.accounts[index].weight.toString(),
                                textColor: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                              subtitle: CustomText(
                                title: accountsProvider.accounts[index].fullName.toString(),
                                textColor: Colors.black,
                              ),
                              trailing: CustomText(
                                title: accountsProvider.accounts[index].dateCreated.toString(),
                                textColor: Colors.black,
                              ),
                            ),
                          ],
                        );
                      }),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                  onPressed: () {
                    AppNavigation.navigateToRemovingAll(context, HomeScreen());
                  },
                  icon: Icon(Icons.refresh)),
            ),
          ],
        ),
      ),
    );
  }
}
