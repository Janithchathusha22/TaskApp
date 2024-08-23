import 'dart:convert';

import 'package:testapp/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Product>> fetchAllProducts() async {
    const String url =
        "https://restcountries.com/v3.1/region/europe?fields=name,capital,flags,region,languages,population,capital";

    try {
      final responce = await http.get(Uri.parse(url));

      if (responce.statusCode == 200) {
        List<dynamic> responceData = json.decode(responce.body);
        List<Product> products = responceData.map((json) {
          return Product.fromaJson(json);
        }).toList();

        return products;
      } else {
        print("no results found:${responce.statusCode}");
        throw Exception("network errors");
      }
    } catch (error) {
      print("Error:$error");
      throw Exception("no results found");
    }
  }

  // Fetch a single product from API
  final String baseUrl =
      "https://restcountries.com/v3.1/region/europe?fields=name,capital,flags,region,languages,population";

  // Fetch all countries
  Future<Product> fetchSingleProduct(int name) async {
    final String url =
        "https://restcountries.com/v3.1/region/europe?fields=name,capital,flags,region,languages,population,capital";

    try {
      final responce = await http.get(Uri.parse(url));
      if (responce.statusCode == 200) {
        Product product = Product.fromaJson(json.decode(responce.body));
        return product;
      } else {
        print("Faild to fetch product.Status code: ${responce.statusCode}");
        throw Exception("Faild to fetch product");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Faild to fetch product");
    }
  }
}
