import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krushit_medical/models/order.dart';
import 'package:krushit_medical/models/product.dart';
import 'package:krushit_medical/models/sales.dart';
import 'package:krushit_medical/utils/snackbar.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required String seller,
    required double quantity,
    required String id,
    required String category,
    required List<String> images,
  }) async {
    try {
      Product product = Product(
          name: name,
          seller: seller,
          description: description,
          price: price,
          quantity: quantity,
          id: id,
          category: category,
          images: images);
      await FirebaseFirestore.instance.collection('products').doc(id).set(
            product.toJson(),
          );
    } catch (err) {}
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required OrderModel order,
    required VoidCallback onSuccess,
  }) async {
    try {
      final orderRef =
          FirebaseFirestore.instance.collection('orders').doc(order.id);

      await orderRef.update({
        'status': status,
      });

      onSuccess();
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
  
    List<Sales> sales = [];
    int totalEarnings = 0;
    try {
     
      DocumentSnapshot earningsDoc = await FirebaseFirestore.instance
          .collection('earnings')
          .doc('earningsData') 
          .get();

      if (earningsDoc.exists) {
        var data = earningsDoc.data() as Map<String, dynamic>;

        totalEarnings = data['totalEarnings'];

        sales = [
          Sales('Mobiles', data['mobileEarnings'] ?? 0),
          Sales('Essentials', data['essentialEarnings'] ?? 0),
          Sales('Books', data['booksEarnings'] ?? 0),
          Sales('Appliances', data['applianceEarnings'] ?? 0),
          Sales('Fashion', data['fashionEarnings'] ?? 0),
        ];
      } else {
        showSnackbar("No earnings data available.", context);
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarnings,
    };
  }
}
