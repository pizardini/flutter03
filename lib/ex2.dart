import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> _activities = [
    {
      'name': 'Estudar para prova de matemática.',
      'date': '16/08/2024',
    },
    {
      'name': 'Campeonato de futebol.',
      'date': '14/08/2024',
    },
    {
      'name': 'Festa da Joana.',
      'date': '23/08/2024',
    },
    {
      'name': 'Leitura de Don Quixote',
      'date': '25/08/2024',
    },
  ];


  void _addOrEditActivity(int? index, Map<String, String> newActivity) {
    setState(() {
      if (index == null) {

        _activities.add(newActivity);
      } else {

        _activities[index] = newActivity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atividades'),
      ),
      body: ListView.builder(
        itemCount: _activities.length,
        itemBuilder: (context, index) {
          final activity = _activities[index];
          return ListTile(
            leading: Icon(Icons.check_box_outline_blank, color: Colors.blue),
            title: Text(
              activity['name']!,
              style: const TextStyle(
                color: Colors.blue,
                fontFamily: 'Quicksand',
                fontSize: 26,
              ),
            ),
            trailing: Text(
              activity['date']!,
              style: const TextStyle(
                color: Colors.blue,
                fontFamily: 'Quicksand',
                fontSize: 22,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditActivityScreen(
                    activity: activity,
                    onSave: (updatedActivity) {
                      _addOrEditActivity(index, updatedActivity);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditActivityScreen(
                activity: null,
                onSave: (newActivity) {
                  _addOrEditActivity(null, newActivity);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EditActivityScreen extends StatefulWidget {
  final Map<String, String>? activity;
  final Function(Map<String, String>) onSave;

  const EditActivityScreen({
    super.key,
    required this.activity,
    required this.onSave,
  });

  @override
  _EditActivityScreenState createState() => _EditActivityScreenState();
}

class _EditActivityScreenState extends State<EditActivityScreen> {
  late TextEditingController _nameController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.activity?['name'] ?? '',
    );
    _dateController = TextEditingController(
      text: widget.activity?['date'] ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edição de atividade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome da Atividade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Data da Atividade',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                final updatedActivity = {
                  'name': _nameController.text,
                  'date': _dateController.text,
                };
                widget.onSave(updatedActivity);
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
