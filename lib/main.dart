import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:krushit_medical/firebase_options.dart';
import 'package:krushit_medical/provider/user_provider.dart';
import 'package:krushit_medical/user/screens/auth/signup/signup.dart';
import 'package:krushit_medical/widgets/admin_bottom_bar.dart';
import 'package:krushit_medical/widgets/bottombar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Krushit nu Medical',
        theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
                color: Colors.black,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(color: Colors.white))),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                Provider.of<UserProvider>(context, listen: false).refreshUser();

                return Consumer<UserProvider>(
                  builder: (context, userProvider, _) {
                    final user = userProvider.getUser;

                    // ignore: unnecessary_null_comparison
                    if (user == null) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (user.type == 'user') {
                      return const BottomBar();
                    } else {
                      return const AdminBottomBAr();
                    }
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SignUpScreen();
          },
        ),
      ),
    );
  }
}
