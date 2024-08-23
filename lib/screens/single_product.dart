import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testapp/api/api_service.dart';
import 'package:testapp/models/product_model.dart';

class SingleProduct extends StatelessWidget {
  final int productName;
  SingleProduct({
    super.key,
    required this.productName,
  });
  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Product>(
          future: apiService.fetchSingleProduct(productName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("error: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("no results found"),
              );
            } else {
              Product product = snapshot.data!;

              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product.flags,
                      width: 400,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    Text(product.name, style: const TextStyle(fontSize: 24.0)),
                    const SizedBox(height: 8.0),
                    Text("\$${product.population}",
                        style: const TextStyle(fontSize: 20.0)),
                    const SizedBox(height: 8.0),
                    Text(product.capital),
                    const SizedBox(height: 16.0),
                    Text(product.region),
                    const SizedBox(height: 16.0),
                    Text(product.languages),
                    const SizedBox(height: 16.0),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
