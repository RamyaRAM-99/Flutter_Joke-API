import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class JokeApi {
  static Future<Joke> fetchJoke() async {
    final response = await http.get(Uri.parse('https://icanhazdadjoke.com/'), headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      return Joke.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load joke');
    }
  }
}
