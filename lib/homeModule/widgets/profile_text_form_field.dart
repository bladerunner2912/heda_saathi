import 'package:flutter/material.dart';

class ProfileTextFormField extends StatefulWidget {
  final double tS;
  final TextEditingController controller;
  final TextInputType tIA;
  bool unenabled;
  ProfileTextFormField(
      {Key? key,
      required this.tS,
      required this.controller,
      required this.tIA,
      this.unenabled = false,
      })
      : super(key: key);

  @override
  State<ProfileTextFormField> createState() => _ProfileTextFormFieldState();
}

class _ProfileTextFormFieldState extends State<ProfileTextFormField> {
  @override
  Widget build(BuildContext context) {
    return 
         TextFormField(
              enabled: !widget.unenabled,
            keyboardType: widget.tIA,
            controller: widget.controller,
            style: TextStyle(fontSize: widget.tS * 18),
            decoration: const InputDecoration.collapsed(
                border: InputBorder.none, hintText: '9876543210'),
          );
  }
}
