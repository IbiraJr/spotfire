import 'package:flutter/material.dart';

class ValveControlScreen extends StatefulWidget {
  @override
  _ValveControlScreenState createState() => _ValveControlScreenState();
}

class _ValveControlScreenState extends State<ValveControlScreen> {
  bool _valveOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F3773),
        title: Text('Válvula'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _valveOpen?'Fechar Válvula':'Abrir Válvula',
              style: TextStyle(
                fontSize: 38,
              ),
            ),
            SizedBox(
              height: 120,
              child: Switch(
                value: _valveOpen,
                onChanged: (value) {
                  setState(() {
                    _valveOpen = value;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
