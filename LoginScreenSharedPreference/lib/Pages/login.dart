import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_sharedpreference/Components/buttons.dart';
import 'package:theme_sharedpreference/Components/spaces.dart';
import 'package:theme_sharedpreference/Components/textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    saveData(String emaill,String passwordd) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emaill);
    await prefs.setString('password', passwordd);
    await prefs.setBool('isLogin', true);
    print("Email saved ${prefs.getString('email')}");
    print("Password saved ${prefs.getString('password')}");
  }
    return  Scaffold(
      backgroundColor: Colors.amberAccent,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalSpacing(size: 190.0),
              const Text("Login",style: TextStyle(fontSize: 55,fontWeight: FontWeight.bold,color: Colors.brown),),
              VerticalSpacing(size: 150.0),
              TextFieldd(hint: 'Enter Email',co: emailController,),
              VerticalSpacing(size: 20.0),
              TextFieldd(hint: 'Enter Password',co: passwordController,),
              VerticalSpacing(size: 50.0),
              InkWell(
                onTap: (){
                  saveData(emailController.text.trim(),passwordController.text.trim());
                  Navigator.pushNamed(context, '/home');
                },
                child: buttoncontainer(buttonText: 'Login'))
            ],
          ),
        ),
      ),
    );
  }
  
}