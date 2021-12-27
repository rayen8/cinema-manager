import 'dart:convert';
import 'dart:developer';

import 'package:cinema_app/screens/cinema_screen.dart';
import 'package:cinema_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VillesScreen extends StatefulWidget {
  const VillesScreen({Key? key}) : super(key: key);

  @override
  State<VillesScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<VillesScreen> {
  List<dynamic>? listVilles;

  @override
  void initState() {
    super.initState();
    loadVilles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Villes'),
      ),
      body: Center(
        child: listVilles == null
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: (listVilles == null) ? 0 : listVilles!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        child: Text(
                          listVilles![index]['name'],
                          style: const TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CinemaScreen(
                                ville: listVilles![index],
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

  void loadVilles() async {
    //String url= await "http://192.168.42.152:8080/villes";
    String url = GlobalData.baseUrl + "/villes";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        listVilles = json.decode(resp.body)['_embedded']['villes'];
      });
    }).catchError((err) {
      log(err);
    });
  }
}
