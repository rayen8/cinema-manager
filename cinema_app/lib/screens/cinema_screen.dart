import 'dart:convert';
import 'dart:developer';

import 'package:cinema_app/screens/places_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CinemaScreen extends StatefulWidget {
  final dynamic ville;
  const CinemaScreen({Key? key, required this.ville}) : super(key: key);

  @override
  _CinemaScreenState createState() => _CinemaScreenState();
}

class _CinemaScreenState extends State<CinemaScreen> {
  List<dynamic>? listCinemas;

  @override
  void initState() {
    super.initState();
    loadCinemas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cinemas de ${widget.ville['name']}"),
      ),
      body: Center(
        child: listCinemas == null
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: (listCinemas == null) ? 0 : listCinemas!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: Text(
                          listCinemas![index]['name'],
                          style: const TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacesScreen(
                                cinema: listCinemas![index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  void loadCinemas() {
    String url = widget.ville['_links']['cinemas']['href'];
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        listCinemas = json.decode(resp.body)['_embedded']['cinemas'];
      });
    }).catchError((err) {
      log(err);
    });
  }
}
