
import 'package:flutter/material.dart';
import 'package:krushit_medical/widgets/custom_textfield.dart';


class Address extends StatefulWidget {
  final String totalAmount;
  const Address({super.key, required this.totalAmount});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController flatBuildingcontroller = TextEditingController();

  TextEditingController cityTowncontroller = TextEditingController();

  TextEditingController pincodecontroller = TextEditingController();

  TextEditingController areaStreetcontroller = TextEditingController();

  // List<PaymentItem> paymentItems = [];
  // final AddressServices addressServices = AddressServices();
  String addressTOBeUsed = "";

  final _addressFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    areaStreetcontroller.dispose();
    pincodecontroller.dispose();
    cityTowncontroller.dispose();
    flatBuildingcontroller.dispose();
  }

  // onGpayresult()async {
  //   if (Provider.of<UserProvider>(context, listen: false)
  //       .user
  //       .address
  //       .isEmpty) {
  //   addressServices.saveUserAddress(
  //         context: context, address: addressTOBeUsed);
  //   }

  // await  addressServices.placeOrder(
  //       context: context,
  //       address: addressTOBeUsed,
  //       totalSum: double.parse(widget.totalAmount));
  // }

  payPressed(String addressFromProvider) {
    addressTOBeUsed = '';

    bool isForm = flatBuildingcontroller.text.isNotEmpty ||
        areaStreetcontroller.text.isNotEmpty ||
        cityTowncontroller.text.isNotEmpty ||
        pincodecontroller.text.isNotEmpty;
    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressTOBeUsed =
            '${flatBuildingcontroller.text}, ${areaStreetcontroller.text}, ${cityTowncontroller.text} - ${pincodecontroller.text}';
      } else {
        throw Exception('Please enter all the fields');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressTOBeUsed = addressFromProvider;
    } else {
      // showSnackbar('Error', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // var address = Provider.of<UserProvider>(context).user.address;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            flexibleSpace: Container(
              color: Colors.black,
            ),
            title: const Text(
              'Address',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                // if (address.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
                          height: 45,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                             ' address',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Continue with this address?'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Center(child: Text('OR')),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
              ],
            ),
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
                            maxlength:  30,
                              hintText: 'Building name / Flat no.',
                              type: TextInputType.text,
                              controller: flatBuildingcontroller,
                              maxlines: 1,
                              obsecureText: false),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextfield(
                            maxlength: 30,
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
                            maxlength: 10,
                              hintText: 'City / Town',
                              type: TextInputType.text,
                              controller: cityTowncontroller,
                              obsecureText: false),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextfield(
                            maxlength: 6,
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
                // await payPressed(address);
                // await onGpayresult();
                // Navigator.push(
                //   // ignore: use_build_context_synchronously
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const MyOrderScreen();
                //     },
                //   ),
                // );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Container(
                    height: 40,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black),
                    child: const Center(child: Text('Buy now',style: TextStyle(color: Colors.white),)),
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
