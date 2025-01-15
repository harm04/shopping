import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String uid;
  final double age;
  final String address;
  // final String phone;
  final List cart;
  final String type;
  final String profImage;

  UserModel(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      // required this.phone,
      required this.cart,
      required this.address,
      required this.age,
      required this.uid,
     required this.profImage,
      required this.type});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'cart': cart,
        // 'phone': phone,
        'uid': uid,
        'age': age,
        'address': address,
        'type': type,
        'profImage': profImage
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        email: snapshot['email'],
        age: snapshot['age'],
        password: snapshot['password'],
        firstName: snapshot['firstName'],
        lastName: snapshot['lastName'],
        cart: snapshot['cart'],
        // phone: snapshot['phone'],
        address: snapshot['address'],
        type: snapshot['type'],
        profImage: snapshot['profImage'],
        uid: snapshot['uid']);
  }
}
