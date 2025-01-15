import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krushit_medical/models/order.dart';
import 'package:krushit_medical/services/admin_service.dart';
import 'package:krushit_medical/widgets/order_details.dart';
import 'package:krushit_medical/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final AdminServices adminServices = AdminServices();

  Stream<List<OrderModel>> fetchAllOrdersFromFirestore() {
    return FirebaseFirestore.instance
        .collection('orders')
        .snapshots() 
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromMap(doc.data()))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OrderModel>>(
      stream: fetchAllOrdersFromFirestore(),  
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No orders available'));
        }

        final orders = snapshot.data!;

        return GridView.builder(
          itemCount: orders.length, 
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.91),
          itemBuilder: (context, index) {
            final orderData = orders[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OrderDetails(order: orderData);
                }));
              },
              child: SizedBox(
                height: 140,
                child: ProductCard(image: orderData.products[0].images[0]),
              ),
            );
          },
        );
      },
    );
  }
}
