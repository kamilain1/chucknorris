import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close_outlined, color: Colors.black),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text('Kamil Agliullin',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                      'Innopolis University student, 3rd year bachelor',
                      style: TextStyle(fontSize: 20)),
                ),
                //mailto:kamil.ain@yahoo.com
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () => _launchURL("https://t.me/kamilain"),
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(child: Icon(LineIcons.telegram)),
                          TextSpan(
                              text: '  Telegram',
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () => _launchURL("mailto:kamil.ain@yahoo.com"),
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(child: Icon(Icons.mail)),
                          TextSpan(
                              text: '  Email', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(50),
          child: Image.asset('assets/chucknorris_logo.png'),
        ),
        Container(
          padding: const EdgeInsets.only(left: 60, right: 60, bottom: 30),
          child: const Text(
              'App for displaying funny Chuck Norris facts. Based on chucknorris.io free JSON API',
              style: TextStyle(fontSize: 20), textAlign: TextAlign.justify,),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          height: 50,
          child: ElevatedButton(
            onPressed: _showMyDialog,
            child: const Text('About creator', style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }
}
