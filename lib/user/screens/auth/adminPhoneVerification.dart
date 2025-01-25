// import 'package:flutter/material.dart';
// import 'package:krushit_medical/services/auth_services.dart';
// import 'package:krushit_medical/widgets/custom_buttom.dart';

// class AdminPhoneVerification extends StatefulWidget {
//   const AdminPhoneVerification({super.key});

//   @override
//   State<AdminPhoneVerification> createState() => _AdminPhoneVerificationState();
// }

// class _AdminPhoneVerificationState extends State<AdminPhoneVerification> {
//   final TextEditingController phoneController = TextEditingController();
//   final String countryCode = '+91';

//   @override
//   void initState() {
//     super.initState();
//     phoneController.addListener(() {
//       if (!phoneController.text.startsWith(countryCode)) {
//         phoneController.text = '$countryCode${phoneController.text}';
//         phoneController.selection = TextSelection.fromPosition(
//           TextPosition(offset: phoneController.text.length),
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     phoneController.dispose();
//     super.dispose();
//   }

//   sendOtp() {
//     print("Phone Number: ${phoneController.text}");
//     AuthServices().phoneSignin(context, phoneController.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Admin Phone Verification')),
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               maxLength: 13,
//               controller: phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: const InputDecoration(
//                 hintText: 'Enter Phone Number',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             GestureDetector(
//               onTap: () async {
//                 await sendOtp();
//                 // Navigator.pushReplacement(context,
//                 //     MaterialPageRoute(builder: (context) {
//                 //   return AdminPhoneVerification();
//                 // }));
//               },
//               child: CustomButton(
//                 buttonText: 'Send OTP',
//                 buttonColor: Colors.black,
//                 textColor: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
