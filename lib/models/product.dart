
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String description;
  final double price;// import 'dart:convert';



  final double quantity;
  final String? id;
  final String seller;
  final String category;
  final List<String> images;
 

  Product({
    required this.name,
    required this.description,
    required this.seller,
    required this.price,
    required this.quantity,
    this.id,
    required this.category,
    required this.images,
   
  });

  
  Map<String, dynamic> toJson() => {
        'name': name,
        'seller': seller,
        'description': description,
        'price': price,
        'quantity': quantity,
        'category': category,
        'id': id,
        'images': images,
      


      };

  
  static Product fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Product(
      name: snapshot['name'] ?? '',
      seller: snapshot['seller'] ?? '',
      quantity: (snapshot['quantity'] ?? 0).toDouble(),
      description: snapshot['description'] ?? '',
      price: (snapshot['price'] ?? 0).toDouble(),
      images: List<String>.from(snapshot['images'] ?? []),
      category: snapshot['category'] ?? '',
      id: snapshot['id'],
    
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        quantity: map['quantity']?.toDouble() ?? 0.0,
        images: List<String>.from(map['images']),
        category: map['category'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
        id: map['_id'],
        seller: map['seller'] ?? "",
    
    );
  }

  
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      seller: json['seller'] ?? '',
      quantity: (json['quantity'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? '',
      id: json['id'],
    
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'images': images,
      'id': id,
      'seller': seller,
    
    };
  }
}
