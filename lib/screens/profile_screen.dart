import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/login_screen.dart';
import '../provider/agent.dart';
import '../provider/auth.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _form = GlobalKey<FormState>();
  var _auth, _agent;
  var _isInit = true;
  bool _isAuthenticated = false;
  Map<String, String> _referenceForm = {
    'reference': '',
  };

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<Auth>(context, listen: false);
    _agent = Provider.of<Agent>(context, listen: false);
    _isAuthenticated = _auth.isAuth;
    if (_auth.isAgent) {
      _agent.getAgent(_auth.loadedUser.reference);
    }
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _auth.logout();
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              icon: Icon(Icons.logout),
            )
          ]),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.orange, Colors.pink]),
                ),
                child: Container(
                  width: double.infinity,
                  height: 350.0,
                  child: Center(
                    child: Consumer<Auth>(
                      builder: (_, auth, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.brown,
                            child: Text(
                              (auth.loadedUser.firstName.isNotEmpty
                                      ? auth.loadedUser.firstName[0]
                                          .toUpperCase()
                                      : '') +
                                  (auth.loadedUser.lastName.isNotEmpty
                                      ? auth.loadedUser.lastName[0]
                                          .toUpperCase()
                                      : ''),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            radius: 50.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            auth.loadedUser.firstName +
                                '' +
                                auth.loadedUser.lastName,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Refrence: ${auth.loadedUser.reference}",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Form(
                            key: _form,
                            child: Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Reference',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        border: OutlineInputBorder(),
                                      ),
                                      //textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Please provide refrence no.';
                                        }
                                        return null;
                                      },
                                      onSaved: (newValue) {
                                        _referenceForm['reference'] =
                                            newValue.toString();
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _saveForm(_auth, _agent);
                                      },
                                      child: Text(
                                        'Add',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
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
                  ),
                ),
              ),
              Expanded(
                child: Consumer<Agent>(
                  builder: (_, agent, child) => ListView.builder(
                    itemCount: agent.loadedAgent.members.length,
                    itemBuilder: (BuildContext ctx, index) => Container(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.brown,
                                child: Text(
                                  'AH',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                radius: 20.0,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                agent.loadedAgent.members[index],
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void _saveForm(auth, agent) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();
    var agentId = auth.loadedAgent.id;
    try {
      await agent.updateAgent(agentId, _referenceForm['reference'].toString());
      this.showSnackBar('Update successfully', context);
    } catch (err) {
      print(err);
    }
  }

  void showSnackBar(String message, BuildContext context) {
    final snackBar = new SnackBar(
      content: new Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
