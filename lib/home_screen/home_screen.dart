import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotfire/drawer/spotfire_drawer.dart';
import 'package:spotfire/home_screen/home_view_model.dart';
import 'package:spotfire/iots_screen/iots_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StopfireDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF0F3773),
        title: Text('Stopfire'),
      ),
      body: FutureBuilder(
          future: context.watch<HomeViewModel>().getIotGas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> _gas =
                  context.watch<HomeViewModel>().lastGas!;
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
                children: [
                  buildGasNivelBody(_gas),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IotsScreen(),
                          ));
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 160,
                            child: Image.asset(
                              'assets/iot.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'IOTS',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Configure e gerencie seus dispositivos IoT.',
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildGasNivelBody(Map<String, dynamic> _gas) {
    if (_gas['nivel'] == 'BAIXO') {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 160,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/cozinha.png',
                    fit: BoxFit.fitWidth,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Desligar o gás',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Tudo sobre controle\nNível de gás: ${_gas['nivel']}',
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else if (_gas['nivel'] == 'MEDIO') {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 160,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/cozinha.png',
                    fit: BoxFit.fitWidth,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      'assets/fumaca.png',
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Desligar o gás',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Cuidado!\nGás próximo do nível perigoso\nNível do gás: ${_gas['nivel']}',
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else if (_gas['nivel'] == 'ALTO') {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 160,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/cozinha.png',
                    fit: BoxFit.fitWidth,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    top: 0,
                    child: Opacity(
                      opacity: 0.8,
                      child: Image.asset(
                        'assets/fire.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Desligar o gás',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Cuidado!\nGás em nível perigoso\nNível do gás: ${_gas['nivel']}',
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
