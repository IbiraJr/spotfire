import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotfire/home_screen/home_view_model.dart';
import 'package:spotfire/util/spotfire_form.dart';

class IotForm extends StatefulWidget {
  @override
  _IotFormState createState() => _IotFormState();
}

class _IotFormState extends State<IotForm> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FocusScopeNode node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F3773),
        title: Text('Novo IoT'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'Cadastre um novo IoT\npara começar',
                style: TextStyle(
                  color: Color(0xFF0F3773),
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        color: Colors.black26,
                        spreadRadius: 1,
                      )
                    ]),
                child: SpotfireFormField.buildTextFormField(
                  label: 'IP',
                  textEditingController: _ipController,
                  last: true,
                  validator: (String? ip) {
                    if (ip!.trim().isEmpty) {
                      return 'Informe um ip!';
                    } else {
                      return null;
                    }
                  },
                  action: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  focus: node.nextFocus,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        color: Colors.black26,
                        spreadRadius: 1,
                      )
                    ]),
                child: SpotfireFormField.buildTextFormField(
                  label: 'Porta',
                  textEditingController: _portController,
                  last: true,
                  action: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focus: node.nextFocus,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        color: Colors.black26,
                        spreadRadius: 1,
                      )
                    ]),
                child: SpotfireFormField.buildTextFormField(
                  label: 'Nome',
                  textEditingController: _nameController,
                  last: true,
                  action: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  focus: node.unfocus,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () async {
                  if (_form.currentState!.validate()) {
                    await context.read<HomeViewModel>().saveIot(
                          _ipController.text,
                          _portController.text,
                          _nameController.text,
                          context,
                        );
                  }
                },
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(0xFF0F3773),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Cadastrar',
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
