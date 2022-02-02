import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseService {
  //uid shows null??
  //has garbage value
  final String? uid;

  DatabaseService(this.uid);

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');

  Future addUserData({fullName, email}) async {
    return await userCollection.doc(uid).set({
      "full_name": fullName,
      "email": email,
      "date_created": "1900-02-02 14:07:14.694137",
    }, SetOptions(merge: true));
  }

  Future updateUserData(String weight) async {
    return await userCollection
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({
      "weight": weight,
      "date_created": DateTime.now().toString(),
    });
  }

  Future deleteUserData(index) async {
    await userCollection.doc(uid).delete();
  }

  Future deleteAccountData(index) async {
    List data = [];
    var docRef = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('accounts')
        .get();
    for (var element in docRef.docs) {
      print(element.id);
      data.add(element.id);
    }
    await userCollection
        .doc(uid)
        .collection('accounts')
        .doc(data[index])
        .delete()
        .then((value) {
      Fluttertoast.showToast(msg: "Deleted Successfully");
    });
  }

  Future addAccountData({
    String? fullName,
    String? email,
    String? weight,
    String? dateCreated,
  }) async {
    final response = await userCollection.doc(uid).update({
      "full_name": fullName,
      "email": email,
      "weight": weight,
      "date_created": dateCreated,

    }).then((value) {
      Fluttertoast.showToast(msg: "Successfully Added");
    });
    print(response);
    return response;
  }

  //uid causing issue


}
