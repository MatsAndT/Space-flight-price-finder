import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as JSON;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          subhead: TextStyle(fontSize: 14),
          headline: TextStyle(fontSize: 24),
        ),
      ),
      home: Window(),
    );
  }
}

class Window extends StatefulWidget {
  final String title = 'On Way';

  @override
  _WindowState createState() => _WindowState();
}

class _WindowState extends State<Window> {
  int bodyIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body[bodyIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: bodyIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              title: Text(''),
            ),
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      bodyIndex = index;
    });
  }

  List<Widget> body = [
    OnWay(),
    ToAndHome(),
    Calender(),
  ];
}

class FlightCard extends StatelessWidget {
  FlightCard(this.data);

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Color.fromRGBO(0, 0, 0, 2))),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(data['when'], style: Theme.of(context).textTheme.caption,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(data['from'] + ' - ' + data['to'], style: Theme.of(context).textTheme.headline,),
                CircleAvatar(
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/space-flight-price-finder.appspot.com/o/LunaCorpIcon.png?alt=media&token=5b022972-2011-4eec-af43-6a7fd1e5f221'),
                ),
              ],
            ),
            SizedBox(height: 4.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(data['class'], style: Theme.of(context).textTheme.caption,),
                Text(data['pris']+ " \$", style: Theme.of(context).textTheme.caption,),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OnWay extends StatelessWidget {
  List data;
  Future<http.Response> fetchPost() {
    return http.get(
        'https://us-central1-space-flight-price-finder.cloudfunctions.net/onWay');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return Text('entry $index');
      },
    );
  }
}

class ToAndHome extends StatefulWidget {
  @override
  _ToAndHomeState createState() => _ToAndHomeState();
}

class _ToAndHomeState extends State<ToAndHome> {
  List data;

  Future<http.Response> fetchPost() {
    return http.get(
        'https://us-central1-space-flight-price-finder.cloudfunctions.net/toAndBack');
  }

  Future<String> makeRequest() async {
    var response = await http.get(
        Uri.encodeFull(
            'https://us-central1-space-flight-price-finder.cloudfunctions.net/toAndBack'),
        headers: {"Accept": "application/json"});

    setState(() {
      data = JSON.jsonDecode(response.body);
      print(data);
    });
  }

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return FlightCard(data[index]);
      },
    );
  }
}

class Calender extends StatelessWidget {
  Future<http.Response> fetchPost() {
    return http.get('https://jsonplaceholder.typicode.com/posts/1');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
