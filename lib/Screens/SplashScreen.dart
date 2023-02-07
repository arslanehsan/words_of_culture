import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:words_of_culture/Helper/SharedPrefs.dart';
import 'package:words_of_culture/Screens/HomeScreen.dart';
import 'package:words_of_culture/Screens/SetNameScreen.dart';
import 'package:words_of_culture/Utils/Colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> openScreen() async {
    final AudioCache player = AudioCache();

    player.play('splash_tone.mp3');
    await SharedPrefs.getStringPreference(key: 'username')
        .then((username) async {
      if (username != null) {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        });

        // await SharedPrefs.getStringPreference(key: 'gender')
        //     .then((gender) async {
        //   if (gender != null) {
        //
        //   } else {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => SetGenderScreen(),
        //       ),
        //     );
        //   }
        // });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SetNameScreen(),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    openScreen();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/app_icon.png'),
                ),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 50.0),
            //   child: Text(
            //     'Take a moment each day to read positive and inspiring quotes and review your brain to reward optimism',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       color: goldenColor,
            //       fontSize: 15,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: ColorButtonView(
            //     label: 'Please Wait....',
            //     color: dullFontColor,
            //     textColor: pureBlackColor,
            //     context: context,
            //     function: () {},
            //     // function: () => Navigator.pushReplacement(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //     builder: (context) => SetNameScreen(),
            //     //   ),
            //     // ),
            //     loading: false,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
