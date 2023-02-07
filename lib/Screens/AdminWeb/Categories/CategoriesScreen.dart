import 'package:flutter/material.dart';
import 'package:words_of_culture/Firebase/AdminFirebaseDatabaseService.dart';
import 'package:words_of_culture/Objects/CategoryObject.dart';
import 'package:words_of_culture/Screens/AdminWeb/Categories/AddCategoryDialog.dart';
import 'package:words_of_culture/Screens/AdminWeb/Categories/EditCategoryDialog.dart';
import 'package:words_of_culture/Utils/Colors.dart';
import 'package:words_of_culture/Utils/Dialougs.dart';
import 'package:words_of_culture/Utils/UtilWidgets.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController searchEdtController = TextEditingController();
  List<CategoryObject> categories = [];

  Future<void> getCategories() async {
    List<CategoryObject> categoriesData =
        await AdminFirebaseDatabaseService().getCategories();
    // print(categoriesData.length.toString());
    setState(() {
      categories = categoriesData;
      searchEdtController.text = '';
      searchText = '';
    });
  }

  @override
  initState() {
    getCategories();
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

  List<CategoryObject> getSearchCategories() {
    List<CategoryObject> categoriesList = [];
    if (searchText.length > 1) {
      for (var element in categoriesList) {
        if (element.title!
                .toLowerCase()
                .split(searchText.toLowerCase())
                .length >
            1) {
          categoriesList.add(element);
        }
      }
    } else {
      categoriesList = categories;
    }

    return categoriesList;
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
                    onTap: getCategories,
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
                      builder: (context) => AddCategoryDialog(),
                    ).then((categoryData) => {
                          if (categoryData != null)
                            {
                              setState(() {
                                categories.add(categoryData);
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
                  child: Text(
                    'value',
                    style: TextStyle(
                      color: pureBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Actions',
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
                  itemCount: getSearchCategories().length,
                  itemBuilder: (listContext, index) {
                    return _singleQuoteView(
                        category: getSearchCategories()[index], index: index);
                  })),
        ],
      ),
    );
  }

  Widget _singleQuoteView({
    required CategoryObject category,
    required int index,
  }) {
    return Container(
      height: 35,
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              (index + 1).toString(),
              style: const TextStyle(
                color: pureBlackColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              category.title!,
              style: const TextStyle(
                color: pureBlackColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              category.value!,
              style: const TextStyle(
                color: dullFontColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: _actionsView(category: category),
          ),
        ],
      ),
    );
  }

  Widget _actionsView({required CategoryObject category}) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => showAlertDialog(
            context: context,
            label: 'Are you sure to delete ${category.title}?',
            title: 'Warning',
            function: () => _deleteCategory(category: category),
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
              builder: (context) => EditCategoryDialog(category: category),
            ).then((categoryData) => {
                  if (categoryData != null)
                    {
                      setState(() {
                        categories.remove(category);
                        categories.add(categoryData);
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

  Future<void> _deleteCategory({required CategoryObject category}) async {
    print('object');

    CategoryObject? deletedCategory =
        await AdminFirebaseDatabaseService().DeleteCategory(category: category);
    if (deletedCategory != null) {
      setState(() {
        categories.remove(deletedCategory);
      });
    }
  }

  Widget _headingsView() {
    return Row(
      children: [
        _singleHeadingView(
          label: 'Total Category',
          value: categories.length.toString(),
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
