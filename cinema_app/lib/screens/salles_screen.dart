import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cinema_app/utils/constants.dart';
import 'dart:convert';

class RoomScreen extends StatefulWidget {
  final dynamic cinema;

  const RoomScreen({Key? key, required this.cinema}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  List<dynamic>? listSalles;

  @override
  void initState() {
    super.initState();
    loadSalles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salles de ${widget.cinema['name']}"),
      ),
      body: Center(
        child: listSalles == null
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: listSalles == null ? 0 : listSalles!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white70,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                              ),
                              child: Text(
                                listSalles![index]['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                loadProjections(
                                  listSalles![index],
                                );
                              },
                            ),
                          ),
                        ),
                        if (listSalles![index]['projections'] != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(
                                  GlobalData.baseUrl +
                                      "/imageFilm/${listSalles![index]['currentProjection']['film']['id']}",
                                  width: 150,
                                ),
                                Column(
                                  children: [
                                    ...(listSalles![index]['projections']
                                            as List<dynamic>)
                                        .map(
                                      (projection) {
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: (listSalles![index][
                                                            'currentProjection']
                                                        ['id'] ==
                                                    projection['id'])
                                                ? Colors.deepPurple
                                                : Colors.blueGrey,
                                          ),
                                          child: Text(
                                            "${projection['seance']['heureDebut']}(${projection['film']['duree']},Prix=${projection['prix']})",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                          onPressed: () {
                                            loadTickets(
                                              projection,
                                              listSalles![index],
                                            );
                                          },
                                        );
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        if (listSalles![index]['currentProjection'] != null &&
                            listSalles![index]['currentProjection']
                                    ['listTickets'] !=
                                null &&
                            listSalles![index]['currentProjection']
                                        ['listTickets']
                                    .length >
                                0)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Nombre de places disponible:${listSalles![index]['currentProjection']['nombrePlacesDisponibles']}",
                                  )
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                child: const TextField(
                                  decoration:
                                      InputDecoration(hintText: 'Your name'),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Code payemant',
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Nombre de Tickets',
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.redAccent,
                                    ),
                                    child: const Text(
                                      "Réserver les places",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {},
                                  )),
                              Wrap(
                                children: [
                                  ...listSalles![index]['currentProjection']
                                          ['listTickets']
                                      .map(
                                    (ticket) {
                                      if (ticket['reservee'] == false) {
                                        return Container(
                                          width: 50,
                                          padding: const EdgeInsets.all(2),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blueAccent,
                                            ),
                                            child: Text(
                                              "${ticket['place']['numero']}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            onPressed: () {},
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  void loadSalles() {
    String url = widget.cinema['_links']['salles']['href'];
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        listSalles = json.decode(resp.body)['_embedded']['salles'];
      });
    }).catchError((err) {
      log(err);
    });
  }

  void loadProjections(salle) {
    //String url1=GlobalData.host+"/salles/${salle['id']}/projections?projection=FilmProjection";
    String url2 = salle['_links']['projections']['href']
        .toString()
        .replaceAll("{?projection}", "?projection=FilmProjection");
    //print(url1);
    log(url2);
    http.get(Uri.parse(url2)).then((resp) {
      setState(() {
        salle['projections'] =
            json.decode(resp.body)['_embedded']['projections'];
        salle['currentProjection'] = salle['projections'][0];
        salle['currentProjection']['listTickets'] = [];
        //print(salle['projections']);
      });
    }).catchError((err) {
      log(err);
    });
  }

  void loadTickets(projection, salle) {
    //String url="http://localhost:8080/projections/1/tickets?projection=ticketProj";
    String url = projection['_links']['tickets']['href']
        .toString()
        .replaceAll("{?projection}", "?projection=ticketProj");
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        projection['listTickets'] =
            json.decode(resp.body)['_embedded']['tickets'];
        salle['currentProjection'] = projection;
        projection['nombrePlacesDisponibles'] =
            nombrePlaceDisponibles(projection);
      });
    }).catchError((err) {
      log(err);
    });
  }

  nombrePlaceDisponibles(projection) {
    int nombre = 0;
    for (int i = 0; i < projection['tickets'].length; i++) {
      if (projection['tickets'][i]['reservee'] == false) ++nombre;
    }
    return nombre;
  }
}
