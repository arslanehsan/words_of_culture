import 'dart:async';

import 'package:flutter/material.dart';
import 'package:words_of_culture/Helper/SharedPrefs.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/UtilWidgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameTextController = TextEditingController();
  // TextEditingController genderTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name = '', gender = '';

  Future<void> setProfile() async {
    String? nameData = await SharedPrefs.getStringPreference(key: 'username');

    // String? genderData = await SharedPrefs.getStringPreference(key: 'gender');

    setState(() {
      name = nameData!;
      // gender = genderData!;
    });
  }

  @override
  void initState() {
    setProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureBlackColor,
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            appBarView(
              label: 'Profile',
              function: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _singleTabView(
                    heading: 'Username',
                    text: name,
                  ),
                  // _singleTabView(
                  //   heading: 'Gender',
                  //   text: gender,
                  // ),
                ],
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _singleTabView({required String heading, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: goldenColor,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: pureWhiteColor,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
