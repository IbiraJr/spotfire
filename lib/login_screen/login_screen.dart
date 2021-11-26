import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotfire/login_screen/login_view_model.dart';
import 'package:spotfire/util/spotfire_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FocusScopeNode node = FocusScope.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: size.height * 0.25,
              width: size.width,
              child: Image.asset(
                'assets/fire.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Form(
            key: _form,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.15,
                ),
                Text(
                  'Olá!\nBom ter você\nde volta',
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
                    label: 'Email',
                    textEditingController: _emailController,
                    last: true,
                    validator: (String? email) {
                      if (email!.trim().isEmpty) {
                        return 'Informe um email!';
                      } else if (!email.contains('@') || !email.contains('.')) {
                        return 'Informe um email válido!';
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
                    textEditingController: _passwordController,
                    label: 'Senha',
                    obscureText: true,
                    action: TextInputAction.done,
                    validator: (String? password) {
                      if (password!.trim().isEmpty) {
                        return 'Informe uma senha!';
                      } else if (password.length < 6) {
                        return 'Informe uma senha maior que 6 digitos!';
                      } else {
                        return null;
                      }
                    },
                    focus: node.unfocus,
                    last: true,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () async {
                    if (_form.currentState!.validate()) {
                      await context.read<LoginViewModel>().showWaitSignInDialog(
                            context,
                            _emailController.text,
                            _passwordController.text,
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
                          'Entrar',
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
                SizedBox(
                  height: size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => context
                          .read<LoginViewModel>()
                          .callSignUpPage(context),
                      child: Text(
                        'Cadastre-se',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
