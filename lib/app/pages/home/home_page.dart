import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:raifurogu/app/pages/edit/edit_page.dart';
import 'package:raifurogu/app/pages/profile/profile_page.dart';
import 'package:raifurogu/app/styles/fonts.dart';
import 'package:raifurogu/app/styles/gap.dart';
import 'package:raifurogu/app/styles/pallets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final searchInput = TextEditingController();
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    getLocalData();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getLocalData();
    }
  }

  Future getLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String dataString = prefs.getString('data') ?? '[]';
    setState(() {
      data = json.decode(dataString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: _appBarWidget(),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.2,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: fourthColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'test',
                            style: robotoH4,
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.more_horiz,
                              color: secondaryColor,
                            ),
                          )
                        ],
                      ),
                      const VerticalGap10(),
                      Text(
                        'test',
                        style: robotoBody2,
                        maxLines: 8,
                      ),
                      const VerticalGap10(),
                      Text('test', style: robotoCaption),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: _floatingButtonWidget(context),
      ),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Notes',
            style: robotoH2.copyWith(color: secondaryColor),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ProfilePage.routeName);
            },
            child: CachedNetworkImage(
              imageUrl:
                  'https://images.pexels.com/photos/5378700/pexels-photo-5378700.jpeg',
              imageBuilder: (context, imageProvider) => Container(
                width: 44,
                height: 44,
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
                width: 44,
                height: 44,
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
          )
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: searchInput,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                borderSide: BorderSide.none,
              ),
              fillColor: fourthColor,
              filled: true,
              hintText: 'Search notes...',
              isDense: true,
              prefixIcon: Icon(Icons.search, size: 24),
            ),
          ),
        ),
      ),
    );
  }

  InkWell _floatingButtonWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EditPage.routeName);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3.25,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(36),
        ),
        padding: const EdgeInsets.only(
          left: 8,
          right: 16,
          top: 8,
          bottom: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: fourthColor,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.add, color: secondaryColor),
            ),
            Text(
              'Add Note',
              style: robotoButton.copyWith(color: fourthColor),
            ),
          ],
        ),
      ),
    );
  }
}
