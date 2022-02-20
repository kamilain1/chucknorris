import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test1/selectedcategory.dart';
import 'jsongetter.dart';

class MyCategoriesPage extends StatefulWidget {
  const MyCategoriesPage({Key? key}) : super(key: key);

  @override
  State<MyCategoriesPage> createState() => _MyCategoriesPageState();
}

class _MyCategoriesPageState extends State<MyCategoriesPage> {
  late Future futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchCategoriesAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var entries = snapshot.data! as List;
                return Expanded(
                  child: SafeArea(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(8),
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              '${entries[index]}',
                              style: const TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'selected category \"${entries[index]}\"',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MySelectedPage(category: entries[index]),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(thickness: 1),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
