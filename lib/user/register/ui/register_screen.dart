import 'package:flutter/material.dart';
import 'package:starter/widgets/forms/input_text_field.dart';

class RegisterScreen extends StatelessWidget {
  static Route buildRoute() =>
      MaterialPageRoute(builder: (_) => RegisterScreen());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Register(),
      ),
    );
  }
}

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<StatefulWidget> {
  final _formKey = GlobalKey<FormState>();
  RegisterModel formModel = RegisterModel();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
          child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 32.0),
                          child: Text('Register',style: Theme.of(context).textTheme.headline4)),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: InputTextField(
                                hintText: 'First Name',
                                validator: (String value) {
                                  print(value);
                                  if (value.isEmpty) {
                                    return 'Enter your first name';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  formModel.firstName = value;
                                },
                              ),
                            )),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  child: InputTextField(
                                    hintText: 'Last Name',
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Enter your last name';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      formModel.lastName = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InputTextField(
                        hintText: 'Email',
                        isEmail: true,
                        validator: (String value) {
                          if (!isValidEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          formModel.email = value;
                        },
                      ),
                      InputTextField(
                        hintText: 'Password',
                        isPassword: true,
                        validator: (String value) {
                          if (value.length < 7) {
                            return 'Password should be minimum 7 characters';
                          }
                          _formKey.currentState.save();
                          return null;
                        },
                        onSaved: (String value) {
                          formModel.password = value;
                        },
                      ),
                      InputTextField(
                        hintText: 'Confirm Password',
                        isPassword: true,
                        validator: (String value) {
                          if (value.length < 7) {
                            return 'Password should be minimum 7 characters';
                          } else if (formModel.password != null &&
                              value != formModel.password) {
                            print(value);
                            print(formModel.password);
                            return 'Password not matched';
                          }
                          return null;
                        },
                      ),
                      RaisedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.

                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: Text('Submit'),
                      )
                    ],
                  )))),
    );
  }
}

class RegisterModel {
  String firstName;
  String lastName;
  String email;
  String password;
  RegisterModel({this.firstName, this.lastName, this.email, this.password});
}
