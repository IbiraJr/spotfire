import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class HomeViewModel extends ChangeNotifier {
  CollectionReference iotsCollection =
      FirebaseFirestore.instance.collection('iots');
  Map<String, dynamic>? lastGas = {};
  List<Map<String, dynamic>> iotsList = [];
  Future<void> getIotGas() async {
    QuerySnapshot iots = await iotsCollection.get();
    QuerySnapshot? gas;
    if (iots.docs.isEmpty) {
      return;
    }
    for (int i = 0; i < iots.docs.length; i++) {
      iotsList.add(iots.docs[i].data());
      if (iots.docs[i].data()['name'] == "SENSOR_GAS") {
        gas = await iots.docs[i].reference
            .collection('gas')
            .orderBy('hora', descending: true)
            .get();
      }
    }
    var _listGas = [];
    gas!.docs.forEach((element) {
      _listGas.add(element.data());
    });
    lastGas = _listGas.first;
  }

  Future<void> saveIot(
      String ip, String port, String name, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    http.Client client = http.Client();
    Uri uri = Uri.parse(
        'https://us-central1-spotfire-91475.cloudfunctions.net/saveIot');
    var body = {'ip': ip, 'port': port, 'name': name};
    http.Response response = await client.post(
      uri,
      body: body,
    );
    print('response: ${response.body}');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false);
  }
}
