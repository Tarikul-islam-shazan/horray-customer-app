import 'package:flutter/material.dart';
import 'package:horray/provider/auth.dart';
import 'package:horray/screens/login_screen.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _form = GlobalKey<FormState>();
  Map<String, String> _referenceForm = {
    'reference': '',
  };

  void showSnackBar(String message, BuildContext context) {
    final snackBar =
        new SnackBar(content: new Text(message), backgroundColor: Colors.red);
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _saveForm(BuildContext context) async {
    var auth = Provider.of<Auth>(context, listen: false);
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();
    var agentId = auth.loadedAgent.id;
    try {
      await auth.updateAgent(agentId, _referenceForm['reference'].toString());
      this.showSnackBar('Update successfully', context);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    // Provider.of<Auth>(context, listen: true).getUserinfo();
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
                                height: 10.0,
                              ),
                              Card(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 5.0,
                                ),
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white,
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 5.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Own Points",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "100",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Member",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "5",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Point From team",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "100",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
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
                                              border: OutlineInputBorder()),
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
                                            _saveForm(context);
                                          },
                                          child: Text(
                                            'Add',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
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
                    child: Consumer<Auth>(
                      builder: (_, auth, child) => ListView.builder(
                        itemCount: auth.loadedAgent.members.length,
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
                                    auth.loadedAgent.members[index],
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
                  // OutlinedButton(
                  //   onPressed: () {
                  //     auth.logout();
                  //     Navigator.of(context).pushNamed(LoginScreen.routeName);
                  //   },
                  //   child: Text(
                  //     'Logout',
                  //     style: Theme.of(context).textTheme.headline6,
                  //   ),
                  // ),
                ],
              )
            : Column(
                children: [
                  Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 5.0,
                      ),
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
