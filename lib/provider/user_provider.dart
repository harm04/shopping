import 'package:flutter/material.dart';
import 'package:krushit_medical/models/user_model.dart';
import 'package:krushit_medical/services/auth_services.dart';

class UserProvider with ChangeNotifier {
  UserModel? _usermodel;
  UserModel get getUser => _usermodel!;

  Future<void> refreshUser() async {
    UserModel usermodel = await AuthServices().getUserDetails();
    _usermodel = usermodel;
    notifyListeners();
  }

  
}
