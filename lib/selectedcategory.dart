import 'dart:async';
import 'package:flutter/material.dart';
import 'jsongetter.dart';

class MySelectedPage extends StatefulWidget {
  const MySelectedPage({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  State<MySelectedPage> createState() => _MySelectedPageState();
}

class _MySelectedPageState extends State<MySelectedPage> {
  late Future<RandomAlbum> futureAlbum;


  @override
  void initState() {
    super.initState();
    futureAlbum = fetchSelectedAlbum(widget.category);
  }

  void _printjoke() {
    setState(() {
      futureAlbum = fetchSelectedAlbum(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chuck Norris Jokes App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text("#${widget.category}",
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              margin: const EdgeInsets.only(top: 30, bottom: 40),
            ),
            Container(
              child: Image.asset('assets/chuck-norris.png'),
              margin:
              const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: FutureBuilder<RandomAlbum>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SafeArea(
                        child: Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              snapshot.data!.value,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const Align(
                        alignment: Alignment.topCenter,
                        child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 50),
                height: 50,
                child: ElevatedButton(
                  onPressed: _printjoke,
                  child: const Text('GIMME NEXT'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
