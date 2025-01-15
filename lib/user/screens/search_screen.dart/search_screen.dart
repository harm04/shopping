
// import 'package:flutter/material.dart';
// import 'package:krushit_medical/models/product.dart';
// import 'package:provider/provider.dart';

// class SearchScreen extends StatefulWidget {
//   String searchQuery;
//   SearchScreen({super.key, required this.searchQuery});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   void initState() {
//     super.initState();
//     fetchSearchProducts();
//   }

//   List<Product>? products;
//   final SearchServices searchServices = SearchServices();

//   fetchSearchProducts() async {
//     products = await searchServices.fetchSearchedProducts(
//         context: context, searchQuery: widget.searchQuery);
//     setState(() {});
//   }

//   navigateToSearchScreen(String search) {
//     setState(() {
//       widget.searchQuery = search;
//       fetchSearchProducts();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context).user;
//     return Scaffold(
//       appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(70),
//           child: AppBar(
//             flexibleSpace: Container(
//               color: Colors.black,
//             ),
//             title: TextFormField(
//               onFieldSubmitted: navigateToSearchScreen,
//               initialValue: widget.searchQuery,
//               decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   prefixIcon: Image.asset(
//                     'assets/icons/ic_search.png',
//                     height: 30,
//                     color: Colors.grey,
//                   ),
//                   hintText: 'Search',
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: const BorderSide(color: Colors.grey)),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: const BorderSide(color: Colors.grey)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: const BorderSide(width: 1.4))),
//             ),
//             actions: [
//               GestureDetector(
//                   onTap: () {},
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 18.0),
//                     child: Image.asset(
//                       'assets/icons/ic_bell.png',
//                       height: 26,
//                       color: Colors.white,
//                     ),
//                   )),
//             ],
//           )),
//       body: products == null
//           ? const Loader()
//           : Column(
//               children: [
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   color: const Color.fromARGB(255, 236, 236, 236),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: [
//                             Image.asset(
//                               'assets/icons/ic_location.png',
//                               height: 25,
//                               color: Colors.black,
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                                 child: Text(
//                               'Delivery to ${user.firstname} ${user.lastname} : cdcdcdcc cdceefrffrfceceeveve vvee ecaddress',
//                               style: const TextStyle(
//                                   color: Colors.black, fontSize: 14),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               textAlign: TextAlign.left,
//                             )),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 20.0),
//                               child: GestureDetector(
//                                   onTap: () {},
//                                   child: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: Colors.black,
//                                   )),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                       scrollDirection: Axis.vertical,
//                       itemCount: products!.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (context) {
//                               return  ProductDetails(product: products![index],);
//                             }));
//                           },
//                           child: SearchProductCard(
//                             product: products![index],
//                           ),
//                         );
//                       }),
//                 )
//               ],
//             ),
//     );
//   }
// }
