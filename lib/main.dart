import 'package:flutter/material.dart';
import 'models/joke.dart';
import 'service/joke_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Joke Generator',
      theme: ThemeData(),
      home: JokePage(),
    );
  }
}

class JokePage extends StatefulWidget {
  @override
  _JokePageState createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  Joke? _joke;
  bool _isLoading = false;

  void _fetchJoke() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final joke = await JokeApi.fetchJoke();
      setState(() {
        _joke = joke;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text(
          'Random Joke Generator',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSerif4',
              color: Colors.white),
        ),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _joke == null
                ? const Text(
                    'Press the button to fetch a joke',
                    style: TextStyle(fontFamily: 'SourceSerif4', fontSize: 20),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _joke!.joke,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: 'SourceSerif4',
                      ),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchJoke,
        tooltip: 'Fetch Joke',
        child: const Icon(
          Icons.refresh,
          color: Colors.black,
        ),
      ),
    );
  }
}
