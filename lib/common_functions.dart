import 'package:flutter/material.dart';

import 'homeModule/models/saathi_model.dart';

navigator(BuildContext context, Widget route) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => route));
  });
}


loadSaathis(responseData , members)
{
  for (int i = 0; i < responseData['users'].length; i++) {
        var rs = responseData['users'][i];
        members.add(Saathi(
            userId: rs['userId'],
            dob: DateTime.now(),
            email: rs['email'],
            profession: rs['profession'] ?? 'DOCTORRR',
            place: rs['place'] ?? 'DOCTORRR',
            phone: rs['phone'] ?? 'DOCTORRR',
            gender: rs['gender'] ?? 'DOCTORRR',
            avatar: rs['avatar']??'',
            name: rs['name'] ?? 'DOCTORRR'));
      }
}