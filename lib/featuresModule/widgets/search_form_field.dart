import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class SearchFormField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode node;
  final FocusNode? nextFocusNode;
  final double tS;
  final String hintText;
  bool isBirthAnniv;
  SearchFormField(
      {required this.hintText,
      required this.controller,
      required this.tS,
      required this.node,
      this.nextFocusNode,
      this.isBirthAnniv = false,
      super.key});

  @override
  State<SearchFormField> createState() => _SearchFormFieldState();
}

class _SearchFormFieldState extends State<SearchFormField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() async {
          if (widget.isBirthAnniv) {
            DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1920),
                lastDate: DateTime.now());
            if (selectedDate != null) {
              widget.controller.text = DateFormat('dd MMM yyyy').format(selectedDate);
              widget.node.nextFocus();
            }
            setState(() {});
          }
        }),
      child: TextFormField(
        enabled: !widget.isBirthAnniv,
        focusNode: widget.node,
        controller: widget.controller,
        onFieldSubmitted: ((_) => widget.node.nextFocus()),
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: widget.tS * 14),
            contentPadding: const EdgeInsets.all(4),
            isDense: true,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.black, width: 0.5))),
      ),
    );
  }
}
