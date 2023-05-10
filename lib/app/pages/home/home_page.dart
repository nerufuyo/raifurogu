import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:raifurogu/app/styles/fonts.dart';
import 'package:raifurogu/app/styles/gap.dart';
import 'package:raifurogu/app/styles/pallets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchInput = TextEditingController();
  List number = [1, 2, 3, 4, 5, 6, 7, 8, 9];

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
              itemCount: number.length,
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
                            'Note Title',
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
                        'lorem ipsum dolor sit amet consectetur adipiscing elit sed et dolore magna aliqua \n\nlorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                        style: robotoBody2,
                        maxLines: 8,
                      ),
                      const VerticalGap10(),
                      Text('Sun, 21 March 2021', style: robotoCaption),
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Notes',
            style: robotoH2.copyWith(color: secondaryColor),
          ),
          InkWell(
            onTap: () {},
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
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.325,
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
