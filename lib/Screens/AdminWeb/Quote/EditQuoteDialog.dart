import 'package:flutter/material.dart';
import 'package:words_of_culture/Firebase/AdminFirebaseDatabaseService.dart';
import 'package:words_of_culture/Objects/CategoryObject.dart';
import 'package:words_of_culture/Objects/QuotesObject.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/validators.dart';

class EditQuoteDialog extends StatefulWidget {
  QuotesObject quote;

  EditQuoteDialog({required this.quote});

  @override
  _EditQuoteDialogState createState() => _EditQuoteDialogState(quote: quote);
}

class _EditQuoteDialogState extends State<EditQuoteDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  TextEditingController quoteTextEdtController = TextEditingController();
  TextEditingController authorEdtController = TextEditingController();
  TextEditingController passwordEdtController = TextEditingController();
  final GlobalKey<FormState> _addQuoteFormKey = GlobalKey<FormState>();

  List<CategoryObject> categories = [];

  Future<void> getCategories() async {
    List<CategoryObject> categoriesData =
        await AdminFirebaseDatabaseService().getCategories();
    // print(categoriesData.length.toString());
    setState(() {
      categories = categoriesData;
    });
  }

  QuotesObject quote;

  _EditQuoteDialogState({required this.quote});

  @override
  void initState() {
    super.initState();
    getCategories();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

    quoteTextEdtController.text = quote.text!;
    authorEdtController.text = quote.author!;
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
              height: 260.0,
              width: 400,
              decoration: ShapeDecoration(
                  color: pureWhiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Form(
                key: _addQuoteFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: quoteTextEdtController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '',
                        labelText: 'Quote Text',
                      ),
                      validator: (text) => requiredField(text, 'Quote Text'),
                      onSaved: (text) {
                        setState(() {
                          quote.text = text;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: authorEdtController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '',
                        labelText: 'Author',
                      ),
                      validator: (author) => requiredField(author, 'Author'),
                      onSaved: (author) {
                        setState(
                          () {
                            quote.author = author;
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButton(
                      hint: quote.category == null
                          ? const Text('Select Category')
                          : Text(
                              quote.category!
                                  .toUpperCase()
                                  .replaceAll('-', ' '),
                              style: const TextStyle(color: Colors.blue),
                            ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(color: Colors.blue),
                      items: categories.map(
                        (value) {
                          return DropdownMenuItem<String>(
                            value: value.value,
                            child: Text(value.title!),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(
                          () {
                            quote.category = value;
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
                              onPressed: _addNewQuote,
                              child: const Text(
                                'ADD',
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

  Future<void> _addNewQuote() async {
    try {
      if (_addQuoteFormKey.currentState!.validate()) {
        _addQuoteFormKey.currentState!.save();

        await AdminFirebaseDatabaseService()
            .EditQuote(quote: quote)
            .then((quoteData) => {
                  Navigator.pop(context, quoteData),
                });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
