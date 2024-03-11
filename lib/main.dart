import 'package:fasttrack/others/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/home.dart';
import 'Screens/login.dart';
import 'Screens/profile.dart';
import 'blocs/application_bloc.dart';


// Name - Ruchika Nawghare
// Start Date - 14-06-2022
// Modify Date -
// Reason to work on page -


void main() {
  // Light Theme
  final ThemeData lightTheme = ThemeData.light().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.white,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Dark Theme
  final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Background color of the FloatingCard
    cardColor: Colors.grey,
    buttonTheme: ButtonThemeData(
      // Select here's button color
      buttonColor: Colors.yellow,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  runApp(ChangeNotifierProvider(
          create: (context) => ApplicationBloc(),
          child: MaterialApp(
            title: '',
            themeMode: ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            home: login(),
          )
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fasttrack App',
      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),
      home: bottomnavvar(),
      debugShowCheckedModeBanner: false,
    );
  }
}


