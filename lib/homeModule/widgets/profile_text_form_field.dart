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
         Container(
      padding: !widget.unenabled
          ? const EdgeInsets.only(top: 2, bottom: 2, left: 2)
          : EdgeInsets.zero,
      decoration: BoxDecoration(
          border: Border.all(
              color: !widget.unenabled ? Colors.black : Colors.white),
          color: !widget.unenabled ? Colors.teal.shade50 : Colors.transparent),
      width: 150,
      child: TextFormField(
        enabled: !widget.unenabled,
        keyboardType: widget.tIA,
        controller: widget.controller,
        style: TextStyle(fontSize: widget.tS * 18),
        decoration: const InputDecoration.collapsed(
            border: InputBorder.none, hintText: '----------'),
      ),
    );
  }
}
