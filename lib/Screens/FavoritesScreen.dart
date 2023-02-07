import 'package:flutter/material.dart';
import 'package:words_of_culture/Firebase/FirebaseDatabaseService.dart';
import 'package:words_of_culture/Helper/SharedPrefs.dart';
import 'package:words_of_culture/Objects/QuotesObject.dart';
import 'package:words_of_culture/Screens/SingleQuoteScreen.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/UtilWidgets.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<QuotesObject> quotes = [];
  List<String> likeQuotes = [];

  Future<void> getQuotes() async {
    List<QuotesObject> quotesData = await FirebaseDatabaseService().getQuotes();
    setState(() {
      quotes = quotesData;
    });
  }

  Future<void> getLikesQuotes() async {
    List<String> likeQuotesData =
        await SharedPrefs.getStringListPreference(key: 'likes');
    setState(() {
      likeQuotes = likeQuotesData;
    });

    for (var element in likeQuotesData) {
      print(element);
    }
  }

  bool likedQuotes({required String id}) {
    bool liked = false;
    for (var element in likeQuotes) {
      if (element == id) {
        liked = true;

        print(liked);
      }
    }
    return liked;
  }

  @override
  void initState() {
    getQuotes();
    getLikesQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureBlackColor,
      body: _bodyView(),
    );
  }

  List<QuotesObject> getLikedQuotes() {
    List<QuotesObject> quotesList = [];
    for (var element in quotes) {
      if (likeQuotes.contains(element.id)) {
        quotesList.add(element);
      }
    }
    return quotesList;
  }

  Widget _bodyView() {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            appBarView(
              label: 'Favorites',
              function: () => Navigator.pop(context),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                      itemCount: getLikedQuotes().length,
                      itemBuilder: (listContext, index) {
                        return _singleQuoteView(quote: getLikedQuotes()[index]);
                      })),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _singleQuoteView({required QuotesObject quote}) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SingleQuoteScreen(quote: quote),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quote.text!,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: goldenColor,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              quote.author != 'null' ? quote.author! : '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: pureWhiteColor,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
