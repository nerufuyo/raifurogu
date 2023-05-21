import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:raifurogu/app/pages/home/home_page.dart';
import 'package:raifurogu/app/styles/fonts.dart';
import 'package:raifurogu/app/styles/gap.dart';
import 'package:raifurogu/app/styles/pallets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isTextVisible = true;
  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thirdColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 24, right: 24, top: 80),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 44, right: 44, bottom: 28),
                child: Column(
                  children: [
                    Text('Hello Again!', style: robotoH1),
                    const VerticalGap10(),
                    Text(
                      'Welcome back you\'ve been missed!',
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
              TextField(
                controller: emailInput,
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
              const SizedBox(height: 20),
              TextField(
                controller: passwordInput,
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
                      isTextVisible ? Icons.visibility : Icons.visibility_off,
                      color: secondaryColor.withOpacity(.75),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text('Forgot Password?', style: robotoBody2),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  loginAction();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: robotoButton.copyWith(color: fourthColor),
                    ),
                  ),
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
                    Text('Don\'t have an account? ', style: robotoBody2),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Sign Up',
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

  void loginAction() {
    if (emailInput.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Email cannot be empty'),
        ),
      );
    } else if (!isEmailValid(emailInput.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Email is not valid'),
        ),
      );
    } else if (passwordInput.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Password cannot be empty'),
        ),
      );
    } else {
      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailInput.text, password: passwordInput.text)
            .then((value) => Navigator.pushNamed(context, HomePage.routeName));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No user found for that email.'),
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong password provided for that user.'),
            ),
          );
        }
      }
    }
  }
}
