import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled3/first_screen.dart';


void main()async{
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void getMode()
  {
    darkMode.addListener(() { // that means when you listen any new value do setstate
      setState(() {

      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMode();
  }
  // @override
  // void didChangeDependencies() async {
  //   await CacheHelper.init();
  //   super.didChangeDependencies();
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(), // for light mode
       darkTheme: ThemeData(
         brightness: Brightness.dark ,
         listTileTheme: const ListTileThemeData(
           textColor: Colors.white,
         ),
         cardTheme: CardTheme(
           color: HexColor('333739'),
         ),
         scaffoldBackgroundColor: HexColor('333739'),
         // appBarTheme: AppBarTheme(
         //   elevation: 0,
         //   backgroundColor: HexColor('333739'),
         // ),
         textTheme: const TextTheme(
           bodyText1: TextStyle(
             color: Colors.white,
           )
         ),
       ), // for dark mode
      themeMode: darkMode.value? ThemeMode.dark : ThemeMode.light, //// عشان اختار ال theme بتاع ال App
      debugShowCheckedModeBanner: false,
      home:  const FirstScreen(),
    );
  }
}

