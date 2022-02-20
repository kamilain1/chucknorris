import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

Future<RandomAlbum> fetchRandomAlbum() async {
  final response =
  await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
  if (response.statusCode == 200) {
    return RandomAlbum.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<RandomAlbum> fetchSelectedAlbum(category) async {
  final response =
  await http.get(Uri.parse('https://api.chucknorris.io/jokes/random?category=' + category));
  if (response.statusCode == 200) {
    return RandomAlbum.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class RandomAlbum {
  final String iconurl;
  final String id;
  final String url;
  final String value;

  const RandomAlbum(
      {required this.iconurl,
        required this.id,
        required this.url,
        required this.value});

  factory RandomAlbum.fromJson(Map<String, dynamic> json) {
    return RandomAlbum(
        iconurl: json['icon_url'],
        id: json['id'],
        url: json['url'],
        value: json['value']);
  }
}

Future fetchCategoriesAlbum() async {
  final response =
  await http.get(Uri.parse('https://api.chucknorris.io/jokes/categories'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body) as List;
  } else {
    throw Exception('Failed to load album');
  }
}


