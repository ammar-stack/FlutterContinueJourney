import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_sharedpreference/Components/spaces.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? email;
  String? password;

    Future<void> getData() async{
       SharedPreferences prefs = await SharedPreferences.getInstance();
       final emailReceived = prefs.getString('email') ;
       final passwordReceived = prefs.getString('password') ;
       print("Email : $emailReceived");
       print("Password : $passwordReceived");
       setState(() {
         email = emailReceived ?? "No Email Found";
         password = passwordReceived ?? "No password found";
       });
    }
    @override
  void initState() {
      super.initState();
      getData();
  }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(email ?? "No Email Found",style:const TextStyle(fontSize: 25),),
            VerticalSpacing(size: 40.0),
            Text(password ?? "No Password Saved",style:const TextStyle(fontSize: 25),)
          ],
        ),
      ),
    );
  }
}