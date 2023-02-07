import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:words_of_culture/Helper/SharedPrefs.dart';
import 'package:words_of_culture/HomeWidget/HomeWidgetScreen.dart';
import 'package:words_of_culture/Screens/FavoritesScreen.dart';
import 'package:words_of_culture/Screens/NotificationSettingsScreen.dart';
import 'package:words_of_culture/Screens/PrivacyPolicyScreen.dart';
import 'package:words_of_culture/Screens/ProfileScreen.dart';
import 'package:words_of_culture/Screens/SelectMoodScreen.dart';
import 'package:words_of_culture/Screens/TermsOfUse.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/UtilWidgets.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsnState createState() => _SettingsnState();
}

class _SettingsnState extends State<SettingsScreen> {
  TextEditingController nameTextController = TextEditingController();
  TextEditingController genderTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> setProfile() async {
    String? name = await SharedPrefs.getStringPreference(key: 'username');

    String? gender = await SharedPrefs.getStringPreference(key: 'gender');

    nameTextController.text = name ?? '';
    genderTextController.text = gender ?? '';
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
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            appBarView(
              label: 'Settings',
              function: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    ),
                    child: _singleTabView(
                      iconData: Icons.person,
                      text: 'Profiles',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectMoodScreen(),
                      ),
                    ),
                    child: _singleTabView(
                      iconData: Icons.mood,
                      text: 'Select Mood',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeWidgetScreen(),
                      ),
                    ),
                    child: _singleTabView(
                      iconData: Icons.broadcast_on_home,
                      text: 'Home Widget',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const NotificationSettingsScreen(),
                      ),
                    ),
                    child: _singleTabView(
                      iconData: Icons.notifications_active,
                      text: 'Notification Settings',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoritesScreen(),
                      ),
                    ),
                    child: _singleTabView(
                      iconData: Icons.favorite,
                      text: 'Your Favorite',
                    ),
                  ),
                  _singleTabView(
                    iconData: Icons.share,
                    text: 'Share Words 0f culture',
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Divider(
                    thickness: 0.4,
                    color: pureWhiteColor,
                  ),
                  GestureDetector(
                    onTap: () async {
                      InAppReview inAppReview = InAppReview.instance;

                      if (await inAppReview.isAvailable()) {
                        inAppReview.requestReview();
                      }
                    },
                    child: _singleTabView(
                      iconData: Icons.star_rate,
                      text: 'Leave Us Review',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen(),
                      ),
                    ),
                    child: _singleTabView(
                      iconData: Icons.privacy_tip,
                      text: 'Privacy Policy',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsOfUseScreen(),
                      ),
                    ),
                    child: _singleTabView(
                      iconData: Icons.warning_sharp,
                      text: 'Terms Of Use',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _singleTabView({required IconData iconData, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(
            iconData,
            color: pureWhiteColor,
            size: 25,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: goldenColor,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
