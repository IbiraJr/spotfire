import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotfire/home_screen/home_view_model.dart';

class ValveControlScreen extends StatefulWidget {
  @override
  _ValveControlScreenState createState() => _ValveControlScreenState();
}

class _ValveControlScreenState extends State<ValveControlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F3773),
        title: Text('Válvula'),
      ),
      body: Consumer<HomeViewModel>(builder: (context, homeViewModel, child) {
        var valve = homeViewModel.iotsList
            .firstWhere((element) => element['name'] == 'VALVE');

        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/botijao.png'),
              Text(
                valve['isOpen'] ? 'Fechar Válvula' : 'Abrir Válvula',
                style: TextStyle(
                  fontSize: 38,
                ),
              ),
              SizedBox(
                height: 120,
                child: Switch(
                  value: valve['isOpen'],
                  onChanged: (value) {
                    homeViewModel.openAndCloseValve(value);
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
