// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:yt_pkg_staggered_grid_view/global_enums.dart';
import 'package:yt_pkg_staggered_grid_view/staggered_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const customSwatch = MaterialColor(
    0xFFFF5252,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFFF5252),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> layouts = [
    "Staggered", "Masonry", "Quilted", "Woven", "Staired", "Aligned"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Staggered Grid View"),
      ),
      body: ListView.builder(
        itemCount: layouts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  StaggeredScreen(selectedGrid: GridType.values[index], title: layouts[index]),)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Text(layouts[index], style: TextStyle(color: Colors.black, fontSize: 16),)),
                  SizedBox(width: 20,),
                  Icon(Icons.navigate_next, color: Colors.redAccent, size: 30,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

