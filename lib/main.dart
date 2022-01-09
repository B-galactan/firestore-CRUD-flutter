import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:flutter_db/database/database_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_db/models/models.dart';
import 'package:flutter_db/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_db/screens/screens.dart';
import 'package:hive/hive.dart';
import 'database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    Directory appDirrectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirrectory.path);
    Hive.registerAdapter(ItemAdapter());

    await Hive.openBox("shopItems");

    await Firebase.initializeApp();  
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FoodNotifier()),
      ],


      child: SeriousBloc()
      )
      );
}

class SeriousBloc extends StatelessWidget {
  
  
  
   SeriousBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      
   
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/page1' : (context) => ListPage(),
        '/dataBase': (context) => DataBaseScreen(),
        '/dataBaseList': (context) => DataBaseList(),
        '/fireStoreDB' : (context) => FireStoreDB()

      },
      theme: ThemeData(
          primaryColor: new Color(0xff075E54),
          accentColor:  new Color(0xff25D366)
      ),
      home: HomePage(),
    );
  }
}
