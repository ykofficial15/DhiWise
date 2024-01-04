import 'package:dhiwise/Constants/exception.dart';
import 'package:dhiwise/Controllers/loginController.dart';
import 'package:dhiwise/Controllers/persistentLogin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/colors.dart';
import 'bottomNav.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 200,
              ),
              Text(
                'LOGIN',
                style: TextStyle(
                    fontSize: 35,
                    color: AppColors.safed,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Unlock the dreams...',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.safed,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.safed),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.safed),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.safed),
                  ),
                ),
                style: TextStyle(color: AppColors.safed),
                cursorColor: AppColors.safed,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.safed),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.safed),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.safed),
                  ),
                ),
                style: TextStyle(color: AppColors.safed),
                cursorColor: AppColors.safed,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();
                  try {
                    await Provider.of<LoginProvider>(
                      context,
                      listen: false,
                    ).login(email, password);
                    // If login successful, navigate to next page
                    final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    authProvider.login();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigation()));
                    SuccessToast.show(message: "Logged In Successfully");
                  } catch (e) {
                    // Handle error - show error message
                    DeniedToast.show(message: "Error: ${e.toString()}");
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
