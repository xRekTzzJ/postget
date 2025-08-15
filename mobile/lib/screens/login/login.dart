import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();
    final loginController = TextEditingController();

    final loginFocus = FocusNode();
    final passwordFocus = FocusNode();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "POST",
                  style: TextStyle(color: Colors.green),
                  textScaler: TextScaler.linear(2),
                ),
                Text(
                  "GET",
                  style: TextStyle(color: Colors.pink),
                  textScaler: TextScaler.linear(2),
                ),
              ],
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: loginController,
                      focusNode: loginFocus,
                      decoration: InputDecoration(labelText: 'Логин'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Введите логин";
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        focusNode: passwordFocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Введите пароль";
                          }
                          if (value.length < 6) return "Неверный пароль";
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Пароль'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => {
                            if (formKey.currentState!.validate())
                              {print('Form is valid')},
                          },
                          child: Text("Войти"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
