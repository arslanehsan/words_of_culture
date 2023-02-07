import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:words_of_culture/Firebase/FirebaseDatabaseService.dart';
import 'package:words_of_culture/Objects/CategoryObject.dart';
import 'package:words_of_culture/Screens/HomeScreen.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/UtilWidgets.dart';

class SelectMoodScreen extends StatefulWidget {
  const SelectMoodScreen({super.key});

  @override
  _SelectMoodScreenState createState() => _SelectMoodScreenState();
}

class _SelectMoodScreenState extends State<SelectMoodScreen> {
  List<CategoryObject> categories = [];

  CategoryObject? selectedCategory;

  Future<void> getSelectedCategory() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    List<String>? categoryData = sharedPref.getStringList(
      'selectedMood',
    );

    setState(() {
      selectedCategory =
          CategoryObject(title: categoryData![0], value: categoryData[1]);
    });
  }

  Future<void> getCategories() async {
    List<CategoryObject> categoriesData =
        await FirebaseDatabaseService().getCategories();

    setState(() {
      categories = categoriesData;
    });
  }

  @override
  initState() {
    getSelectedCategory();
    getCategories();
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
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            appBarView(
              label: 'Select Your Mood',
              function: () => Navigator.pop(context),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (listContext, index) {
                    return _singleTabView(category: categories[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleTabView({required CategoryObject category}) {
    return GestureDetector(
      onTap: () {
        SharedPreferences.getInstance().then((sharedPref) => {
              sharedPref.setStringList(
                  'selectedMood', [category.title!, category.value!]),
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false),
            });
      },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.title!,
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
              if (selectedCategory != null)
                Icon(
                  selectedCategory!.value == category.value!
                      ? Icons.radio_button_checked_sharp
                      : Icons.radio_button_off_sharp,
                  color: pureWhiteColor,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
