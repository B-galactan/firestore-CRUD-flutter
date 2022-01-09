
import 'package:flutter/material.dart';



class DataBaseScreen extends StatefulWidget {
  const DataBaseScreen({ Key? key }) : super(key: key);

  @override
  _DataBaseScreenState createState() => _DataBaseScreenState();
}

class _DataBaseScreenState extends State<DataBaseScreen> {
    
  
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title:const Text('DataBase Screen'),),

      body: Column(
        children: [
          Expanded(
            child: Center(
              child: RaisedButton(
                child:Text("Show"),
                color: Colors.purple,
                onPressed: (){
                    Navigator.pushNamed(context, '/dataBaseList');
                },
                 ) ,
              ),
            ),
      
                ],

              ),
            );
    
  }
}