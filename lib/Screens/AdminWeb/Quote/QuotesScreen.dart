import 'package:flutter/material.dart';
import 'package:words_of_culture/Firebase/AdminFirebaseDatabaseService.dart';
import 'package:words_of_culture/Objects/QuotesObject.dart';
import 'package:words_of_culture/Screens/AdminWeb/Quote/AddQuoteDialog.dart';
import 'package:words_of_culture/Screens/AdminWeb/Quote/EditQuoteDialog.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/Dialougs.dart';
import 'package:words_of_culture/Utils/UtilWidgets.dart';

class QuotesScreen extends StatefulWidget {
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  TextEditingController searchEdtController = TextEditingController();
  List<QuotesObject> quotesList = [];
  // List<UserObject> users = [];
  //
  Future<void> getQuotes() async {
    List<QuotesObject> usersData =
        await AdminFirebaseDatabaseService().getQuotes();
    // print(usersData.length.toString());
    setState(() {
      quotesList = usersData;
      searchEdtController.text = '';
      searchText = '';
    });
  }

  @override
  initState() {
    getQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: goldenColor,
      ),
      child: Column(
        children: [
          _headingsView(),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: _detailsView(),
          ),
        ],
      ),
    );
  }

  String searchText = '';

  List<QuotesObject> getSearchUsers() {
    List<QuotesObject> usersList = [];
    if (searchText.length > 1) {
      for (var element in quotesList) {
        if (element.text!.split(searchText).length > 1) {
          usersList.add(element);
        }
      }
    } else {
      usersList = quotesList;
    }

    return usersList;
  }

  Widget _detailsView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: pureWhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 40,
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: GestureDetector(
                    onTap: getQuotes,
                    child: const Icon(
                      Icons.refresh,
                      color: pureBlackColor,
                      size: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: searchEdtController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '',
                      labelText: 'Search...',
                    ),
                  ),
                ),
                const Expanded(flex: 2, child: SizedBox()),
                showAddNewButton(
                  label: '+ Add New',
                  function: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => AddQuoteDialog(),
                    ).then((userData) => {
                          if (userData != null)
                            {
                              setState(() {
                                quotesList.add(userData);
                              }),
                            }
                        });
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 65,
            margin: const EdgeInsets.all(10),
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Index',
                    style: TextStyle(
                      color: pureBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'Text',
                    style: TextStyle(
                      color: pureBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Author',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: pureBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Category',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: pureBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Actions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: pureBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: getSearchUsers().length,
                  itemBuilder: (listContext, index) {
                    return _singleQuoteView(
                        quoteData: getSearchUsers()[index], index: index);
                  })),
        ],
      ),
    );
  }

  Widget _actionsView({required QuotesObject quote}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => showAlertDialog(
            context: context,
            label: 'Are you sure to delete ${quote.text}?',
            title: 'Warning',
            function: () => _deleteQuotes(quote: quote),
          ),
          child: Container(
            color: Colors.transparent,
            child: const Icon(
              Icons.delete,
              color: redColor,
              size: 20,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => EditQuoteDialog(quote: quote),
            ).then((quoteData) => {
                  if (quoteData != null)
                    {
                      setState(() {
                        quotesList.remove(quote);
                        quotesList.add(quoteData);
                      }),
                    }
                });
          },
          child: Container(
            color: Colors.transparent,
            child: const Icon(
              Icons.edit_note,
              color: Colors.blue,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _deleteQuotes({required QuotesObject quote}) async {
    print('object');

    QuotesObject? deletedQuote =
        await AdminFirebaseDatabaseService().DeleteQuote(quote: quote);
    if (deletedQuote != null) {
      setState(() {
        quotesList.remove(deletedQuote);
      });
    }
  }

  Widget _singleQuoteView({
    required QuotesObject quoteData,
    required int index,
  }) {
    return Container(
      height: 35,
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(
                  color: pureBlackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              quoteData.text!,
              style: const TextStyle(
                color: pureBlackColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              quoteData.author != 'null' ? quoteData.author! : '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: dullFontColor,
                fontSize: 9,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Text(
              quoteData.category!.toUpperCase().replaceAll('-', ' '),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: dullFontColor,
                fontSize: 9,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: _actionsView(quote: quoteData),
          ),
        ],
      ),
    );
  }

  Widget _headingsView() {
    return Row(
      children: [
        _singleHeadingView(
          label: 'Total Quotes',
          value: quotesList.length.toString(),
          image: Icons.person,
        ),
      ],
    );
  }

  Widget _singleHeadingView(
      {required String label, required String value, required IconData image}) {
    return Container(
      height: 135,
      width: MediaQuery.of(context).size.width / 6,
      decoration: BoxDecoration(
        color: pureWhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 40,
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Text(
              label,
              style: const TextStyle(
                color: dullFontColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFEFEFEF),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: pureBlackColor,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Icon(
                    image,
                    size: 25,
                  )
                  // Image.asset(
                  //   image,
                  //   height: 25,
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
