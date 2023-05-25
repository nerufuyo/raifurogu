import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raifurogu/app/styles/fonts.dart';
import 'package:raifurogu/app/styles/gap.dart';
import 'package:raifurogu/app/styles/pallets.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});
  static const routeName = '/edit';

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final String formattedDate =
      DateFormat('EEEE, d MMMM y').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: robotoH1.copyWith(
                        color: secondaryColor.withOpacity(.25),
                      ),
                    ),
                    style: robotoH1,
                  ),
                  Text(
                    formattedDate,
                    style: robotoBody2.copyWith(
                      color: secondaryColor.withOpacity(.75),
                    ),
                  ),
                  const VerticalGap10(),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      hintStyle: robotoSubtitle1.copyWith(
                        color: secondaryColor.withOpacity(.25),
                      ),
                    ),
                    style: robotoSubtitle1,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: fourthColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: fourthColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.edit_rounded),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            left: 16,
            right: 16,
            child: InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Save',
                  textAlign: TextAlign.center,
                  style: robotoH5.copyWith(
                    color: fourthColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
