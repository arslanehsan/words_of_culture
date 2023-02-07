import 'package:flutter/material.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/UtilWidgets.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  String privacyText =
      'The Application is supported via advertising, and collects data to help the Application serve and display ads. We may work with analytics companies to help us understand how the Application is being used, such as the frequency and duration of usage. We work with advertisers and third party advertising networks, who need to know how you interact with the Application and your device, which helps us keep the cost of the Application low or free. Advertisers and advertising networks may access and use the information made available by you or collected by the Application, including the unique device or advertising identifier associated with your device and your precise location information, in order to help analyze and serve targeted advertising on the Application and elsewhere (including third-party sites and applications). We encourage you to review your device and Application settings to ensure they are consistent with your preferences, including with respect to the collection and use of such information. We may also share encrypted versions of information we have collected in order to enable our partners to append other available information about you for analysis or advertising-related use (on or off the Application, including third-party sites and applications). You may be able to stop further collection of certain information by the Application by updating your applicable device or Application settings, or you may uninstall the Application.';

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
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            appBarView(
              label: 'Privacy Policy',
              function: () => Navigator.pop(context),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Text(
                    privacyText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: pureWhiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
