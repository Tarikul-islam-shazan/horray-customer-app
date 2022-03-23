import 'package:flutter/material.dart';
import 'package:horray/provider/auth.dart';
import 'package:horray/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  Map<String, String> _loginForm = {
    'phone': '',
    'password': '',
  };

  Future<void> _saveForm(BuildContext ctx) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();
    try {
      await Provider.of<Auth>(context, listen: false).login(
          _loginForm['phone'].toString(), _loginForm['password'].toString());
      Navigator.pop(context);
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Here',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
                //textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,

                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please provide a phone no.';
                  }
                  if (value.toString().length != 11) {
                    return 'Please enter 11 digits.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _loginForm['phone'] = value.toString();
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                controller: _passwordController,
                // textInputAction: TextInputAction.next,
                // keyboardType: TextInputType.visiblePassword,
                // onFieldSubmitted: (_) {
                //   // _saveForm();
                // },
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please provide a password.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _loginForm['password'] = value.toString();
                },
              ),
              OutlinedButton(
                onPressed: () {
                  _saveForm(context);
                },
                child: Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
