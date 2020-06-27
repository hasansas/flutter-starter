import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:intl/intl.dart';
import 'package:starter/widgets/forms/input_text_field.dart';
import 'package:starter/user/register/models/register_model.dart';
import 'package:starter/user/register/register.dart';

enum Gender { male, female }

class RegisterScreen extends StatelessWidget {
  static Route buildRoute() =>
      MaterialPageRoute(builder: (_) => RegisterScreen());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Register(),
    );
  }
}

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<StatefulWidget> {
  static final _log = Logger("Register");
  final _formKey = GlobalKey<FormState>();
  RegisterModel _formModel = RegisterModel();
  Gender _gender;
  String dropdownValue = 'One';

  TextEditingController dateCtl = TextEditingController();
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
                          child: Text('Register',
                              style: Theme.of(context).textTheme.headline4)),
                      InputTextField(
                        isDatePicker: true,
                        hintText: 'DOB',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please fill DOB';
                          }
                          setState(() {
                            _formModel.dob =
                                DateFormat(dateFormat).parse(value);
                          });
                          return null;
                        },
                      ),
                      // DropdownButton<String>(
                      //   value: dropdownValue,
                      //   icon: Icon(Icons.arrow_downward),
                      //   iconSize: 24,
                      //   elevation: 16,
                      //   style: TextStyle(color: Colors.deepPurple),
                      //   underline: Container(
                      //     height: 2,
                      //     color: Colors.deepPurpleAccent,
                      //   ),
                      //   onChanged: (String newValue) {
                      //     setState(() {
                      //       dropdownValue = newValue;
                      //     });
                      //   },
                      //   items: <String>['One', 'Two', 'Free', 'Four']
                      //       .map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      // ),
                      // ListTile(
                      //   title: const Text('Male'),
                      //   leading: Radio(
                      //     value: Gender.male,
                      //     groupValue: _gender,
                      //     onChanged: (Gender value) {
                      //       setState(() {
                      //         _gender = value;
                      //       });
                      //     },
                      //   ),
                      // ),
                      // ListTile(
                      //   title: const Text('Female'),
                      //   leading: Radio(
                      //     value: Gender.female,
                      //     groupValue: _gender,
                      //     onChanged: (Gender value) {
                      //       setState(() {
                      //         _gender = value;
                      //       });
                      //     },
                      //   ),
                      // ),
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
                                  if (value.isEmpty) {
                                    return 'Enter your first name';
                                  }
                                  setState(() {
                                    _formModel.firstName = value;
                                  });
                                  return null;
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
                                      setState(() {
                                        _formModel.lastName = value;
                                      });
                                      return null;
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
                          setState(() {
                            _formModel.email = value;
                          });
                          return null;
                        },
                      ),
                      InputTextField(
                        hintText: 'Password',
                        isPassword: true,
                        validator: (String value) {
                          if (value.length < 7) {
                            return 'Password should be minimum 7 characters';
                          }
                          setState(() {
                            _formModel.password = value;
                          });
                          return null;
                        },
                      ),
                      InputTextField(
                        hintText: 'Confirm Password',
                        isPassword: true,
                        validator: (String value) {
                          if (value.length < 7) {
                            return 'Password should be minimum 7 characters';
                          } else if (_formModel.password != null &&
                              value != _formModel.password) {
                            return 'Password not matched';
                          }
                          return null;
                        },
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            register(_formModel);
                          }
                        },
                        child: Text('Submit'),
                      )
                    ],
                  )))),
    );
  }

  void register(RegisterModel form) {
    _log.info(_formModel.toJson());

    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Processing Data')));
  }
}
