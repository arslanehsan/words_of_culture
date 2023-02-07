import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:words_of_culture/Objects/CategoryObject.dart';
import 'package:words_of_culture/Objects/QuotesObject.dart';

class FirebaseDatabaseService {
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  Future<List<QuotesObject>> getQuotes() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    List<String>? categoryData = sharedPref.getStringList(
      'selectedMood',
    );

    List<QuotesObject> quotes = [];
    final dbf = firebaseDatabase
        .ref()
        .child('Quotes')
        .orderByChild('category')
        .equalTo(categoryData![1]);

    await dbf.once().then((snapshot) {
      print(snapshot.snapshot.value);
      Map<dynamic, dynamic>? value = snapshot.snapshot.value as Map?;
      if (value != null) {
        value.forEach((key, values) {
          QuotesObject quoteDate =
              QuotesObject.fromJson(parsedJson: values, id: key);

          quotes.add(quoteDate);
        });
      }
    });
    return quotes..sort((a, b) => a.id!.compareTo(b.id!));
  }

  Future<List<CategoryObject>> getCategories() async {
    List<CategoryObject> categories = [];
    final dbf = firebaseDatabase.ref().child('Categories');

    await dbf.once().then((snapshot) {
      print(snapshot.snapshot.value);
      Map<dynamic, dynamic>? value = snapshot.snapshot.value as Map?;
      if (value != null) {
        value.forEach((key, values) {
          CategoryObject categoryData =
              CategoryObject.fromJson(parsedJson: values, id: key);

          categories.add(categoryData);
        });
      }
    });
    return categories..sort((a, b) => a.id!.compareTo(b.id!));
  }
}
