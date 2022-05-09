import 'dart:convert';

import 'package:fake_credit_card_generator/model/CardModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyController extends GetxController {
  var dropdownValue = Rxn<String>();

  List<String> items = ["visa", "mastercard", "amex", "diners", "maestro"].obs;

  final String baseUrl = "https://api.bincodes.com/cc-gen/json/";

  final String apiKEY = dotenv.env["RAPID_API_KEY"]!;

  RxList<CardModel> cards = RxList();

  Future<RxList<CardModel>> getData() async {
    final response = await http.get(Uri.parse(
        baseUrl + apiKEY + "/" + dropdownValue.value.toString() + "/"));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      cards.add(
        CardModel(
          card: body["card"],
          number: body["number"],
        ),
      );
      return cards;
    } else {
      throw Exception("Failed to load album");
    }
  }
}
