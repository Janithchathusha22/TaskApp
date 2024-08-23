import 'package:flutter/material.dart';
import 'package:testapp/api/api_service.dart';
import 'package:testapp/models/product_model.dart';
import 'package:testapp/screens/single_product.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<Product>>(
          future: apiService.fetchAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No results found"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Product product = snapshot.data![index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: ListTile(
                      title: Text(product.name), // Country name
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Capital: ${product.capital}"), // Capital
                          Text("Region: ${product.region}"), // Region
                          Text("Languages: ${product.languages}"), // Languages
                          Text(
                              "Population: ${product.population?.toString() ?? 'N/A'}"), // Population
                        ],
                      ),
                      leading: Image.network(
                        product.flags,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SingleProduct(productName: product.population!),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
