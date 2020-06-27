import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
  final bool isDatePicker;

  InputTextField({
    this.label,
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
    this.isDatePicker = false,
  });

  @override
  State<StatefulWidget> createState() => _InputTextFieldState(
        label: this.label,
        hintText: this.hintText,
        validator: this.validator,
        onSaved: this.onSaved,
        isPassword: this.isPassword,
        isEmail: this.isEmail,
        isDatePicker: this.isDatePicker,
      );
}

class _InputTextFieldState extends State<StatefulWidget> {
  final String label;
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
  final bool isDatePicker;

  _InputTextFieldState({
    this.label,
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
    this.isDatePicker = false,
  });
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
          controller: isDatePicker ? dateController : null,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[200],
          ),
          obscureText: isPassword ? true : false,
          validator: validator,
          onSaved: onSaved,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          enableInteractiveSelection: !isDatePicker ?? true,
          onTap: isDatePicker
              ? () async {
                  DateTime date = DateTime(1900);
                  FocusScope.of(context).requestFocus(new FocusNode());

                  date = await showDatePicker(
                      context: context,
                      initialDate: dateController.text.isNotEmpty
                          ? DateFormat(dateFormat).parse(dateController.text)
                          : DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());

                  if (date != null) {
                    dateController.text = DateFormat(dateFormat).format(date);
                  }
                }
              : null),
    );
  }
}

String dateFormat = "dd/MM/yyyy";

bool isValidEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}
