import 'package:flutter/material.dart';
import 'package:words_of_culture/Helper/SharedPrefs.dart';
import 'package:words_of_culture/Screens/HomeScreen.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/UtilWidgets.dart';
import 'package:words_of_culture/Utils/validators.dart';

class SetNameScreen extends StatefulWidget {
  @override
  _SetNameScreenState createState() => _SetNameScreenState();
}

class _SetNameScreenState extends State<SetNameScreen> {
  TextEditingController nameTextController = TextEditingController();
  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();

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
        child: Form(
          key: _nameFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/set_name_image.jpeg'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Column(
                        children: [
                          const Text(
                            'What is your name?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: goldenColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: dullFontColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                controller: nameTextController,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Your Name',
                                  // labelText: 'Your Name',
                                ),
                                validator: (name) =>
                                    requiredField(name, 'User Name'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ColorButtonView(
                  label: 'Continue',
                  color: dullFontColor,
                  textColor: pureBlackColor,
                  context: context,
                  function: _continue,
                  loading: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _continue() {
    if (_nameFormKey.currentState!.validate()) {
      SharedPrefs.setStringPreference(
          key: 'username', value: nameTextController.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }
}
