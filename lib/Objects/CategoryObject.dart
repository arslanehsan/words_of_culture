class CategoryObject {
  String? id;
  String? title, value;

  CategoryObject({this.title, this.value, this.id});

  factory CategoryObject.fromJson({required parsedJson, required id}) {
    return CategoryObject(
      id: id,
      title: parsedJson['title'],
      value: parsedJson['value'].toString(),
    );
  }
}
