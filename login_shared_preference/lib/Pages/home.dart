import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_shared_preference/Components/button.dart';
import 'package:login_shared_preference/Components/spacing.dart';
import 'package:login_shared_preference/Pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

   String? emailll;
   String? passworddd;
Future<List<String>> getData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  emailll = await prefs.getString('email');
  passworddd = prefs.getString('password');
  return [emailll.toString(),passworddd.toString()];
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: FutureBuilder(
        future: getData(), 
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasData){
            return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('UserName: ${snapshot.data?[0].toString() ?? 'abc'}',style: GoogleFonts.abel(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.brown),),
            Text('Password: ${snapshot.data?[1].toString() ?? 'abc'}',style: GoogleFonts.abel(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.brown),),
            VerticalS(value: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: InkWell(
                onTap: (){
                  logoutMethod();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                child: ButtonNew(buttonText: 'Logout')),
            )
          ],
        ),
      );
          }
          else{
            return Center(child: Text(snapshot.error.toString()),);
          }
        })
    );
  }
  Future<void> logoutMethod() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', false);
  }
}