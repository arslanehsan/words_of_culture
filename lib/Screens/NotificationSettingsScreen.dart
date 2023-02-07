import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/UtilWidgets.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureBlackColor,
      body: _bodyView(),
    );
  }

  String notificationTiming = '1 Times';

  void initiateValue() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();

    String? value = sharedpref.getString('notifications');
    if (value != null) {
      setState(() {
        notificationTiming = value;
      });
    }
  }

  @override
  void initState() {
    initiateValue();
    super.initState();
  }

  Widget _bodyView() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            appBarView(
              label: 'Notification Settings',
              function: () => Navigator.pop(context),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                const Text(
                  'How Many Time You Want notification in a day?',
                  style: TextStyle(
                    color: goldenColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                  decoration: BoxDecoration(
                    color: pureWhiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButton<String>(
                    value: notificationTiming,
                    // style: const TextStyle(
                    //   color: pureWhiteColor,
                    //   fontSize: 17,
                    //   fontWeight: FontWeight.w600,
                    // ),
                    items: <String>[
                      '1 Times',
                      '2 Times',
                      '3 Times',
                      '4 Times',
                      '5 Times'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          // style: const TextStyle(
                          //   color: pureWhiteColor,
                          //   fontSize: 17,
                          //   fontWeight: FontWeight.w600,
                          // ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) async {
                      setState(() {
                        notificationTiming = value!;
                      });

                      SharedPreferences sharedpref =
                          await SharedPreferences.getInstance();

                      sharedpref.setString('notifications', notificationTiming);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
