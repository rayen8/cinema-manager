import 'dart:convert';

import 'package:cinema_app/models/Film.dart';
import 'package:cinema_app/utils/constants.dart';
import 'package:http/http.dart';

class HttpFilmService {
  final String endpoint = "${GlobalData.baseUrl}/films";

  Future<List<Film>> getAll() async {
    final response = await get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>)
          .map(
            (rawFilm) => Film.fromJson(rawFilm),
          )
          .toList();
    } else {
      throw Exception("Failed to get films!");
    }
  }
}
