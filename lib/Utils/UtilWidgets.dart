import 'package:flutter/material.dart';
import 'package:words_of_culture/Utils/Colors.dart';

Widget BrownButtonView({
  required String label,
  required bool loading,
  required BuildContext context,
  required Function function,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
    child: Material(
      //Wrap with Material
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      elevation: 18.0,
      color: pureBlackColor,
      clipBehavior: Clip.antiAlias, // Add This
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        height: 50,
        color: redColor,
        onPressed: () => function,
        child: loading
            ? const CircularProgressIndicator(
                color: pureWhiteColor,
              )
            : Text(
                label,
                style: const TextStyle(
                  color: pureWhiteColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    ),
  );
}

Widget ColorButtonView(
    {required String label,
    required Color color,
    required Color textColor,
    required BuildContext context,
    required Function function,
    required bool loading}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
    child: Material(
      //Wrap with Material
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      elevation: 18.0,
      color: color,
      clipBehavior: Clip.antiAlias, // Add This
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        height: 50,
        color: color,
        onPressed: () => function(),
        child: loading
            ? CircularProgressIndicator(
                color: textColor,
              )
            : Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    ),
  );
}

Widget backgroundView({required BuildContext context}) {
  return Container(
    decoration: const BoxDecoration(
      color: backgroundColor,
    ),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    // child: Center(
    //   child: Image.asset(''),
    // ),
  );
}

Widget whiteBackgroundView({required BuildContext context}) {
  return Container(
    decoration: const BoxDecoration(
      color: pureWhiteColor,
    ),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
  );
}

Widget loader() {
  return Center(
    child: SizedBox(
      height: 240,
      width: 240,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/loading.gif'),
              ),
            ),
          ),
          // Image.asset('images/loading.gif'),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Please Wait....',
            style: TextStyle(
              color: dullFontColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    ),
  );
}

Widget appBarView({required String label, required Function function}) {
  return GestureDetector(
    onTap: () => function(),
    child: Container(
      color: Colors.transparent,
      child: Row(
        children: [
          const Icon(
            Icons.keyboard_double_arrow_left,
            color: pureWhiteColor,
            size: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            label,
            style: const TextStyle(
              color: pureWhiteColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    ),
  );
}

Widget showAddNewButton({required String label, required Function function}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
    child: Material(
      //Wrap with Material
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
      elevation: 10.0,
      color: pureBlackColor,
      clipBehavior: Clip.antiAlias, // Add This
      child: MaterialButton(
        minWidth: 140.0,
        height: 40,
        color: pureBlackColor,
        onPressed: () => function(),
        child: Text(
          label,
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
        ),
      ),
    ),
  );
}
