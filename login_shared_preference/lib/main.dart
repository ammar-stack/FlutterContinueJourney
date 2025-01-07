import 'package:flutter/material.dart';
import 'package:login_shared_preference/Pages/home.dart';
import 'package:login_shared_preference/Pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
bool? pagenumber;
  // This widget is the root of your application.
  Future<bool?> verifyPage()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pagenumber = prefs.getBool('isLogin') ?? false;
    return pagenumber;
  }
  @override
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: verifyPage(), 
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(snapshot.hasData){
          return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: snapshot.data == true ?  HomeScreen(): const LoginScreen(),
    );
        }
        else{
          return Center(child: Text(snapshot.error.toString()),);
        }
      });
  }
}
