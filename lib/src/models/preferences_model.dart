// To parse this JSON data, do
//
//     final preferenceModel = preferenceModelFromJson(jsonString);

import 'dart:convert';

List<PreferenceModel> preferenceModelFromJson(String str) =>
    List<PreferenceModel>.from(
        json.decode(str).map((x) => PreferenceModel.fromJson(x)));

String preferenceModelToJson(List<PreferenceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PreferenceModel {
  int questionId;
  bool multipleChoice;
  bool otherAnswer;
  String question;
  List<String> answers;

  PreferenceModel({
    required this.questionId,
    required this.multipleChoice,
    required this.otherAnswer,
    required this.question,
    required this.answers,
  });

  factory PreferenceModel.fromJson(Map<String, dynamic> json) =>
      PreferenceModel(
        questionId: json["question_id"],
        multipleChoice: json["multiple_choice"],
        otherAnswer: json["other_answer"],
        question: json["question"],
        answers: List<String>.from(json["answers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "multiple_choice": multipleChoice,
        "other_answer": otherAnswer,
        "question": question,
        "answers": List<dynamic>.from(answers.map((x) => x)),
      };
}
