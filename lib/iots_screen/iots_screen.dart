import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotfire/home_screen/home_view_model.dart';
import 'package:spotfire/iot_form/iot_form.dart';

class IotsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('IoTs'),
          backgroundColor: Color(0xFF0F3773),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IotForm(),
                    ));
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: Consumer<HomeViewModel>(builder: (context, homeViewModel, child) {
          var iots = homeViewModel.iotsList;
          return ListView.separated(
            padding: EdgeInsets.only(top: 16),
            separatorBuilder: (context, index) => Divider(
              thickness: 1,
              color: Colors.black12,
            ),
            itemBuilder: (context, index) {
              if (iots.isNotEmpty) {
                return ListTile(
                  title: Text(iots[index]['name']),
                  subtitle: Text(iots[index]['ip']),
                  onTap: () {
                    if (iots[index]['name'] == "VALVE") {
                      // Navigator.push(DESLIGAR GAS);
                    }
                  },
                );
              } else {
                return ListTile(
                  title: Text('Cadastre um novo IoT para visualizar ele aqui.'),
                  onTap: () {
                    //Navigator.push(Cadastrar novo IoT);
                  },
                );
              }
            },
            itemCount: iots.isEmpty ? 1 : iots.length,
          );
        }));
  }
}
