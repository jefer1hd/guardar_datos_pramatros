import 'package:flutter/material.dart';
import 'package:guardar_datos/helpers/user_preference.dart';

// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: avoid_print
//ignore_for_file: avoid_unnecessary_containers
//ignore_for_file: use_key_in_widget_constructors
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserPreference userPreference = UserPreference();
  await userPreference.initPrefers();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserPreference userPreference = UserPreference();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  List<String> myMusic = [];

  @override
  void initState() {
    UserPreference userPreference = UserPreference();
    nameController.text = userPreference.name;
    lastNameController.text = userPreference.lastName;
    ageController.text = "${userPreference.age}";
    myMusic = userPreference.favoriteMusic;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserPreference userPreference = UserPreference();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Guardar y Check de una lista"),
        ),
        backgroundColor: Colors.white,
        body: Builder(
          builder: (BuildContext context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    onChanged: (String value) {
                      userPreference.name = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      hintText: "Nombre",
                    ),
                  ),
                  TextField(
                    controller: lastNameController,
                    onChanged: (String value) {
                      userPreference.lastName = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      hintText: "Apellido",
                    ),
                  ),
                  TextField(
                    controller: ageController,
                    onChanged: (String value) {
                      try {
                        userPreference.age = int.parse(value);
                      } catch (e) {
                        print("Error");
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      hintText: "Edad",
                    ),
                  ),
                  DropdownButton(
                    value: userPreference.married,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(child: Text('Casado'), value: true),
                      DropdownMenuItem(child: Text('Soltero'), value: false),
                    ],
                    onChanged: (bool? value) {
                      setState(() {
                        userPreference.married = value!;
                      });
                    },
                  ),
                  musicCheckBox(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            userPreference.clean();
                            nameController.text = userPreference.name;
                            lastNameController.text = userPreference.lastName;
                            ageController.text = "${userPreference.age}";
                            myMusic = [];
                          });
                        },
                        child: Text("Reset")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget musicCheckBox() {
    final music = ['Rock', 'Pop', 'Reggae', 'Classic'];

    return Column(
      children: music
          .map(
            (m) => CheckboxListTile(
                title: Text(m),
                secondary: Icon(Icons.music_note),
                value: myMusic.indexOf(m) >= 0,
                onChanged: (_) {
                  if (myMusic.indexOf(m) < 0) {
                    myMusic.add(m);
                  } else {
                    myMusic.remove(m);
                  }
                  userPreference.favoriteMusic = myMusic;
                  setState(() {});
                }),
          )
          .toList(),
    );
  }
}
