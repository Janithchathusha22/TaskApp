import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final String capital;
  final String region;
  final String languages;
  final int? population;
  final String flags;

  Product({
    required this.name,
    required this.capital,
    required this.region,
    required this.languages,
    this.population,
    required this.flags,
  });

  factory Product.fromaJson(Map<String, dynamic> json) {
    // Extract the common name from the nested name map
    String name = json['name']['common'] ?? '';

    // Extract the capital name from the list
    String capital = (json['capital'] as List<dynamic>).isNotEmpty
        ? json['capital'][0]
        : 'N/A';

    // Extract languages as a comma-separated string
    String languages = json['languages'] != null
        ? (json['languages'] as Map<String, dynamic>).values.join(', ')
        : 'N/A';

    // Extract the PNG flag URL from the flags map
    String flags = json['flags'] != null ? json['flags']['png'] ?? '' : '';

    return Product(
      name: name,
      capital: capital,
      region: json['region'] ?? '',
      languages: languages,
      population: json['population'],
      flags: flags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'capital': capital,
      'region': region,
      'languages': languages,
      'population': population,
      'flags': flags,
    };
  }
}
