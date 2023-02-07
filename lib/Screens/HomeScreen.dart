import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:words_of_culture/AddHelper/AdHelper.dart';
import 'package:words_of_culture/Firebase/FirebaseDatabaseService.dart';
import 'package:words_of_culture/Helper/SharedPrefs.dart';
import 'package:words_of_culture/Objects/CategoryObject.dart';
import 'package:words_of_culture/Objects/QuotesObject.dart';
import 'package:words_of_culture/Screens/SettingsScreen.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/Global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QuotesObject> quotes = [];
  List<String> likeQuotes = [];
  CategoryObject? selectedCategory;

  Future<void> getQuotes() async {
    List<QuotesObject> quotesData = await FirebaseDatabaseService().getQuotes();
    setState(() {
      quotes = quotesData;
    });
  }

  Future<void> getLikesQuotes() async {
    List<String>? likeQuotesData =
        await SharedPrefs.getStringListPreference(key: 'likes');
    if (likeQuotesData != null) {
      setState(() {
        likeQuotes = likeQuotesData;
      });
      for (var element in likeQuotesData) {
        print(element);
      }
    }
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  BannerAd? _bannerAd;

  bool likedQuotes({required String id}) {
    bool liked = false;
    for (var element in likeQuotes) {
      if (element == id) {
        liked = true;
      }
    }
    return liked;
  }

  Future<void> getSelectedCategory() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    List<String>? categoryData = sharedPref.getStringList(
      'selectedMood',
    );

    if (categoryData != null) {
      setState(() {
        selectedCategory =
            CategoryObject(title: categoryData[0], value: categoryData[1]);
      });
    } else {
      SharedPrefs.setStringListPreference(
          key: 'selectedMood', list: ['Normal', 'normal']);

      setState(() {
        selectedCategory = CategoryObject(title: 'Normal', value: 'normal');
      });
    }

    getQuotes();
  }

  @override
  void initState() {
    getLikesQuotes();
    getSelectedCategory();
    super.initState();
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkForWidgetLaunch();
    HomeWidget.widgetClicked.listen(_launchedFromWidget);
  }

  void _checkForWidgetLaunch() {
    HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
  }

  void _launchedFromWidget(Uri? uri) {
    if (uri != null) {
      showDialog(
          context: context,
          builder: (buildContext) => AlertDialog(
                title: const Text('App started from HomeScreenWidget'),
                content: Text('Here is the URI: $uri'),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyView(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsScreen(),
            ),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: goldenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.settings,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bodyView() {
    return Column(
      children: [
        Expanded(
          child: quotes.isNotEmpty
              ? PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: quotes.length,
                  itemBuilder: (context, index) {
                    try {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(color: pureBlackColor
                            // image: DecorationImage(
                            //   fit: BoxFit.cover,
                            //   image: AssetImage('images/wallpaper.jpeg'),
                            // ),
                            ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0x80000000),
                          ),
                          child: SafeArea(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                const SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${quotes[index].text}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: pureWhiteColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 30,
                                        ),
                                      ),
                                      if (quotes[index].author != 'null')
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      if (quotes[index].author != 'null')
                                        Text(
                                          '${quotes[index].author}',
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
                                            title:
                                                'Share Link From wordsofculture.com',
                                            text:
                                                '${quotes[index].text}\n${quotes[index].author != null ? 'Author: ${quotes[index].author}' : ''}');
                                      },
                                      child: const Icon(
                                        Icons.ios_share,
                                        size: 55,
                                        color: pureWhiteColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (likedQuotes(
                                              id: quotes[index].id!)) {
                                            likeQuotes.remove(quotes[index].id);
                                          } else {
                                            likeQuotes.add(quotes[index].id!);
                                          }
                                        });
                                        SharedPrefs.setStringListPreference(
                                            key: 'likes', list: likeQuotes);
                                        showNormalToast(
                                            msg: likedQuotes(
                                                    id: quotes[index].id!)
                                                ? 'Liked!'
                                                : 'Dislike!');
                                      },
                                      child: Icon(
                                        likedQuotes(id: quotes[index].id!)
                                            ? Icons.favorite
                                            : Icons.favorite_outline_sharp,
                                        size: 55,
                                        color: pureWhiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: SizedBox(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } catch (e) {
                      print(e);
                      return Container();
                    }
                  })
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: pureBlackColor
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image: AssetImage('images/wallpaper.jpeg'),
                      // ),
                      ),
                ),
        ),
        if (_bannerAd != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          ),
      ],
    );
  }
}
