import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:krushit_medical/models/product.dart';
import 'package:krushit_medical/utils/snackbar.dart';

class HomeServices {
  // Fetch all products based on category from Firestore
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    List<Product> productList = [];
    try {
      // Query the 'products' collection filtered by category
      QuerySnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('category', isEqualTo: category)
          .get();

      // Map the Firestore document snapshots to Product models
      for (var doc in productSnapshot.docs) {
        productList.add(Product.fromSnap(doc));
      }
    } catch (e) {
      showSnackbar(
          e.toString(), context); // Show error message in case of failure
    }
    return productList;
  }

  // Fetch all products from Firestore
  Future<List<Product>> fetchAllProducts({
    required BuildContext context,
   
  }) async {
    List<Product> productList = [];
    try {
      // Query the 'products' collection filtered by category
      QuerySnapshot productSnapshot =
          await FirebaseFirestore.instance.collection('products').get();

      // Map the Firestore document snapshots to Product models
      for (var doc in productSnapshot.docs) {
        productList.add(Product.fromSnap(doc));
      }
    } catch (e) {
      showSnackbar(
          e.toString(), context); // Show error message in case of failure
    }
    return productList;
  }

  // Fetch the deal of the day from Firestore
  Future<Product> dealOfDay({
    required BuildContext context,
  }) async {
    Product product = Product(
      name: '',
      seller: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );

    try {
      // Fetch the deal of the day from Firestore
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(
              'dealOfDay') // Assuming deal of the day is stored in a document with ID 'dealOfDay'
          .get();

      if (productSnapshot.exists) {
        product = Product.fromSnap(productSnapshot);
      } else {
        showSnackbar('Deal of the day not found!', context);
      }
    } catch (e) {
      showSnackbar(
          e.toString(), context); // Show error message in case of failure
    }
    return product;
  }
}
