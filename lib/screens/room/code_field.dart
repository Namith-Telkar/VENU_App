import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeField extends StatefulWidget {
  late final Function _onChanged;

  CodeField({Key? key, required Function onChanged}) : super(key: key) {
    _onChanged = onChanged;
  }

  @override
  State<CodeField> createState() => _CodeFieldState();
}

class _CodeFieldState extends State<CodeField> {
  @override
    Widget build(BuildContext context) {
      return PinCodeTextField(
        onChanged: (String value) {
          widget._onChanged(value);
        },
        length: 6,
        appContext: (context),
        obscureText: false,
        textStyle: const TextStyle(
          fontFamily: 'Google-Sans',
          fontSize: 16,
          color: Colors.black,
        ),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5.0),
          fieldHeight: 45,
          fieldWidth: 40,
          activeFillColor: Colors.transparent,
          inactiveFillColor: Colors.transparent,
          inactiveColor: Colors.black54,
          activeColor: const Color(0xffA7D1D7),
          selectedFillColor: Colors.transparent,
          selectedColor: const Color(0xffA7D1D7),
        ),
        showCursor: true,
        cursorColor: Colors.black,
        enableActiveFill: true,
        autoFocus: false,
        keyboardType: TextInputType.number,
      );
    }
}
