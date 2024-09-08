// import 'dart:convert';
// import 'package:api_map_by_bloc/MODEL/model.dart';
// import 'package:http/http.dart' as http;


// class ApiService {
//   final String apiUrl = "https://alataba.org/vs01/get_category_locations";

//   Future<List<MyCategory>> fetchCategories() async {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       body: {"language": "ar"},
//       headers: {'Authorization': 'Bearer 4808668736207d904285640d2a556493'},
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);

//       List<MyCategory> categories = [];
//       for (var item in data['message']['categories']) {
//         categories.add(MyCategory.fromJson(item));
//       }
//       return categories;
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }
// }
//!

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:api_map_by_bloc/MODEL/model.dart';

class ApiService {
  final String apiUrl = "https://alataba.org/vs01/get_category_locations";

  Future<List<MyCategory>> fetchCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'categories_cache';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {"language": "ar"},
        headers: {'Authorization': 'Bearer 4808668736207d904285640d2a556493'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Data received: $data'); // Debug print

        if (data['message'] != null && data['message']['categories'] != null) {
          List<MyCategory> categories = [];
          for (var item in data['message']['categories']) {
            categories.add(MyCategory.fromJson(item));
          }

          //! Save to cache
          //بعد استلام البيانات، يتم تخزينها مؤقتًا في SharedPreferences تحت مفتاح يسمى categories_cache. بهذه الطريقة، إذا فشل الاتصال في المستقبل، يمكن للتطبيق الاعتماد على البيانات المخزنة.
          await prefs.setString(cacheKey, json.encode(data));
          print('Data saved to cache');
          
          return categories;
        } else {
          print('Invalid data format: ${data['message']}');
          return [];
        }
      } else {
      //! التعامل مع فشل الاتصال أو أي خطأ:
        final cachedData = prefs.getString(cacheKey);
        if (cachedData != null) {
          print('Loading data from cache');
          final data = json.decode(cachedData);
          List<MyCategory> categories = [];
          for (var item in data['message']['categories']) {
            categories.add(MyCategory.fromJson(item));
          }
          return categories;
        }
        throw Exception('Failed to load categories: ${response.statusCode}');
      //!التعامل مع الأخطاء
      }
    } catch (e) {
      print('Error in ApiService: $e'); // Debug print
      final cachedData = prefs.getString(cacheKey);
      if (cachedData != null) {
        print('Loading data from cache');
        final data = json.decode(cachedData);
        List<MyCategory> categories = [];
        for (var item in data['message']['categories']) {
          categories.add(MyCategory.fromJson(item));
        }
        return categories;
      }
      return [];
    }
  }
}
//إذا حدث خطأ أثناء محاولة الاتصال أو أي استثناء، يتم التعامل مع الخطأ باستخدام جملة catch. في هذه الحالة، يتم محاولة استرجاع البيانات من الـ Cache كما تم شرحه مسبقًا. إذا لم تكن هناك بيانات مخزنة مؤقتًا، يتم إرجاع قائمة فارغة.

//? ملخص
// عندما لا يكون هناك اتصال بالإنترنت:

// يحاول التطبيق أولًا جلب البيانات من الـ Cache (التخزين المؤقت المحلي).
// إذا كانت البيانات موجودة في الـ Cache، يتم استخدامها بدلاً من البيانات المباشرة من الـ API.
// إذا لم تكن هناك بيانات في الـ Cache، يتم إرجاع قائمة فارغة، وقد يظهر خطأ في الواجهة الأمامية لإبلاغ المستخدم بعدم توفر البيانات.