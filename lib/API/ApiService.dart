import 'dart:convert';
import 'package:api_map_by_bloc/MODEL/model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final String apiUrl = "https://alataba.org/vs01/get_category_locations";

  Future<List<MyCategory>> fetchCategories() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {"language": "ar"},
      headers: {'Authorization': 'Bearer 4808668736207d904285640d2a556493'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<MyCategory> categories = [];
      for (var item in data['message']['categories']) {
        categories.add(MyCategory.fromJson(item));
      }
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
