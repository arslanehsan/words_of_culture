import 'package:flutter/material.dart';
import 'package:words_of_culture/Firebase/AdminFirebaseDatabaseService.dart';
import 'package:words_of_culture/Objects/CategoryObject.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/validators.dart';

class EditCategoryDialog extends StatefulWidget {
  CategoryObject category;

  EditCategoryDialog({required this.category});

  @override
  _EditCategoryDialogState createState() =>
      _EditCategoryDialogState(category: category);
}

class _EditCategoryDialogState extends State<EditCategoryDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  TextEditingController titleEdtController = TextEditingController();
  TextEditingController valueEdtController = TextEditingController();

  final GlobalKey<FormState> _addCategoryFormKey = GlobalKey<FormState>();

  // String bodyResult = '';
  CategoryObject category;

  _EditCategoryDialogState({required this.category});

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

    titleEdtController.text = category.title!;
    valueEdtController.text = category.value!;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(15.0),
              height: 200.0,
              width: 400,
              decoration: ShapeDecoration(
                  color: pureWhiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Form(
                key: _addCategoryFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleEdtController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '',
                        labelText: 'Category Name',
                      ),
                      validator: (text) => requiredField(text, 'Category Name'),
                      onChanged: (title) {
                        valueEdtController.text =
                            title.toLowerCase().replaceAll(' ', '-');
                      },
                      onSaved: (text) {
                        setState(() {
                          category.title = text;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: valueEdtController,
                      keyboardType: TextInputType.name,
                      enabled: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '',
                        labelText: 'Value',
                      ),
                      validator: (value) => requiredField(value, 'value'),
                      onSaved: (value) {
                        setState(
                          () {
                            category.value = value;
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                          child: ButtonTheme(
                            height: 35.0,
                            minWidth: 110.0,
                            child: MaterialButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              splashColor: Colors.white.withAlpha(40),
                              onPressed: _editCategory,
                              child: const Text(
                                'UPDATE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 10.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: ButtonTheme(
                                height: 35.0,
                                minWidth: 110.0,
                                child: MaterialButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  splashColor: Colors.white.withAlpha(40),
                                  child: const Text(
                                    'Cancel',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ))),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future<void> _editCategory() async {
    try {
      if (_addCategoryFormKey.currentState!.validate()) {
        _addCategoryFormKey.currentState!.save();

        await AdminFirebaseDatabaseService()
            .EditCategory(category: category)
            .then((quoteData) => {
                  Navigator.pop(context, quoteData),
                });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
