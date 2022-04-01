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
  var auth;
  Map<String, String> _referenceForm = {
    'reference': '',
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void showSnackBar(String message, BuildContext context) {
    final snackBar = new SnackBar(
      content: new Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final agent = Provider.of<Agent>(context, listen: false);
    if (auth.isAgent) {
      agent.getAgent(auth.loadedUser.reference);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: auth.isAuth
            ? <Widget>[
                IconButton(
                  onPressed: () {
                    auth.logout();
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  icon: Icon(Icons.logout),
                )
              ]
            : [],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: auth.isAuth
            ? Column(
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
                          builder: (_, authUser, child) => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.brown,
                                child: Text(
                                  (authUser.loadedUser.firstName.isNotEmpty
                                          ? authUser.loadedUser.firstName[0]
                                              .toUpperCase()
                                          : '') +
                                      (authUser.loadedUser.lastName.isNotEmpty
                                          ? authUser.loadedUser.lastName[0]
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
                                            _saveForm(auth, agent);
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
                      builder: (_, agentList, child) => ListView.builder(
                        itemCount: agentList.loadedAgent.members.length,
                        itemBuilder: (BuildContext ctx, index) => Container(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              // margin: EdgeInsets.symmetric(
                              //   horizontal: 20.0,
                              //   vertical: 5.0,
                              // ),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white,
                              elevation: 5.0,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.brown,
                                    child: Text(
                                      'AH',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    radius: 20.0,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    agentList.loadedAgent.members[index],
                                    style:
                                        Theme.of(context).textTheme.headline6,
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
              )
            : Column(
                children: [
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // use instead of BorderRadius.all(Radius.circular(20))
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 5.0,
                      ),
                      //shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 5.0,
                      child: Center(
                        child: Text(
                          'Not logged in yet!',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: Text(
                      'Go To login page',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
