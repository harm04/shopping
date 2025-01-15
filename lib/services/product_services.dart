import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krushit_medical/models/product.dart';
import 'package:krushit_medical/provider/user_provider.dart';
import 'package:krushit_medical/utils/snackbar.dart';

import 'package:provider/provider.dart';

class ProductDetailsServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    try {
      await _firestore.collection('products').doc(product.id).update({
        'ratings': FieldValue.arrayUnion([
          {'userId': _auth.currentUser!.uid, 'rating': rating}
        ]),
      });

      showSnackbar('Product rated successfully!', context);
    } catch (e) {
      showSnackbar('Error: ${e.toString()}', context);
    }
  }

  
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    Provider.of<UserProvider>(context, listen: false);

    try {
    

      await _firestore.collection('Users').doc(_auth.currentUser!.uid).update({
        'cart': FieldValue.arrayUnion([product.id])
      });

      showSnackbar('Product added to cart!', context);
    } catch (e) {
      showSnackbar('Error: ${e.toString()}', context);
    }
  }

  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    try {
     
      await _firestore.collection('Users').doc(_auth.currentUser!.uid).update({
        'cart': FieldValue.arrayRemove([product.id])
      });
      showSnackbar('Product removed from cart!', context);
    } catch (e) {
      showSnackbar('Error: ${e.toString()}', context);
    }
  }
}
