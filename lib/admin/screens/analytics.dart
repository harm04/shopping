import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krushit_medical/models/product.dart';
import 'package:krushit_medical/widgets/product_card.dart';

class SellerOrdersPage extends StatefulWidget {
  const SellerOrdersPage({super.key});

  @override
  State<SellerOrdersPage> createState() => _SellerOrdersPageState();
}

class _SellerOrdersPageState extends State<SellerOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordered Products',style: TextStyle(color: Colors.white,fontSize: 20),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('sellerId',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, orderSnapshot) {
          if (orderSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (orderSnapshot.hasError) {
            return Center(child: Text('Error: ${orderSnapshot.error}'));
          } else if (!orderSnapshot.hasData ||
              orderSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders found.'));
          } else {
            List<String> productIds = orderSnapshot.data!.docs
                .map((doc) => doc['productId'] as String)
                .toList();

            return FutureBuilder(
              future: _fetchOrderedProducts(productIds),
              builder: (context, productSnapshot) {
                if (productSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (productSnapshot.hasError) {
                  return Center(child: Text('Error: ${productSnapshot.error}'));
                } else if (!productSnapshot.hasData ||
                    productSnapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No product details available.'));
                } else {
                  List<Product> products =
                      productSnapshot.data as List<Product>;

                  // Calculate total amount
                  double totalAmount = products.fold(
                      0.0, (sum, product) => sum + product.price);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display total amount
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.69),
                          itemBuilder: (context, index) {
                            final productData = products[index];
                            return Column(
                              children: [
                                SizedBox(
                                  child: ProductCard(
                                    image: productData.images.isNotEmpty
                                        ? productData.images[0]
                                        : 'default_image_path', // Use a default image if empty
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productData.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\$${productData.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Product>> _fetchOrderedProducts(List<String> productIds) async {
    if (productIds.isEmpty) return [];

    QuerySnapshot productSnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where(FieldPath.documentId, whereIn: productIds)
        .get();

    return productSnapshot.docs
        .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
