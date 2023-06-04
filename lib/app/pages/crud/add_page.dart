import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raifurogu/app/styles/fonts.dart';
import 'package:raifurogu/app/styles/gap.dart';
import 'package:raifurogu/app/styles/pallets.dart';
import 'package:raifurogu/data/models/data_model.dart';
import 'package:raifurogu/data/repositories/repository.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});
  static const String routeName = '/add';

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final String formattedDate =
      DateFormat('EEEE, d MMMM y').format(DateTime.now());

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 120, left: 16, right: 16),
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
            top: 66,
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
                final user = FirebaseAuth.instance.currentUser;
                final firestore = await FirebaseFirestore.instance
                    .collection('counters')
                    .doc('data')
                    .get()
                    .then(
                        (doc) => doc.exists ? doc.data()!['value'] as int : 0);

                if (user == null) {
                  return;
                }

                final data = DataModel(
                  id: (firestore + 1).toString(),
                  userId: user.uid,
                  title: titleController.text,
                  description: descriptionController.text,
                  date: formattedDate,
                );

                FirestoreService()
                    .addData(data)
                    .then((value) => Navigator.pop(context));
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
