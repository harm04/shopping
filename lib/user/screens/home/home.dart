import 'package:flutter/material.dart';
import 'package:krushit_medical/models/user_model.dart';
import 'package:krushit_medical/provider/user_provider.dart';
import 'package:krushit_medical/services/auth_services.dart';
import 'package:krushit_medical/widgets/carousel_image.dart';
import 'package:krushit_medical/widgets/change_address.dart';
import 'package:krushit_medical/widgets/deal_of_day.dart';
import 'package:krushit_medical/widgets/top_categories.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //   navigateToSearchScreen(String search) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return SearchScreen(searchQuery: search);
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).getUser;
    print(user.toJson().toString());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            flexibleSpace: Container(
              color: Colors.black,
            ),
            title: TextFormField(
              // onFieldSubmitted: navigateToSearchScreen,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Image.asset(
                    'assets/icons/ic_search.png',
                    height: 30,
                    color: Colors.grey,
                  ),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(width: 1.4))),
            ),
            actions: [
              GestureDetector(
                  onTap: () {
                    AuthServices().logout();
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        'logout',
                        style: TextStyle(color: Colors.white),
                      ))),
            ],
          )),
      body: ListView(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            color: const Color.fromARGB(255, 236, 236, 236),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_location.png',
                        height: 25,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: user.address == ''
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const ChangeAddress();
                                    }));
                                  },
                                  child: Text(
                                    'Add your address',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )
                              : Text(
                                  'Delivery to ${user.firstName} ${user.lastName} : ${user.address}',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                )),
                      user.address != ''
                          ? Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const ChangeAddress();
                                    }));
                                  },
                                  child: const Text(
                                    'Change',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  )),
                            )
                          : SizedBox()
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const TopCaregories(),
          const SizedBox(
            height: 10,
          ),
          const CrouselImages(),
          const SizedBox(
            height: 10,
          ),
          DealOfDay(),
          // Text(user.toJson().toString()),
        ],
      ),
    );
  }
}
