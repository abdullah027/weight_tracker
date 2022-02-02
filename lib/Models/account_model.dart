import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  final String? id;
  final String? fullName;
  final String? email;
  final String? weight;
  final String? dateCreated;

  Account({this.weight,this.id, this.email, this.fullName,this.dateCreated});

  factory Account.fromDocument(Map<String, dynamic> doc) {
    return Account(
      id: doc['id'],
      email: doc['email'],
      fullName: doc['full_name'],
      weight: doc['weight'],
      dateCreated: doc['date_created'],
    );
  }
}


