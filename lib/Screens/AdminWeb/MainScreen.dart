import 'package:flutter/material.dart';
import 'package:words_of_culture/Screens/AdminWeb/Categories/CategoriesScreen.dart';
import 'package:words_of_culture/Screens/AdminWeb/Quote/QuotesScreen.dart';
import 'package:words_of_culture/Utils/Colors.dart';

class MainScreen extends StatefulWidget {
  final Widget subScreen;

  const MainScreen({required this.subScreen});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: pureWhiteColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sideBarView(),
          Column(
            children: [
              Expanded(
                child: _selectedWindowView(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _selectedWindowView() {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      decoration: const BoxDecoration(
        color: goldenColor,
      ),
      padding: const EdgeInsets.all(20),
      child: widget.subScreen,
      // child: selectedIndex == 0
      //     ? CourierScreen()
      //     : selectedIndex == 0.1
      //         ? AddNewCourierScreen()
      //         : const SizedBox(),
    );
  }

  Widget _sideBarView() {
    return Container(
      width: 250,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: pureBlackColor,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Image.asset('images/app_icon.png'),
          ),
          const SizedBox(
            height: 20,
          ),

          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  subScreen: CategoriesScreen(),
                ),
              ),
            ),
            child: _singleSideMenuTab(title: 'Categories'),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  subScreen: QuotesScreen(),
                ),
              ),
            ),
            child: _singleSideMenuTab(title: 'Quotes'),
          ),
          // _singleSideMenuTab(title: 'Total Deliveries'),
          // GestureDetector(
          //     onTap: () => {
          //           FirebaseAuth.instance.signOut(),
          //           Navigator.of(context).pushAndRemoveUntil(
          //               MaterialPageRoute(
          //                 builder: (context) => LoginScreen(),
          //               ),
          //               (route) => false),
          //         },
          //     child: _singleSideMenuTab(title: 'Logout')),
        ],
      ),
    );
  }

  Widget _singleSideMenuTab({required String title}) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: pureWhiteColor,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: pureWhiteColor,
            size: 14,
          ),
        ],
      ),
    );
  }
}
