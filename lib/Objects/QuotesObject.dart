class QuotesObject {
  String? id, text, author, category;

  QuotesObject({
    this.id,
    this.text,
    this.author,
    this.category,
  });

  factory QuotesObject.fromJson({required parsedJson, required id}) {
    return QuotesObject(
      id: id,
      text: parsedJson['text'],
      author: parsedJson['author'].toString(),
      category: parsedJson['category'].toString(),
    );
  }
}
