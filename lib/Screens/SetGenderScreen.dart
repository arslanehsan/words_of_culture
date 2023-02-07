// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:words_of_culture/Helper/SharedPrefs.dart';
// import 'package:words_of_culture/Screens/HomeScreen.dart';
// import 'package:words_of_culture/Utils/Colors.dart';
// import 'package:words_of_culture/Utils/Global.dart';
// import 'package:words_of_culture/Utils/UtilWidgets.dart';
// import 'package:words_of_culture/Utils/validators.dart';
//
// class SetGenderScreen extends StatefulWidget {
//   @override
//   _SetGenderScreenState createState() => _SetGenderScreenState();
// }
//
// class _SetGenderScreenState extends State<SetGenderScreen> {
//   TextEditingController nameTextController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: pureBlackColor,
//       body: _bodyView(),
//     );
//   }
//
//   Widget _bodyView() {
//     return SafeArea(
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: 300,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage('images/set_gender_image.webp'),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 50.0),
//               child: Column(
//                 children: [
//                   const Text(
//                     'Which is your current gender identity?',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: goldenColor,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   ColorButtonView(
//                     label: 'Female',
//                     color: pureWhiteColor,
//                     textColor: pureBlackColor,
//                     context: context,
//                     function: () => _continue(gender: 'female'),
//                     loading: false,
//                   ),
//                   ColorButtonView(
//                     label: 'Male',
//                     color: pureWhiteColor,
//                     textColor: pureBlackColor,
//                     context: context,
//                     function: () => _continue(gender: 'Male'),
//                     loading: false,
//                   ),
//                   ColorButtonView(
//                     label: 'Other',
//                     color: pureWhiteColor,
//                     textColor: pureBlackColor,
//                     context: context,
//                     function: () => _continue(gender: 'Other'),
//                     loading: false,
//                   ),
//                 ],
//               ),
//             ),
//             InkWell(
//               onTap: () => _continue(gender: 'Prefer not to say'),
//               child: const Text(
//                 'Prefer not to say!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: pureWhiteColor,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _continue({required String gender}) {
//     SharedPrefs.setStringPreference(
//         key: 'gender', value: nameTextController.text);
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const HomeScreen(),
//       ),
//     );
//   }
// }
