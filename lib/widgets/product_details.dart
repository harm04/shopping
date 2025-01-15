import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:krushit_medical/models/product.dart';
import 'package:krushit_medical/services/product_services.dart';
import 'package:krushit_medical/widgets/stars.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  double avgRating = 0;
  double myRating = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   double totleRating = 0;
  //   for (int i = 0; i < widget.product.rating!.length; i++) {
  //     totleRating += widget.product.rating![i].rating;
  //     if (widget.product.rating![i].userId ==
  //         Provider.of<UserProvider>(context, listen: false).getUser.uid) {
  //       myRating = widget.product.rating![i].rating;
  //     }
  //   }
  //   if (totleRating != 0) {
  //     avgRating = totleRating / widget.product.rating!.length;
  //   }
  // }

  addToCart() {
    productDetailsServices.addToCart(context: context, product: widget.product);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            flexibleSpace: Container(
              color: Colors.black,
            ),
            title: const Text(
              'Shop Now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.id!,
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    Stars(rating: avgRating)
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12)),
                height: 300,
                child: CarouselSlider(
                    items: widget.product.images.map((i) {
                      return Builder(builder: (BuildContext context) {
                        return Image.asset(
                          i,
                          fit: BoxFit.contain,
                          height: 300,
                        );
                      });
                    }).toList(),
                    options: CarouselOptions(viewportFraction: 1, height: 300)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.product.name,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Text(
                '30% off',
                style: TextStyle(
                    color: Color.fromARGB(255, 1, 165, 37), fontSize: 16),
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text:
                      '\$${widget.product.price + widget.product.price * 0.30}',
                  style: const TextStyle(
                      color: Colors.black54,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 16),
                ),
                TextSpan(
                    text: '  \$${widget.product.price}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 194, 3, 3),
                        fontSize: 20,
                        fontWeight: FontWeight.bold))
              ])),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.product.description,
                style: const TextStyle(color: Colors.black),
              ),
              const Divider(
                color: Colors.black12,
                thickness: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  addToCart();
                },
                child: Card(
                  child: Container(
                    height: 60,
                    // width: 180,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 243, 243, 243),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Add to cart',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black12,
                thickness: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Rate this Product',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              RatingBar.builder(
                  initialRating: myRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 255, 196, 4),
                      ),
                  onRatingUpdate: (rating) {
                    productDetailsServices.rateProduct(
                        context: context,
                        product: widget.product,
                        rating: rating);
                  }),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
