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
