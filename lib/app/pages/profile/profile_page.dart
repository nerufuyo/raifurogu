import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:raifurogu/app/styles/fonts.dart';
import 'package:raifurogu/app/styles/pallets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://images.pexels.com/photos/5378700/pexels-photo-5378700.jpeg',
                      imageBuilder: (context, imageProvider) => Container(
                        width: 80,
                        height: 80,
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
                        width: 80,
                        height: 80,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder(
                          stream: FirebaseAuth.instance.userChanges(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                '${snapshot.data?.displayName}',
                                style: robotoBody1.copyWith(
                                  color: secondaryColor,
                                ),
                              );
                            } else if (snapshot.data?.displayName == null) {
                              return Text(
                                'No Name',
                                style: robotoBody1.copyWith(
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
                            } else {
                              return const Text('Loading...');
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
