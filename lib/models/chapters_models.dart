// To parse this JSON data, do
//
//     final chaptersModel = chaptersModelFromJson(jsonString);

import 'dart:convert';

class ChaptersModel {
  List<Chapter> chapters;

  ChaptersModel({
    this.chapters,
  });
  
  static ChaptersModel chaptersModelFromJson(String str) {
    final jsonData = json.decode(str);
    return ChaptersModel.fromJson(jsonData);
  }

  static String chaptersModelToJson(ChaptersModel data) {
    final dyn = data.toJson();
    return json.encode(dyn);
  }

  factory ChaptersModel.fromJson(Map<String, dynamic> json) =>
      new ChaptersModel(
        chapters: new List<Chapter>.from(
            json["chapters"].map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chapters": new List<dynamic>.from(chapters.map((x) => x.toJson())),
      };
}

class Chapter {
  int id;
  int chapterNumber;
  bool bismillahPre;
  int revelationOrder;
  RevelationPlace revelationPlace;
  String nameComplex;
  String nameArabic;
  String nameSimple;
  int versesCount;
  List<int> pages;
  TranslatedName translatedName;

  Chapter({
    this.id,
    this.chapterNumber,
    this.bismillahPre,
    this.revelationOrder,
    this.revelationPlace,
    this.nameComplex,
    this.nameArabic,
    this.nameSimple,
    this.versesCount,
    this.pages,
    this.translatedName,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => new Chapter(
        id: json["id"],
        chapterNumber: json["chapter_number"],
        bismillahPre: json["bismillah_pre"],
        revelationOrder: json["revelation_order"],
        revelationPlace: revelationPlaceValues.map[json["revelation_place"]],
        nameComplex: json["name_complex"],
        nameArabic: json["name_arabic"],
        nameSimple: json["name_simple"],
        versesCount: json["verses_count"],
        pages: new List<int>.from(json["pages"].map((x) => x)),
        translatedName: TranslatedName.fromJson(json["translated_name"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chapter_number": chapterNumber,
        "bismillah_pre": bismillahPre,
        "revelation_order": revelationOrder,
        "revelation_place": revelationPlaceValues.reverse[revelationPlace],
        "name_complex": nameComplex,
        "name_arabic": nameArabic,
        "name_simple": nameSimple,
        "verses_count": versesCount,
        "pages": new List<dynamic>.from(pages.map((x) => x)),
        "translated_name": translatedName.toJson(),
      };
}

enum RevelationPlace { MAKKAH, MADINAH }

final revelationPlaceValues = new EnumValues(
    {"madinah": RevelationPlace.MADINAH, "makkah": RevelationPlace.MAKKAH});

class TranslatedName {
  LanguageName languageName;
  String name;

  TranslatedName({
    this.languageName,
    this.name,
  });

  factory TranslatedName.fromJson(Map<String, dynamic> json) =>
      new TranslatedName(
        languageName: languageNameValues.map[json["language_name"]],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "language_name": languageNameValues.reverse[languageName],
        "name": name,
      };
}

enum LanguageName { ENGLISH }

final languageNameValues = new EnumValues({"english": LanguageName.ENGLISH});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}