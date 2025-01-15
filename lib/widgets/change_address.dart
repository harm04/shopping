import 'package:flutter/material.dart';
import 'package:krushit_medical/widgets/custom_textfield.dart';

class ChangeAddress extends StatefulWidget {
  const ChangeAddress({super.key});

  @override
  State<ChangeAddress> createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  TextEditingController flatBuildingcontroller = TextEditingController();

  TextEditingController cityTowncontroller = TextEditingController();

  TextEditingController pincodecontroller = TextEditingController();

  TextEditingController areaStreetcontroller = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    areaStreetcontroller.dispose();
    pincodecontroller.dispose();
    cityTowncontroller.dispose();
    flatBuildingcontroller.dispose();
  }

  // final AddressServices addressServices = AddressServices();
  // void changeUserAddress(String address) {
  //   if (areaStreetcontroller.text.isNotEmpty ||
  //       flatBuildingcontroller.text.isNotEmpty ||
  //       cityTowncontroller.text.isNotEmpty ||
  //       pincodecontroller.text.isNotEmpty) {
  //     if (_addressFormKey.currentState!.validate()) {
  //       addressServices.saveUserAddress(context: context, address: address);
  //     }
  //   }
  // }

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
              'Change address',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Form(
                    key: _addressFormKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextfield(
                              hintText: 'Building name / Flat no.',
                              type: TextInputType.text,
                              controller: flatBuildingcontroller,
                              maxlines: 1,
                              obsecureText: false),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextfield(
                            hintText: 'Area / Street',
                            type: TextInputType.text,
                            controller: areaStreetcontroller,
                            obsecureText: false,
                            maxlines: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextfield(
                              hintText: 'City / Town',
                              type: TextInputType.text,
                              controller: cityTowncontroller,
                              obsecureText: false),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextfield(
                              hintText: 'Pincode',
                              type: TextInputType.number,
                              controller: pincodecontroller,
                              obsecureText: false),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            GestureDetector(
              onTap: () async {
                // changeUserAddress(
                //     '${flatBuildingcontroller.text.toString()}, ${areaStreetcontroller.text.toString()}, ${cityTowncontroller.text.toString()} - ${pincodecontroller.text.toString()}');
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    child: const Center(
                        child: Text(
                      'change address',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
