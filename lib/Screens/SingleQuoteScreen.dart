import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:words_of_culture/Objects/QuotesObject.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/UtilWidgets.dart';

class SingleQuoteScreen extends StatefulWidget {
  final QuotesObject quote;

  const SingleQuoteScreen({super.key, required this.quote});
  @override
  _SingleQuoteScreenState createState() => _SingleQuoteScreenState();
}

class _SingleQuoteScreenState extends State<SingleQuoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/wallpaper.jpeg'),
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0x80000000),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: appBarView(
                    label: '',
                    function: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        '${widget.quote.text}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: pureWhiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                      if (widget.quote.author != 'null')
                        const SizedBox(
                          height: 10,
                        ),
                      if (widget.quote.author != 'null')
                        Text(
                          '${widget.quote.author}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: dullFontColor1,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        FlutterShare.share(
                            title: 'Share Link From wordsofculture.com',
                            text:
                                '${widget.quote.text}\n${widget.quote.author != null ? 'Author: ${widget.quote.author}' : ''}');
                      },
                      child: const Icon(
                        Icons.ios_share,
                        size: 55,
                        color: pureWhiteColor,
                      ),
                    ),
                    // const SizedBox(
                    //   width: 20,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       if (likedQuotes(
                    //           id: quotes[index].id!)) {
                    //         likeQuotes.remove(quotes[index].id);
                    //       } else {
                    //         likeQuotes.add(quotes[index].id!);
                    //       }
                    //     });
                    //     SharedPrefs.setStringListPreference(
                    //         key: 'likes', list: likeQuotes);
                    //     showNormalToast(
                    //         msg: likedQuotes(
                    //             id: quotes[index].id!)
                    //             ? 'Dislike!'
                    //             : 'Liked!');
                    //   },
                    //   child: Icon(
                    //     likedQuotes(id: quotes[index].id!)
                    //         ? Icons.favorite
                    //         : Icons.favorite_outline_sharp,
                    //     size: 55,
                    //     color: pureWhiteColor,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
