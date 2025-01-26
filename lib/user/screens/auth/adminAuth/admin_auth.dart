import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:krushit_medical/provider/user_provider.dart';
import 'package:krushit_medical/utils/file_picker.dart';
import 'package:krushit_medical/utils/snackbar.dart';
import 'package:krushit_medical/widgets/admin_bottom_bar.dart';
import 'package:krushit_medical/widgets/custom_buttom.dart';
import 'package:krushit_medical/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class AdminAuthPage extends StatefulWidget {
  const AdminAuthPage({super.key});

  @override
  State<AdminAuthPage> createState() => _AdminAuthPageState();
}

class _AdminAuthPageState extends State<AdminAuthPage> {
  TextEditingController shopNameController = TextEditingController();
  File? shopImage;
  File? gstImage;
  bool isLoading = false;

  void selectShopPic() async {
    final shopImg = await pickImage();
    if (shopImg != null) {
      setState(() {
        shopImage = shopImg;
      });
    }
  }

  void selectGSTPic() async {
    final gstImg = await pickImage();
    if (gstImg != null) {
      setState(() {
        gstImage = gstImg;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider =
        Provider.of<UserProvider>(context, listen: false).getUser;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Admin Auth Page')),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verification',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Add Shop name'),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      maxlength: 20,
                        hintText: 'Shop Name',
                        type: TextInputType.text,
                        controller: shopNameController,
                        obsecureText: false),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Add Shop photo'),
                    SizedBox(
                      height: 10,
                    ),
                    DottedBorder(
                      color: Colors.grey,
                      dashPattern: [8, 4],
                      strokeWidth: 1.5,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: GestureDetector(
                          onTap: selectShopPic,
                          child: shopImage != null
                              ? Image.file(shopImage!)
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Upload banner picture',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Add Shop GST'),
                    SizedBox(
                      height: 10,
                    ),
                    DottedBorder(
                      color: Colors.grey,
                      dashPattern: [8, 4],
                      strokeWidth: 1.5,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: GestureDetector(
                          onTap: selectGSTPic,
                          child: gstImage != null
                              ? Image.file(gstImage!)
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Upload banner picture',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        //add delay for loader
                        if (shopImage != null &&
                            gstImage != null &&
                            shopNameController.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          Future.delayed(const Duration(seconds: 4), () {
                            setState(() {
                              isLoading = false;
                            });
                          });
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return AdminBottomBAr();
                          }));
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(userProvider.uid).update({
                                'type':'seller'
                              });
                        } else {
                          showSnackbar('Please enter the details', context);
                        }
                      },
                      child: CustomButton(
                          buttonText: 'Submit for verification',
                          buttonColor: Colors.black,
                          textColor: Colors.white),
                    )
                  ],
                ),
              ),
            ));
  }
}
