import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? id;
  final String? fullName;
  final String? email;
  final String? weight;
  final String? dateCreated;

  Users({this.weight,this.id, this.email, this.fullName,this.dateCreated});

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
      id: (doc.data() as dynamic)['id'],
      email: (doc.data() as dynamic)['email'],
      fullName: (doc.data() as dynamic)['full_name'],
      weight: (doc.data() as dynamic)['weight'],
      dateCreated: (doc.data() as dynamic)['date_created'],
    );
  }
}


