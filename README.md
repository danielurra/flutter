# Flutter takes inspiration from React
Mobile development using Flutter and Dart <br>
* Flutter is a cross-platform development framework that allows the creation of a single
piece of code that can be deployed across several platforms (Android, iOS, and
Desktop). <br>
* Dart is a general-purpose, object-oriented programming language with C-style syntax created by Google <br>
in 2011, Dart is quite similar to Kotlin and Swift, and it may be trans-compiled into JavaScript code.
## First App created - ToDo list

Quite a simple app that allows you to add and track tasks, a fun way to learn Flutter/Dart basics.
<p align="center"><img src="https://user-images.githubusercontent.com/51704179/235729853-7a31f9f7-7952-4690-8047-6c0f8e547344.gif"/>

## How to remove the debug flag from your application?
This is something really simple, just use the following command:
```dart
debugShowCheckedModeBanner: false,
```
The **debugShowCheckedModeBanner** accepts  a Boolean value to indicate whether the notification should be shown.
![flutter-remove-banner](https://user-images.githubusercontent.com/51704179/235453780-3c43561f-e375-48a8-9272-d243e70dad88.gif)

## Grab the code - main.dart
  ```dart
  import 'package:flutter/material.dart';
import 'package:todo_list_final/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      routes: {
        "home": (context) => Home(),
      },
    );
  }
}
  ```
  
## Grab the code home.dart
  ```dart
  import 'package:flutter/material.dart';

List tareas = [
  {
    "id": 0,
    "titulo": "Task #1",
    "descripcion": "Organize bedroom",
    "completado": true
  },
  {
    "id": 1,
    "titulo": "Task #2",
    "descripcion": "Do laundry",
    "completado": false
  },
];
bool completado = false;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: tareas.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SwitchListTile(
                    title: Column(
                      children: [
                        // Text(tareas[index]["id"].toString()),
                        Text(tareas[index]["titulo"]),
                        Text(tareas[index]["descripcion"]),
                      ],
                    ),
                    value: tareas[index]["completado"],
                    onChanged: (b) {
                      setState(() {
                        tareas[index]["completado"] =
                            !tareas[index]["completado"];
                      });
                    });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await cartel(context);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Future<void> cartel(BuildContext context) async {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        content: Container(
          color: Colors.lightBlue,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add new TODO task",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: tituloController,
                      decoration:
                          InputDecoration(hintText: "Type the task's name"),
                    ),
                    TextFormField(
                      controller: descripcionController,
                      decoration: InputDecoration(hintText: "Description"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Text("Already done?"),
                    CustomSwitch(),
                  ],
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.remove_red_eye_sharp)),
              IconButton(
                  onPressed: () {
                    Map tarea = {
                      "id": tareas.length,
                      "titulo": tituloController.text,
                      "descripcion": descripcionController.text,
                      "completado": completado,
                    };
                    tareas.add(tarea);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.save)),
            ],
          )
        ],
      );
    },
  );
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: completado,
        onChanged: (b) {
          setState(() {
            completado = b;
          });
        });
  }
}
 ```
  
  
