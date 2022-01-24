import 'dart:convert';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required String text,
    required int number,
  }) : super(text: text, number: number);

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'number': number,
    };
  }

  factory NumberTriviaModel.fromMap(Map<String, dynamic> map) {
    return NumberTriviaModel(
      text: map['text'] ?? '',
      number: (map['number'] as num).toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NumberTriviaModel.fromJson(String source) =>
      NumberTriviaModel.fromMap(json.decode(source));
}
