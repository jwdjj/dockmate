import 'package:dockmate/model/user.dart';
import 'package:dockmate/model/usersqfModel.dart';
import 'package:dockmate/utils/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({Key key, this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  User user;
  String fname = '';
  String lname = '';
  String email = '';
  String phone;
  String password = '';
  String repassword = '';

  // TO-DOs
  // - write a function to retrieve all user emails and validate if the email already exists.
  // - insert the new user document to firebase

  @override
  Widget build(BuildContext context) {
    final _model = UserModel();
    AuthService _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/dock.png", scale: 20, color: Colors.white),
        title: Text("Registration"),
      ),
      body: Container(
        // margin: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 18),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              ListTile(
                  title: Text("Register with Dock Mate!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 23))),
              ListTile(
                  title: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your first name',
                  labelText: 'First Name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                onChanged: (value) {
                  fname = value;
                  return null;
                },
                onSaved: (value) {
                  fname = value;
                },
              )),
              ListTile(
                  title: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your last name',
                  labelText: 'Last Name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                onChanged: (value) {
                  lname = value;
                  return null;
                },
                onSaved: (value) {
                  lname = value;
                },
              )),
              ListTile(
                  title: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'xxxxxx@email.com',
                  labelText: 'Email Address',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                  // validate user email from database
                  return null;
                },
                onChanged: (value) {
                  email = value;
                  return null;
                },
                onSaved: (value) {
                  email = value;
                },
              )),
              ListTile(
                  title: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      'Use at least 8 characters with special symbols .?!_*',
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value.length < 8) {
                    return 'Password needs to be at least 8 characters long';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.length < 8) {
                    return 'Password needs to be at least 8 characters long';
                    setState(() {});
                  } else {
                    password = value;
                    return null;
                  }
                },
                onSaved: (value) {
                  password = value;
                },
              )),
              ListTile(
                  title: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Re-enter Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value != password) {
                    return 'Password does not match';
                  } else {
                    password = value;
                  }
                },
                onChanged: (value) {
                  if (value != password) {
                    return 'Password does not match';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  password = value;
                },
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 8.0),
                    child: RaisedButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        widget.toggleView('login');
                        // Navigator.of(context)
                        //     .pushReplacementNamed('/FirstScreen');
                      },
                    ),
                  ),
                  Container(
                    child: Builder(
                      builder: (context) => RaisedButton(
                        color: Colors.blue,
                        onPressed: () async {
                          // case 1: register success, proceed to Hoursing type preference
                          if (_formKey.currentState.validate()) {
                            print("First name: $fname is registered");
                            // usernameModel.setUsername(
                            //     fname); //save username to sqflite to be used by other parts
                            _formKey.currentState.save();
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    email, password, fname, lname);

                            if (result['user'] == null) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(result['msg'])));
                            } else {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(result['msg'])));
                            }
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Input fields invalid')));
                          }
                        },
                        child: Text('Submit',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
