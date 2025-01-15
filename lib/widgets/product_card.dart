import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String image;
  const ProductCard({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    child: SizedBox(
                        height: 170,
                        child: Image.asset(
                          image,
                          height: 180,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(
          //   height: 8,
          // ),
          // Text(
          //   text,
          // style: const TextStyle(
          //     color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          //   overflow: TextOverflow.ellipsis,
          //   maxLines: 1,
          // ),
          //   Text(
          //    '\$${price.toString()}',
          //    style: const TextStyle(
          //        color: Colors.black,
          //        fontSize: 17,
          //        fontWeight: FontWeight.bold),
          //    overflow: TextOverflow.ellipsis,
          //    maxLines: 1,
          //  ),
        ],
      ),
    );
  }
}
