import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:work_os/screen/auth/login.dart';
import 'package:work_os/screen/task_screen.dart';
import 'package:work_os/user_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          print('error value ${snapshot.error.toString()}');
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Center(
                  child: Text('error has occured'),
                ),
              ),
            ),
          );
          // return MaterialApp(
          //   debugShowCheckedModeBanner: false,
          //   title: 'Flutter workos',
          //   theme: ThemeData(
          //     scaffoldBackgroundColor: const Color(0xFFEDE7DC),
          //     primarySwatch: Colors.blue,
          //   ),
          //   home: const Login(),
          // );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter workos',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFEDE7DC),
            primarySwatch: Colors.blue,
          ),
          home: const UserState(),
        );
      },
    );
  }
}
