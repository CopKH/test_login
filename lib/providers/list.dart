import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListProduct {
  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  dynamic rating;
  int stock;
  String brand;
  String category;
  String images;

  ListProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.images
  });
}

class ListData with ChangeNotifier {
  List<ListProduct> _product = [];
  List<ListProduct> get product {
    return [..._product];
  }

  Future<void> listAPI() async {
    print('listAPI');
    var url = Uri.https(
      'dummyjson.com',
      'products',
    );
    try {
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});

      final extractedDataPre = jsonDecode(response.body);
      // print('extractedData');
      final extractedData = extractedDataPre['products'] as List<dynamic>;
      // print(extractedData);
      // extractedData.map()
      // print(extractedData.runtimeType);
      final loppData = extractedData.map((listData) {
        return ListProduct(
            id: listData['id'],
            title: listData['title'],
            description: listData['description'],
            price: listData['price'],
            discountPercentage: listData['discountPercentage'],
            rating: listData['rating'],
            stock: listData['stock'],
            brand: listData['brand'],
            category: listData['category'],
            images: listData['images'][0]);
      }).toList();
      _product = loppData;
    } catch (error) {
      print('Error: ');
      print(error);
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
