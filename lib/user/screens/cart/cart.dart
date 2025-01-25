import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krushit_medical/models/product.dart';
import 'package:krushit_medical/provider/user_provider.dart';
import 'package:krushit_medical/utils/snackbar.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.getUser.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var userDoc = snapshot.data!;
          List<String> cartIds = List<String>.from(userDoc['cart'] ?? []);

          return FutureBuilder<List<Product>>(
            future: _fetchCartProducts(cartIds),
            builder: (context, cartSnapshot) {
              if (!cartSnapshot.hasData) {
                return Center(child: Text('No item in cart'));
              }

              var productsInCart = cartSnapshot.data!;
              return ListView.builder(
                itemCount: productsInCart.length,
                itemBuilder: (context, index) {
                  var product = productsInCart[index];
                  return CartItemWidget(
                    product: product,
                    onRemove: () {
                      _removeFromCart(context, product);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Product>> _fetchCartProducts(List<String> cartIds) async {
    var productDocs = await FirebaseFirestore.instance
        .collection('products')
        .where('id', whereIn: cartIds)
        .get();

    return productDocs.docs.map((doc) => Product.fromSnap(doc)).toList();
  }

  void _removeFromCart(BuildContext context, Product product) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final userRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userProvider.getUser.uid);

      await userRef.update({
        'cart': FieldValue.arrayRemove([product.id]),
      });

      showSnackbar('Product removed from cart', context);
    } catch (e) {
      showSnackbar(
          'Error removing product from cart: ${e.toString()}', context);
    }
  }
}

class CartItemWidget extends StatefulWidget {
  final Product product;
  final VoidCallback onRemove;

  const CartItemWidget({
    required this.product,
    required this.onRemove,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

bool isLoading = false;

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Image.asset(
                    widget.product.images.isNotEmpty
                        ? widget.product.images[0]
                        : '',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.product.name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text('\$${widget.product.price}',
                            style: TextStyle(fontSize: 14)),
                        SizedBox(height: 5),
                        Text('Seller: ${widget.product.seller}',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon:
                            Icon(Icons.remove_shopping_cart, color: Colors.red),
                        onPressed: widget.onRemove,
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async{
                          setState(() {
                            isLoading = true;
                          });
                        await  FirebaseFirestore.instance
                              .collection('orders')
                              .doc(DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString())
                              .set({
                            'userId': userProvider.getUser.uid,
                            'productId': widget.product.id,
                            'sellerId': widget.product.seller,
                            'createdAt': DateTime.now(),
                          });
                          setState(() {
                            isLoading = false;
                          });
                          showSnackbar('Product ordered', context);
                        },
                        child: Container(
                          height: 30,
                          width: 50,
                          child: Center(child: Text('Buy')),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
