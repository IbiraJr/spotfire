import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotfire/cadastro_screen/cadastro_screen.dart';
import 'package:spotfire/home_screen/home_screen.dart';
import 'package:spotfire/model/user_model.dart';
import 'package:spotfire/util/instances.dart';

class LoginViewModel extends ChangeNotifier {
  String error = '';
  String? token;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  UserModel? userModel;
  Future<void> signIn(
      String email, String password, BuildContext context) async {
        
    UserCredential userCredential;
    try {
      userCredential = await Instances.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      QuerySnapshot querySnapshot = await users
          .where('id', isEqualTo: userCredential.user!.uid)
          .limit(1)
          .get();
      print('${querySnapshot.docs[0].data()}');
      userModel = UserModel.fromSnapshot(querySnapshot.docs[0].data());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = 'Email não encontrado!';
        await _onFail(context);
      } else if (e.code == 'wrong-password') {
        error = 'Senha inválida!';
        await _onFail(context);
      } else {
        error = 'Erro! - ${e.code}';
        await _onFail(context);
      }
      return;
    } catch (e) {
      error = 'Erro! - ${e.toString()}';
      await _onFail(context);
      return;
    }
    await _onSucess(context);
  }

  bool isLoggedIn() {
    return Instances.firebaseAuth.currentUser != null;
  }

  User? getCurrentUser() {
    return Instances.firebaseAuth.currentUser;
  }

  Future<String> getUserToken() async {
    return Instances.firebaseAuth.currentUser!
        .getIdTokenResult()
        .then((value) => value.token!);
  }

  void callSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => CadastroScreen(),
      ),
    );
  }

  Future<void> signUp(
    UserModel userModel,
    String email,
    String password,
    BuildContext context,
  ) async {
    UserCredential userCredential;
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      users
          .add({
            'id': userCredential.user!.uid,
            'name': userModel.name,
            'cpf': userModel.cpf,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }

  Future<void> showWaitSignInDialog(
      BuildContext context, String email, String password,
      {Widget? child}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return child ??
            const Center(
              child: CircularProgressIndicator(),
            );
      },
    );
    await signIn(email, password, context);
  }

  Future<VoidCallback?> _onSucess(BuildContext context) async {
    User? userFirebase = getCurrentUser();
    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<HomeScreen>(
          builder: (BuildContext context) => HomeScreen(),
        ),
        (Route<dynamic> route) => false);
    return null;
  }

  Future<VoidCallback?> _onFail(BuildContext context) async {
    Navigator.pop(context);
    return null;
  }
}
