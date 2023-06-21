import 'package:flutter/material.dart';
import 'package:login_test/main_screen.dart';
import 'package:login_test/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var _isInit = true;
  var _isLoading = false;
  // @override
  // void didChangeDependencies() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? username = prefs.getString('username');
  //   final String? password = prefs.getString('password');
  //   if (username != '') {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await Provider.of<Auth>(context, listen: false)
  //         .loginAPI(username!, password!)
  //         .then((value) async {
  //       Navigator.of(context).pushNamed(MainScreen.routeName, arguments: null);
  //       final prefs = await SharedPreferences.getInstance();

  //       await prefs.setString('username', username);
  //       await prefs.setString('password', password);
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 24.0),
            TextButton(
              onPressed: () async {
                final SharedPreferences prefs = await _prefs;
                String username = _usernameController.text;
                String password = _passwordController.text;
                if (username.isNotEmpty && password.isNotEmpty) {
                  await Provider.of<Auth>(context, listen: false)
                      .loginAPI(username, password)
                      .then((value) async {
                    // obtain shared preferences

                    await prefs.setString('username', username);
                    await prefs.setString('password', password);
                    Navigator.of(context)
                        .pushNamed(MainScreen.routeName, arguments: null);
                  });
                  // print(login);
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Login Failed'),
                            content:
                                const Text('Please enter valid credentials.'),
                            actions: [
                              ElevatedButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ));
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
