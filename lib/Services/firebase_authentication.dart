import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_tracker/Models/user_model.dart';
import 'package:weight_tracker/Providers/user_accounts_provider.dart';
import 'package:weight_tracker/Providers/user_provider.dart';
import 'package:weight_tracker/Screens/home_screen.dart';
import 'package:weight_tracker/Screens/log_in.dart';
import 'package:weight_tracker/Utilis/navigation.dart';

import 'cloud_firestore.dart';

class AuthenticationService {
  Users? user;

  final FirebaseAuth firebaseAuth;

  AuthenticationService(this.firebaseAuth);

  //Stream<User?> get authStateChanges => firebaseAuth.idTokenChanges();

  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(id: user.uid, email: user.email) : null;
  }

  Future<void> signOut(context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.restUserProvider();
      await firebaseAuth.signOut().then((value) => {
        AppNavigation.navigateToRemovingAll(context, const LogInScreen()),
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<String> signUp({email, fullName,
      password,context} ) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //localStorage.setUser(user: user['USER']);
      await user!.reload();
      Users? data = _userFromFirebaseUser(user);
      userProvider.setUser(data);
      await DatabaseService(user.uid)
          .addUserData(email: email,fullName: fullName)
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            userProvider.setUser(Users.fromDocument(documentSnapshot));
          }
        });
        Fluttertoast.showToast(
            msg: "Signed up Successfully", gravity: ToastGravity.TOP);
        AppNavigation.navigateToRemovingAll(context, const HomeScreen());
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG);
    }
    throw "";
  }

  Future<String> signIn(String email, String password, context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print("Value: " + value.toString());
        User? user = value.user;
        Users? data = _userFromFirebaseUser(user);
        userProvider.setUser(data);
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            userProvider.setUser(Users.fromDocument(documentSnapshot));
            AppNavigation.navigateToRemovingAll(context, const HomeScreen());
          }
        });
        //userProvider.setUser(Users.fromDocument(doc));
        //AppNavigation.navigateReplacement(context, const HomeScreen());
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.TOP,
          toastLength: Toast.LENGTH_LONG);
    }
    throw "";
  }


  Future updateUser(weight, context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      await DatabaseService(FirebaseAuth.instance.currentUser?.uid)
          .updateUserData(weight)
          .then((value) => {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            userProvider.setUser(Users.fromDocument(documentSnapshot));
            //LocalStorage().setUser(user: documentSnapshot.data().toString());
          }
        }),
        Fluttertoast.showToast(msg: "Successfully Updated",gravity: ToastGravity.TOP)
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }
  Future<List<Object?>> getAccounts(context) async {
    List users = [];
    var accountProvider = Provider.of<AccountProvider>(context, listen: false);
    final CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('users');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(data);
    accountProvider.fetchAccountsList(data);


    return data;
  }


}
