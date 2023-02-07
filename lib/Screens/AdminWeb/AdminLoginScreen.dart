import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:words_of_culture/Firebase/AdminFirebaseDatabaseService.dart';
import 'package:words_of_culture/Objects/AdminObject.dart';
import 'package:words_of_culture/Objects/LoginUserObject.dart';
import 'package:words_of_culture/Screens/AdminWeb/MainScreen.dart';
import 'package:words_of_culture/Screens/AdminWeb/Quote/QuotesScreen.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/Global.dart';
import 'package:words_of_culture/Utils/InputDecorations.dart';
import 'package:words_of_culture/Utils/validators.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  LoginUserObject loginUserObject = LoginUserObject(
      email: '',
      uid: '',
      password: '',
      phoneNumber: '',
      country: '',
      keepLogin: false);
  TextEditingController emailEdtController = TextEditingController();
  TextEditingController passwordEdtController = TextEditingController();
  bool showPas = true, buttonLoading = false;

  AdminObject? adminObject;

  Future<void> getAdminObject() async {
    AdminObject? adminData = await AdminFirebaseDatabaseService().getAdmin();
    if (adminData != null) {
      setState(() {
        adminObject = adminData;
      });
    }
  }

  @override
  void initState() {
    getAdminObject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget authSideBar() {
    return Container(
      decoration: const BoxDecoration(
        color: pureWhiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('images/app_icon.png'),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: const [
              Text(
                'WORDS',
                style: TextStyle(
                  color: pureBlackColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'OF CULTURE',
                style: TextStyle(
                  color: pureBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _bodyView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: authSideBar(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 7),
              decoration: const BoxDecoration(
                color: goldenColor,
              ),
              child: Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(
                        'Admin Portal'.toUpperCase(),
                        style: const TextStyle(
                          color: pureWhiteColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            color: pureWhiteColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: pureWhiteColor,
                          ),
                          child: TextFormField(
                            // controller: emailEdtController,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: pureBlackColor,
                            ),
                            autofocus: false,
                            // maxLength: 30,
                            keyboardType: TextInputType.emailAddress,
                            decoration: field2Decoration(
                              hintText: 'User Name',
                              label: 'User Name',
                            ),
                            validator: (email) =>
                                requiredField(email, 'Username'),
                            onSaved: (value) =>
                                loginUserObject.email = '$value',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: pureWhiteColor,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  // controller: passwordEdtController,
                                  maxLines: 1,
                                  obscureText: showPas,
                                  style: const TextStyle(
                                    color: pureBlackColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                  ),
                                  autofocus: false,
                                  maxLength: 30,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: field2Decoration(
                                    hintText: '*******',
                                    label: 'Password',
                                  ),
                                  validator: (value) =>
                                      value!.isEmpty ? '' : null,
                                  onSaved: (value) =>
                                      loginUserObject.password = value!,
                                ),
                              ),
                              IconButton(
                                onPressed: () => {
                                  setState(() {
                                    showPas = !showPas;
                                  })
                                },
                                icon: Icon(
                                  showPas
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.remove_red_eye,
                                  color: pureWhiteColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                          child: Material(
                            //Wrap with Material
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                            elevation: 18.0,
                            color: pureWhiteColor,
                            clipBehavior: Clip.antiAlias, // Add This
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 75,
                              color: pureWhiteColor,
                              onPressed: loginUser,
                              child: buttonLoading
                                  ? const CircularProgressIndicator(
                                      color: goldenColor,
                                    )
                                  : const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: pureBlackColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 30.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       const Text(
                    //         'Don\'t have an account? ',
                    //         style: TextStyle(
                    //           color: pureWhiteColor,
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    //       ),
                    //       GestureDetector(
                    //         onTap: () => {
                    //           // Basic beaming
                    //           // Beamer.of(context)
                    //           //     .beamToReplacementNamed('/sign_up'),
                    //         },
                    //         child: Text(
                    //           'SignUp',
                    //           style: TextStyle(
                    //             color: pureWhiteColor,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w700,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loginUser() async {
    try {
      if (!buttonLoading) {
        if (_loginFormKey.currentState!.validate()) {
          _loginFormKey.currentState!.save();
          setState(() {
            buttonLoading = true;
          });

          if (adminObject != null) {
            if (adminObject!.username == loginUserObject.email) {
              if (adminObject!.password == loginUserObject.password) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                      subScreen: QuotesScreen(),
                    ),
                  ),
                );
              } else {
                showNormalToast(msg: 'Invalid Password!');
              }
            } else {
              showNormalToast(msg: 'Invalid Username!');
            }
          } else {
            showNormalToast(msg: 'Please Refresh!');
          }

          print(loginUserObject.email);
        }
      } else {
        showNormalToast(msg: 'Please Wait!');
      }
    } on PlatformException catch (e) {
      showNormalToast(msg: e.message.toString());
    } catch (e) {
      showNormalToast(msg: e.toString());
    } finally {
      setState(() {
        buttonLoading = false;
      });
    }
  }
}
