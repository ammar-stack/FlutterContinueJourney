import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_shared_preference/Components/button.dart';
import 'package:login_shared_preference/Components/spacing.dart';
import 'package:login_shared_preference/Components/textfieldnew.dart';
import 'package:login_shared_preference/Pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login',style: GoogleFonts.abel(fontSize: 70,fontWeight: FontWeight.bold,color: Colors.brown),),
            VerticalS(value: 140),
            TextFieldNew(controllerr: controllerEmail,hintText: 'Enter Email',),
            VerticalS(value: 20),
            TextFieldNew(hintText: 'Enter Password', controllerr: controllerPassword),
            VerticalS(value: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: InkWell(
                onTap: (){
                  setData(controllerEmail.text.toString(), controllerPassword.text.toString());
                },
                child: ButtonNew(buttonText: 'Login',)),
            )
          ],
        ),
      ),

    );
  }
  Future<void> setData(String emaill, String passwordd) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emaill);
    await prefs.setString('password', passwordd);
    await prefs.setBool('isLogin', true);

    print('First: ${prefs.getString('email')}');
    print('Second: ${prefs.getString('password')}');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  } catch (e) {
    print('Error setting shared preferences: $e');
  }
}
}