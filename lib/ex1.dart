import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Switch Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String nome = 'fulano';
  double opacity = 0.5;
  Color textColor = Color.fromARGB(128, 0, 0, 0);
  bool useOpacity = true;

  void changeName() {
    setState(() {
      if (nome == 'fulano') {
        nome = 'Pietro';
        if (useOpacity) {
          opacity = 1.0;
        } else {
          textColor = Color.fromARGB(255, 0, 0, 0);
        }
      } else {
        nome = 'fulano';
        if (useOpacity) {
          opacity = 0.5;
        } else {
          textColor = Color.fromARGB(128, 0, 0, 0);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Usar Opacidade:'),
                Switch(
                  value: useOpacity,
                  onChanged: (bool value) {
                    setState(() {
                      useOpacity = value;
                      changeName();
                    });
                  },
                ),
              ],
            ),
            if (useOpacity)
              Opacity(
                opacity: opacity,
                child: Text(
                  '$nome',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.black),
                ),
              )
            else
              Text(
                '$nome',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: textColor),
              ),
            OutlinedButton(
              onPressed: () {
                changeName();
                print(textColor);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              child: Text('Mostre Nome'),
            ),
          ],
        ),
      ),
    );
  }
}
