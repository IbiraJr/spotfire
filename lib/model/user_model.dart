import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.cpf,
    this.id,
  });
  String? id;
  String? name;
  String? cpf;

  UserModel.fromSnapshot(Map<String,dynamic> user) {
      id = user['id'];
      this.name = user['name'];
      this.cpf = user['cpf'];
    
  }
}
