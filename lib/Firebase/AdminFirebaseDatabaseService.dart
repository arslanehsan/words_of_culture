import 'package:firebase_database/firebase_database.dart';
import 'package:words_of_culture/Objects/AdminObject.dart';
import 'package:words_of_culture/Objects/CategoryObject.dart';
import 'package:words_of_culture/Objects/QuotesObject.dart';

class AdminFirebaseDatabaseService {
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  Future<List<QuotesObject>> getQuotes() async {
    List<QuotesObject> quotes = [];
    final dbf = firebaseDatabase.ref().child('Quotes');

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

  Future<AdminObject?> getAdmin() async {
    AdminObject? adminData = AdminObject(username: '', password: '');
    DatabaseReference dbf = firebaseDatabase.ref().child('Settings');

    await dbf.once().then((snapshot) {
      Map<dynamic, dynamic>? value = snapshot.snapshot.value as Map?;
      if (value != null) {
        value.forEach((key, values) {
          print(values.toString());
          if (key == 'userName') {
            adminData.username = values;
          } else if (key == 'password') {
            adminData.password = values;
          }
        });
      }
    });
    return adminData;
    // ..sort((a, b) => a.brandSequence.compareTo(b.brandSequence));
  }

  Future<QuotesObject?> AddNewQuote({required QuotesObject quote}) async {
    QuotesObject? newQuote;
    DatabaseReference dbf = firebaseDatabase.ref();
    String? key = dbf.child('Quotes').push().key;

    try {
      Map<String, dynamic> quoteData = {
        'text': quote.text,
        'author': quote.author,
        'category': quote.category,
      };
      await dbf.child('Quotes').child(key!).set(quoteData).then((value) async {
        newQuote = quote;
        newQuote!.id = key;
      });

      return newQuote;
    } catch (e) {
      print("Add Quote Error");
      print(e);
      return null;
    }
  }

  Future<QuotesObject?> EditQuote({required QuotesObject quote}) async {
    QuotesObject? newQuote;
    DatabaseReference dbf = firebaseDatabase.ref();
    String? key = quote.id;

    try {
      Map<String, dynamic> quoteData = {
        'text': quote.text,
        'author': quote.author,
        'category': quote.category,
      };
      await dbf
          .child('Quotes')
          .child(key!)
          .update(quoteData)
          .then((value) async {
        newQuote = quote;
      });

      return newQuote;
    } catch (e) {
      print("Edit Quote Error");
      print(e);
      return null;
    }
  }

  Future<QuotesObject?> DeleteQuote({required QuotesObject quote}) async {
    QuotesObject? newQuote;
    DatabaseReference dbf = firebaseDatabase.ref();
    String? key = quote.id;

    try {
      await dbf.child('Quotes').child(key!).remove().then((value) async {
        newQuote = quote;
      });

      return newQuote;
    } catch (e) {
      print("Delete Quote Error");
      print(e);
      return null;
    }
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

  Future<CategoryObject?> AddNewCategory(
      {required CategoryObject category}) async {
    CategoryObject? newCategory;
    DatabaseReference dbf = firebaseDatabase.ref();

    try {
      String? key = dbf.child('Categories').push().key;
      Map<String, dynamic> categoryData = {
        'title': category.title,
        'value': category.value,
      };
      await dbf
          .child('Categories')
          .child(key!)
          .set(categoryData)
          .then((value) async {
        newCategory = category;
      });

      return newCategory;
    } catch (e) {
      print("Add Error");
      print(e);
      return null;
    }
  }

  Future<CategoryObject?> EditCategory(
      {required CategoryObject category}) async {
    CategoryObject? newCategory;
    DatabaseReference dbf = firebaseDatabase.ref();

    try {
      String? key = category.id;
      Map<String, dynamic> categoryData = {
        'title': category.title,
        'value': category.value,
      };
      await dbf
          .child('Categories')
          .child(key!)
          .set(categoryData)
          .then((value) async {
        newCategory = category;
      });

      return newCategory;
    } catch (e) {
      print("Edit Error");
      print(e);
      return null;
    }
  }

  Future<CategoryObject?> DeleteCategory(
      {required CategoryObject category}) async {
    CategoryObject? deletedCategory;
    DatabaseReference dbf = firebaseDatabase.ref();

    try {
      String? key = category.id;

      await dbf.child('Categories').child(key!).remove().then((value) async {
        deletedCategory = category;
      });

      return deletedCategory;
    } catch (e) {
      print("Delete Error");
      print(e);
      return null;
    }
  }
}
