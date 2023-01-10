import 'package:flutter/material.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Eli Ogilvy"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 219, 18, 209),
        ),
        body: Center(
          child: IconButton(
              onPressed: () {
                print("clicked");
              },
              icon: Icon(Icons.alternate_email),
              color: Colors.amber),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          backgroundColor: Color.fromARGB(255, 219, 18, 209),
          child: Text("Click"),
        ),
      ),
    );
  }
}
