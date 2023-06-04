import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:raifurogu/app/styles/fonts.dart';
import 'package:raifurogu/app/styles/gap.dart';
import 'package:raifurogu/app/styles/pallets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isSettingOpen = false;
  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: secondaryColor,
          ),
        ),
        title: Text(
          'My Account',
          style: robotoH3.copyWith(color: secondaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isSettingOpen = !isSettingOpen;
                  nameController.clear();
                  emailController.clear();
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://images.pexels.com/photos/5378700/pexels-photo-5378700.jpeg',
                      imageBuilder: (context, imageProvider) => Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.colorBurn,
                            ),
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/default_profile.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.colorBurn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.75,
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder(
                            stream: FirebaseAuth.instance.userChanges(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.displayName != null) {
                                  return Text(
                                    snapshot.data!.displayName.toString(),
                                    style: robotoH4.copyWith(
                                      color: secondaryColor,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    'Name not set',
                                    style: robotoH4.copyWith(
                                      color: secondaryColor,
                                    ),
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return Text(
                                  '${snapshot.error}',
                                  style: robotoH4.copyWith(
                                    color: secondaryColor,
                                  ),
                                );
                              } else {
                                return const Text('Loading...');
                              }
                            },
                          ),
                          StreamBuilder(
                            stream: FirebaseAuth.instance.userChanges(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!.email.toString(),
                                  style: robotoBody1.copyWith(
                                    color: secondaryColor,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  '${snapshot.error}',
                                  style: robotoH4.copyWith(
                                    color: secondaryColor,
                                  ),
                                );
                              } else {
                                return const Text('Loading...');
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                      height: 72,
                      child: Icon(
                        Icons.edit,
                        color: primaryColor,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const VerticalGap10(),
            if (isSettingOpen)
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        filled: true,
                        fillColor: fourthColor,
                        hintText: 'Your name',
                        hintStyle: robotoBody1.copyWith(
                          color: secondaryColor.withOpacity(.5),
                        ),
                        isDense: true,
                      ),
                    ),
                    const VerticalGap10(),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        filled: true,
                        fillColor: fourthColor,
                        hintText: 'Your e-mail',
                        hintStyle: robotoBody1.copyWith(
                          color: secondaryColor.withOpacity(.5),
                        ),
                        isDense: true,
                      ),
                    ),
                    const VerticalGap10(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if (nameController.text.isNotEmpty) {
                              FirebaseAuth.instance.currentUser!
                                  .updateDisplayName(
                                      nameController.text.toString());
                            }
                            if (emailController.text.isNotEmpty &&
                                emailController.text.contains('@')) {
                              FirebaseAuth.instance.currentUser!
                                  .updateEmail(emailController.text.toString());
                            }
                            setState(() {
                              nameController.clear();
                              emailController.clear();
                              isSettingOpen = false;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.25,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                'Save',
                                style: robotoH4.copyWith(
                                  color: fourthColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              nameController.clear();
                              emailController.clear();
                              isSettingOpen = false;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.25,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: secondaryColor,
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: robotoH4.copyWith(
                                  color: fourthColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      'Sign Out',
                      style: robotoH4.copyWith(
                        color: fourthColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
