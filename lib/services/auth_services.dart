import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:krushit_medical/models/user_model.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('Users').doc(currentUser.uid).get();
    return UserModel.fromSnap(snap);
  }

  void signput() async {
    await _auth.signOut();
  }

  Future<String> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    String res = 'some error occurred';
    try {
      if (firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential _cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserModel userModel = UserModel(
            profImage: '',
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
            cart: [],
            address: '',
            age: 0,
            uid: _cred.user!.uid,
            type: 'user');
        await _firestore
            .collection('Users')
            .doc(_cred.user!.uid)
            .set(userModel.toJson());
        res = "success";
      } else {
        res = 'Please enter all the fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> login(
      {required String email, required String password}) async {
    String res = 'something went wrong';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = "success";
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> logout() async {
    String res = 'something went wrong';
    try {
      await _auth.signOut();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Future<void> phoneSignin(BuildContext context, String phoneNumber) async {
  //   TextEditingController codeController = TextEditingController();
  //   await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential creadintial) async {
  //         await _auth.signInWithCredential(creadintial);
  //       },
  //       verificationFailed: (e) {
  //         showSnackbar(e.message.toString(), context);
  //       },
  //       codeSent: ((String verificationId, int? resendToken) async {
  //         showOTPDialoug(
  //             context: context,
  //             codeController: codeController,
  //             onpressed: () async {
  //               PhoneAuthCredential creadintial = PhoneAuthProvider.credential(
  //                   verificationId: verificationId,
  //                   smsCode: codeController.text.trim());
  //               await _auth.signInWithCredential(creadintial);
  //               Navigator.pop(context);
  //             });
  //       }),
  //       codeAutoRetrievalTimeout: (String verificationId) {});
  // }
}
