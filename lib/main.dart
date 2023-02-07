import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:words_of_culture/HomeWidget/HomeWidgetHelper.dart';
import 'package:words_of_culture/Screens/AdminWeb/AdminLoginScreen.dart';
import 'package:words_of_culture/Screens/SplashScreen.dart';
import 'package:words_of_culture/Utils/Global.dart';
import 'package:workmanager/workmanager.dart';

Future<void> main() async {
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBlNOjWM9lkhVF2B2ZPyxVJPpuszjrudXA",
        databaseURL: "https://words-of-culture-default-rtdb.firebaseio.com",
        projectId: "words-of-culture",
        storageBucket: "words-of-culture.appspot.com",
        messagingSenderId: "876021707989",
        appId: "1:876021707989:web:9233689ef02db84ae49e5c",
      ),
    );

    setPathUrlStrategy();
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: kIsWeb
          // ? MainScreen(
          //     subScreen: QuotesScreen(),
          //   )
          ? AdminLoginScreen()
          : SplashScreen(),
    );
  }
}

// import 'dart:async';
// import 'dart:io';
// import 'dart:math';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:home_widget/home_widget.dart';
// import 'package:workmanager/workmanager.dart';
//
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
//   runApp(MaterialApp(home: MyApp()));
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     HomeWidget.setAppGroupId('YOUR_GROUP_ID');
//     HomeWidget.registerBackgroundCallback(backgroundCallback);
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _checkForWidgetLaunch();
//     HomeWidget.widgetClicked.listen(_launchedFromWidget);
//   }
//
//   @override
//   void dispose() {
//     _titleController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }
//
//   Future<List<bool?>?> _sendData() async {
//     try {
//       return Future.wait([
//         HomeWidget.saveWidgetData<String>('title', _titleController.text),
//         HomeWidget.saveWidgetData<String>('message', _messageController.text),
//       ]);
//     } on PlatformException catch (exception) {
//       debugPrint('Error Sending Data. $exception');
//     }
//     return null;
//   }
//
//   Future<Future<bool?>?> _updateWidget() async {
//     try {
//       return HomeWidget.updateWidget(
//           name: 'HomeWidgetExampleProvider', iOSName: 'HomeWidgetExample');
//     } on PlatformException catch (exception) {
//       debugPrint('Error Updating Widget. $exception');
//     }
//     return null;
//   }
//
//   Future<Future<List<String?>>?> _loadData() async {
//     try {
//       return Future.wait([
//         HomeWidget.getWidgetData<String>('title', defaultValue: 'Default Title')
//             .then((value) => _titleController.text = value!),
//         HomeWidget.getWidgetData<String>('message',
//                 defaultValue: 'Default Message')
//             .then((value) => _messageController.text = value!),
//       ]);
//     } on PlatformException catch (exception) {
//       debugPrint('Error Getting Data. $exception');
//     }
//     return null;
//   }
//
//   Future<void> _sendAndUpdate() async {
//     await _sendData();
//     await _updateWidget();
//   }
//
//   void _checkForWidgetLaunch() {
//     HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
//   }
//
//   void _launchedFromWidget(Uri? uri) {
//     if (uri != null) {
//       showDialog(
//           context: context,
//           builder: (buildContext) => AlertDialog(
//                 title: Text('App started from HomeScreenWidget'),
//                 content: Text('Here is the URI: $uri'),
//               ));
//     }
//   }
//
//   void _startBackgroundUpdate() {
//     Workmanager().registerPeriodicTask('1', 'widgetBackgroundUpdate',
//         frequency: Duration(minutes: 15));
//   }
//
//   void _stopBackgroundUpdate() {
//     Workmanager().cancelByUniqueName('1');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HomeWidget Example'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Title',
//               ),
//               controller: _titleController,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Body',
//               ),
//               controller: _messageController,
//             ),
//             ElevatedButton(
//               onPressed: _sendAndUpdate,
//               child: Text('Send Data to Widget'),
//             ),
//             ElevatedButton(
//               onPressed: _loadData,
//               child: Text('Load Data'),
//             ),
//             ElevatedButton(
//               onPressed: _checkForWidgetLaunch,
//               child: Text('Check For Widget Launch'),
//             ),
//             if (Platform.isAndroid)
//               ElevatedButton(
//                 onPressed: _startBackgroundUpdate,
//                 child: Text('Update in background'),
//               ),
//             if (Platform.isAndroid)
//               ElevatedButton(
//                 onPressed: _stopBackgroundUpdate,
//                 child: Text('Stop updating in background'),
//               )
//           ],
//         ),
//       ),
//     );
//   }
// }
