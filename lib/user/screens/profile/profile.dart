import 'package:flutter/material.dart';
import 'package:krushit_medical/provider/user_provider.dart';
import 'package:krushit_medical/services/auth_services.dart';
import 'package:krushit_medical/widgets/admin_bottom_bar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    void signOut() {
      AuthServices().logout();
    }

    void myDialoug() {
      showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/ic_sad.png',
                        height: 50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'You wanna really leave us?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () {
                                signOut();
                                Navigator.pop(context);
                              },
                              child: const Text('Logout'))
                        ],
                      )
                    ],
                  ),
                ),
              ));
    }

    final user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello, ${user.firstName}',
          style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w400),
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          const Divider(),
          GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return const MyOrderScreen();
              // }));
            },
            child: ListTile(
              leading: Image.asset(
                'assets/icons/ic_my_orders.png',
                height: 30,
              ),
              title: const Text('My Orders'),
            ),
          ),
          const Divider(
            thickness: 3,
          ),
          ListTile(
            leading: Image.asset(
              'assets/icons/ic_my_details.png',
              height: 30,
            ),
            title: const Text('My Details'),
          ),
          const Divider(),
          ListTile(
            leading: Image.asset(
              'assets/icons/ic_my_address.png',
              height: 30,
            ),
            title: const Text('Address Book'),
          ),
          const Divider(
            thickness: 3,
          ),
          ListTile(
            leading: Image.asset(
              'assets/icons/ic_faqs.png',
              height: 30,
            ),
            title: const Text('FAQS'),
          ),
          const Divider(),
          ListTile(
            leading: Image.asset(
              'assets/icons/ic_help_center.png',
              height: 30,
            ),
            title: const Text('Help Center'),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminBottomBAr();
              }));
            },
            child: ListTile(
              leading: Image.asset(
                'assets/icons/ic_seller.png',
                height: 30,
              ),
              title: const Text('Switch to Seller'),
            ),
          ),
          const Divider(
            thickness: 3,
          ),
          GestureDetector(
            onTap: () {
              myDialoug();
            },
            child: ListTile(
              leading: Image.asset(
                'assets/icons/ic_logout.png',
                height: 30,
                color: const Color.fromARGB(255, 230, 2, 2),
              ),
              title: const Text(
                'Logout',
                style: TextStyle(color: Color.fromARGB(255, 230, 2, 2)),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
