import 'dart:convert';

class SearchProductModel {
  final int id;
  final String title;

  SearchProductModel({
    required this.id,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "title": title,
    };
  }

  factory SearchProductModel.fromMap(Map<String, dynamic> map) {
    return SearchProductModel(
      id: map["id"] as int,
      title: map["title"] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchProductModel.fromJson(String source) =>
      SearchProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
