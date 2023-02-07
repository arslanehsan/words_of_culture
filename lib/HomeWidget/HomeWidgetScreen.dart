import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';
import 'package:words_of_culture/Firebase/FirebaseDatabaseService.dart';
import 'package:words_of_culture/HomeWidget/HomeWidgetHelper.dart';
import 'package:words_of_culture/Objects/QuotesObject.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/Global.dart';
import 'package:workmanager/workmanager.dart';

class HomeWidgetScreen extends StatefulWidget {
  @override
  _HomeWidgetScreenState createState() => _HomeWidgetScreenState();
}

class _HomeWidgetScreenState extends State<HomeWidgetScreen> {
  String titleText = 'Title', messageText = 'Message Text';

  Future<List<bool?>?> _sendData() async {
    try {
      return Future.wait([
        HomeWidget.saveWidgetData<String>('title', titleText),
        HomeWidget.saveWidgetData<String>('message', messageText),
      ]);
    } on PlatformException catch (exception) {
      debugPrint('Error Sending Data. $exception');
    }
    return null;
  }

  Future<Future<bool?>?> _updateWidget() async {
    try {
      return HomeWidget.updateWidget(
          name: 'HomeWidgetExampleProvider', iOSName: 'HomeWidgetExample');
    } on PlatformException catch (exception) {
      debugPrint('Error Updating Widget. $exception');
    }
    return null;
  }

  Future<Future<List<String?>>?> _loadData() async {
    try {
      print('m called');
      return Future.wait([
        HomeWidget.getWidgetData<String>('title', defaultValue: 'Default Title')
            .then((value) {
          setState(() {
            titleText = value!;
          });
        }),
        HomeWidget.getWidgetData<String>('message',
                defaultValue: 'Default Message')
            .then((value) {
          setState(() {
            messageText = value!;
          });
        }),
      ]);
    } on PlatformException catch (exception) {
      debugPrint('Error Getting Data. $exception');
    }
    return null;
  }

  Future<void> _sendAndUpdate() async {
    await _sendData();
    await _updateWidget();
  }

  void _checkForWidgetLaunch() {
    HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
  }

  void _launchedFromWidget(Uri? uri) {
    if (uri != null) {
      showDialog(
          context: context,
          builder: (buildContext) => AlertDialog(
                title: const Text('App started from HomeScreenWidget'),
                content: Text('Here is the URI: $uri'),
              ));
    }
  }

  void _startBackgroundUpdate() {
    Workmanager().registerPeriodicTask('1', 'widgetBackgroundUpdate',
        frequency: Duration(minutes: 15));
  }

  void _stopBackgroundUpdate() {
    Workmanager().cancelByUniqueName('1');
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    getQuotes();
    HomeWidget.setAppGroupId('YOUR_GROUP_ID');
    HomeWidget.registerBackgroundCallback(backgroundCallback);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _checkForWidgetLaunch();
  //   HomeWidget.widgetClicked.listen(_launchedFromWidget);
  // }

  // @override
  // void dispose() {
  //   _titleController.dispose();
  //   _messageController.dispose();
  //   super.dispose();
  // }

  List<QuotesObject> quotes = [];

  Future<void> getQuotes() async {
    List<QuotesObject> quotesData = await FirebaseDatabaseService().getQuotes();
    setState(() {
      quotes = quotesData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: goldenColor,
      body: _bodyView(),
    );
  }

  Widget _appBarView({required String label, required Function function}) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            const Icon(
              Icons.keyboard_double_arrow_left,
              color: pureBlackColor,
              size: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: const TextStyle(
                color: pureBlackColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bodyView() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appBarView(
              label: 'Home Widget',
              function: () => Navigator.pop(context),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 210,
              decoration: BoxDecoration(
                color: pureBlackColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      titleText,
                      style: const TextStyle(
                        color: goldenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      messageText,
                      style: const TextStyle(
                        color: pureWhiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Select Your Quote',
              style: TextStyle(
                color: pureBlackColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: _quotesView(),
            ),
            _expendedButton(label: 'Update Widget', function: _sendAndUpdate),

            // _expendedButton(label: 'Load Data', function: _loadData),

            // ElevatedButton(
            //   onPressed: _checkForWidgetLaunch,
            //   child: Text('Check For Widget Launch'),
            // ),
            // if (Platform.isAndroid)
            //   ElevatedButton(
            //     onPressed: _startBackgroundUpdate,
            //     child: Text('Update in background'),
            //   ),
            // if (Platform.isAndroid)
            //   ElevatedButton(
            //     onPressed: _stopBackgroundUpdate,
            //     child: Text('Stop updating in background'),
            //   )
          ],
        ),
      ),
    );
  }

  Widget _quotesView() {
    return Container(
      decoration: BoxDecoration(
        color: pureBlackColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
          itemCount: quotes.length,
          itemBuilder: (listContext, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  titleText = quotes[index].author != 'null'
                      ? quotes[index].author!
                      : appName;
                  messageText = quotes[index].text!;
                });
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quotes[index].text!,
                      style: const TextStyle(
                        color: pureWhiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (quotes[index].author != 'null')
                      Text(
                        quotes[index].author!,
                        style: const TextStyle(
                          color: goldenColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Divider(
                      height: 5,
                      thickness: 1,
                      color: pureWhiteColor,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _expendedButton({required String label, required Function function}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(goldenColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ))),
        onPressed: () => function(),
        child: Text(label),
      ),
    );
  }
}
