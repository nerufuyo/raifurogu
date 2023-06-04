// ignore_for_file: dead_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:raifurogu/app/styles/fonts.dart';
import 'package:raifurogu/app/styles/gap.dart';
import 'package:raifurogu/app/styles/pallets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  static const routeName = '/signup';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isTextVisible = true;
  bool isTextVisible2 = true;
  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thirdColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 24, right: 24, top: 80),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 36, right: 36, bottom: 28),
                child: Column(
                  children: [
                    Text(
                      'Welcome to Raifrogu!',
                      style: robotoH1,
                      textAlign: TextAlign.center,
                    ),
                    const VerticalGap10(),
                    Text(
                      'Make your notes more organized!',
                      style: robotoBody1.copyWith(
                        color: secondaryColor.withOpacity(.75),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        filled: true,
                        fillColor: fourthColor,
                        hintText: 'E-mail',
                        hintStyle: robotoBody2,
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: isTextVisible,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        filled: true,
                        fillColor: fourthColor,
                        hintText: 'Password',
                        hintStyle: robotoBody2,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isTextVisible = !isTextVisible;
                            });
                          },
                          icon: Icon(
                            isTextVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: secondaryColor.withOpacity(.75),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: isTextVisible2,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        filled: true,
                        fillColor: fourthColor,
                        hintText: 'Confirm Password',
                        hintStyle: robotoBody2,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isTextVisible2 = !isTextVisible2;
                            });
                          },
                          icon: Icon(
                            isTextVisible2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: secondaryColor.withOpacity(.75),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        signupAction();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: robotoButton.copyWith(color: fourthColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Divider(
                        color: secondaryColor.withOpacity(.75),
                        thickness: 1,
                      ),
                    ),
                    Text('Or continue with', style: robotoBody2),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Divider(
                        color: secondaryColor.withOpacity(.75),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/google.png',
                        width: 36,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/facebook.png',
                        width: 36,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/twitter.png',
                        width: 36,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Havee an account? ', style: robotoBody2),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: robotoBody2.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signupAction() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please fill all the fields!'),
        ),
      );
    } else if (!isEmailValid(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please enter a valid email!'),
        ),
      );
    } else if (passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Password must be at least 8 characters!'),
        ),
      );
    } else if (passwordController.text == confirmPasswordController.text) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .then(
            (value) => const ScaffoldMessenger(
              child: SnackBar(
                backgroundColor: Colors.green,
                content: Text('Signup success!'),
              ),
            ),
          )
          .then(
            (value) => Navigator.pop(context),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Password and Confirm Password must be same!',
          ),
        ),
      );
    }
  }
}
