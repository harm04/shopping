import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krushit_medical/models/product.dart';
import 'package:krushit_medical/services/admin_service.dart';
import 'package:krushit_medical/widgets/post_product.dart';
import 'package:krushit_medical/widgets/product_card.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({
    super.key,
  });

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
  }

  deleteProduct(Product product, int index) {
    FirebaseFirestore.instance.collection('products').doc(product.id).delete();

    setState(() {});
  }

  void myDialoug(Product product, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/ic_sad.png',
                      height: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Do you really want to delete product?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () {
                              deleteProduct(product, index);
                              Navigator.pop(context);
                            },
                            child: const Text('Delete'))
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    // void signOut() {
    //   AuthServices().signOut(context);
    // }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(62),
          child: AppBar(
            flexibleSpace: Container(
              color: Colors.black,
            ),
            title: const Text(
              'Admin',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            // actions: [
            //   TextButton(
            //       onPressed: () {
            //         // signOut();
            //       },
            //       child: const Text(
            //         'Switch to user',
            //         style: TextStyle(color: Colors.white),
            //       ))
            // ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const PostProduct();
          }));
        },
        backgroundColor: Colors.black,
        tooltip: 'Add Product',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('seller', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No products available.'));
          } else {
            List<Product> products = snapshot.data!.docs
                .map((doc) =>
                    Product.fromJson(doc.data()))
                .toList();

            return GridView.builder(
              itemCount: products.length,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                '\$${productData.price}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          )),
                          GestureDetector(
                              onTap: () {
                                myDialoug(productData, index);
                              },
                              child: const Icon(Icons.delete))
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
