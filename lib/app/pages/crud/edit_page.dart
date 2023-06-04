import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raifurogu/app/styles/fonts.dart';
import 'package:raifurogu/app/styles/gap.dart';
import 'package:raifurogu/app/styles/pallets.dart';
import 'package:raifurogu/data/models/data_model.dart';
import 'package:raifurogu/data/repositories/repository.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.id});
  static const routeName = '/edit';
  final String id;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder(
            stream: FirestoreService().getDataById(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(top: 120, left: 16, right: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: titleController
                            ..text = snapshot.data!.title,
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
                          snapshot.data!.date,
                          style: robotoBody2.copyWith(
                            color: secondaryColor.withOpacity(.75),
                          ),
                        ),
                        const VerticalGap10(),
                        TextField(
                          controller: descriptionController
                            ..text = snapshot.data!.description,
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
                );
              }
            },
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
                await FirestoreService()
                    .updateData(
                      widget.id,
                      titleController.text,
                      descriptionController.text,
                    )
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
                  style: robotoH5.copyWith(
                    color: fourthColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
