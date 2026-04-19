import 'dart:convert';
import 'package:http/http.dart' as http;
import 'question.dart';

class ApiService {
  static const String url =
      'https://opentdb.com/api.php?amount=10&category=21&difficulty=easy&type=multiple';

  static Future<List<Question>> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        List<Question> questions = (data['results'] as List)
            .map((item) => Question.fromJson(item))
            .toList();

        return questions;
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
