import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storage Naming',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Storage Naming'),
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

class StorageOption {
  final String? stringValue;
  final StorageType? storageTypeValue;

  StorageOption({this.stringValue, this.storageTypeValue})
      : assert(stringValue != null || storageTypeValue != null),
        assert(stringValue == null || storageTypeValue == null);
}

class StorageType {
  StorageType({required this.name, this.options});
  String name;
  List<StorageType>? options;
}

var storageOptions = [
  StorageType(name: 'L1_Test1', options: [
    StorageType(name: 'L2_Test1'),
    StorageType(name: 'L2_Test2'),
  ]),
  StorageType(name: 'L1_Test2', options: [
    StorageType(name: 'L2_Test1'),
    StorageType(name: 'L2_Test2'),
    StorageType(name: 'L2_Test3'),
  ]),
];

void clearListAfterIndex(List<String?> list, int index) {
  for (int i = index + 1; i < list.length; i++) {
    list[i] = '';
  }
}

void genDropdown(
    int offset,
    List<DropdownButton<StorageType>?> drops,
    List<String?> names,
    List<StorageType> storageTypes,
    VoidCallback setStateCallback) {
  if (offset >= drops.length) {
    drops.length = offset + 1;
  }
  if (offset >= names.length) {
    names.length = offset + 1;
  }
  drops[offset] = DropdownButton<StorageType>(
    items: storageTypes.map((option) {
      return DropdownMenuItem<StorageType>(
        value: option,
        child: Text(option.name),
      );
    }).toList(),
    onChanged: (value) {
      if (value != null) {
        names[offset] = value.name;
        clearListAfterIndex(names, offset);
        if (value.options != null) {
          genDropdown(
              offset + 1, drops, names, value.options!, setStateCallback);
        }
        setStateCallback();
      }
    },
  );
}

class StorageShortName extends StatefulWidget {
  const StorageShortName({super.key});
  @override
  State<StorageShortName> createState() => _StorageShortName();
}

class _StorageShortName extends State<StorageShortName> {
  List<String?> names = [];
  List<DropdownButton<StorageType>?> dropdowns = [];
  late String combined = '';

  @override
  void initState() {
    super.initState();
    genDropdown(0, dropdowns, names, storageOptions, () {
      combined = names.whereType<String>().join(' ');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Storage Short Name: $combined'),
      Row(
        children: dropdowns.whereType<DropdownButton<StorageType>>().toList(),
      )
    ]);
  }
}
