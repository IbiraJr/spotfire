import 'package:flutter/material.dart';
import 'package:spotfire/login_screen/login_view_model.dart';
import 'package:provider/provider.dart';

class StopfireDrawer extends StatelessWidget {
  List<Map<String, dynamic>> _map = [
    {
      'title': 'Historico',
      'icon': Icons.history,
    },
    {
      'title': 'Sair',
      'icon': Icons.exit_to_app,
    },
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      color: Colors.white,
      width: size.width * 0.7,
      child: Column(
        children: [
          Flexible(
            flex: 20,
            child: Container(
              width: size.width,
              color: Color(0xFF0F3773),
              padding: const EdgeInsets.all(8),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.watch<LoginViewModel>().userModel!.name!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      context.watch<LoginViewModel>().userModel!.cpf!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 80,
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                ..._map.map((e) {
                  return ListTile(
                    title: Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(e['icon']),
                    onTap: () async {},
                  );
                }).toList(),
                SizedBox(
                  height: 32,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
