import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../api.dart';
import '../models/advertisment_model.dart';

class AdvertismentProvider with ChangeNotifier {
  final List<Advertisment> _advertisments = [];
  List<Advertisment> get advertsiments => _advertisments;

  fetchAdvertisment() async {
    var url = '${webApi['domain']}/advertisments/fetchAdvertisments';

    try {
      final response = await http
          .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

      var responeData = jsonDecode(response.body);

      for (int i = 0; i < responeData.length; i++) {
        _advertisments.add(Advertisment(
            posterUrl: responeData[i]['posterUrl'],
            websiteUrl: responeData[i]['websiteUrl']));
      }
    } catch (e) {
      return;
    }
    notifyListeners();
  }
}
