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
      home: const MyHomePage(title: 'Storage Nameing'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const StorageShortName(),
    );
  }
}

class TestItem {
  TestItem({required this.name});
  String name;
}

var test = [
  TestItem(name: 'Test1'),
  TestItem(name: 'Test2'),
];

class StorageShortName extends StatefulWidget {
  const StorageShortName({super.key});
  @override
  State<StorageShortName> createState() => _StorageShortName();
}

class _StorageShortName extends State<StorageShortName> {
  var _test = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(_test),
        const Row(
          children: [],
        ),
        DropdownButton<String>(
          value: _test,
          icon: const Icon(Icons.arrow_drop_down_circle),
          items: const [
            DropdownMenuItem<String>(
              value: 'Test1',
              child: Text('Test1'),
            ),
            DropdownMenuItem<String>(
              value: 'Test2',
              child: Text('Test2'),
            ),
          ],
          onChanged: (value) => setState(() {
            _test = value!;
          }),
        ),
      ],
    );
  }
}

class ScrewShortName extends StatefulWidget {
  const ScrewShortName({super.key});
  @override
  State<ScrewShortName> createState() => _ScrewShortName();
}

class _ScrewShortName extends State<ScrewShortName> {
  var _test = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(_test),
        const Row(
          children: [],
        ),
        DropdownMenu<String>(
          dropdownMenuEntries: const [
            DropdownMenuEntry<String>(
              value: 'Test1',
              label: 'Test1',
              trailingIcon: Icon(Icons.brightness_1),
            ),
            DropdownMenuEntry<String>(
              value: 'Test2',
              label: 'Test2',
              trailingIcon: Icon(Icons.access_alarm_sharp),
            ),
          ],
          onSelected: (value) => setState(() {
            _test = value!;
          }),
          leadingIcon: const Icon(Icons.access_alarm_sharp),
        ),
      ],
    );
  }
}
