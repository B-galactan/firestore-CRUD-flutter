import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_db/models/models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreDB extends StatefulWidget {
  const FireStoreDB({ Key? key }) : super(key: key);

  @override
  _FireStoreDBState createState() => _FireStoreDBState();
}

class _FireStoreDBState extends State<FireStoreDB> {

    final nameUpdateController =  TextEditingController();
    final detailUpdateController = TextEditingController();
    


  @override
  Widget build(BuildContext context) {

    //This is to create an instance of the data in the cloud firestore database
     CollectionReference studentData = FirebaseFirestore.instance.collection('marks');

    void clearingNameText(){
      nameUpdateController.clear();
    }

    void clearingDetailText(){
      detailUpdateController.clear();
    }
  
    return Scaffold(
       appBar: AppBar(title: Text('Firestore database'),),
       
       body: SingleChildScrollView(
         physics: const ScrollPhysics(),

         child: Column(
                 mainAxisSize: MainAxisSize.max,

           children: [
             StreamBuilder(
               
               // studentData is an instance of the collection of data from firestore
               // Check upper code to see how the instance was generated

                 stream: studentData.snapshots() ,
                  
                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  
                  if(!snapshot.hasData){
                    return const Center(
                      
                      child: CircularProgressIndicator()
                      );
                  }
              
              return ListView(
               physics: const NeverScrollableScrollPhysics(),
               shrinkWrap: true,
                
                //creating a map of our data from firestore and we are 
                //referencing each data set as "item" and we can use this 
                // in CRUD database operations
                  children: snapshot.data!.docs.map((item) {
                      return Card(
                       child: ListTile(
                      
                      title: Text(item['Name']),
                      subtitle: Text( item['Marks'].toString() ), //The number from firestore must be converted to a string
                      
                      trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                       ElevatedButton(
                           child:const Text("Update"),
                           onPressed: (){
                             
                                  showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        child: Card(
                          child: Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: nameUpdateController, 
                                  decoration: const InputDecoration(
                                  labelText: "Item name",
                                  
                                ),
                                
                                ),
                                const SizedBox(height: 10.0,),
                                TextField(
                                  controller: detailUpdateController,
                                  decoration:const InputDecoration( 
                                  labelText: "Item Detail",
                                ),
                                
                                ),
                                ElevatedButton(
                                  child: const Text("Update"),
                                  onPressed: () {
                                    //Adding data to firestore
                                     
                                    studentData.add({             
                                          'Name': nameUpdateController.text,
                                          'Marks': int.parse(detailUpdateController.text),
                                    });
                                   
                                   clearingNameText();
                                   clearingDetailText();
                                  Navigator.pop(context);
                                    
                                }, 
                                )
                              ],
                            ),
                          ) ,
                          ),
                      ),
                    );
                               
                  }
                   );
                           }
                          ),
                     
                          IconButton(
                           icon:const Icon(Icons.delete, color: Colors.blue,),
                           onPressed: (){

                             //Uses the map id as reference to delete a record
                             studentData.doc(item.id).delete().then((value) => print ("Deleted"));
                           },
                          ),
                          
                    ]
                  
                   
                 ),
                  
                                  ),
                                );
                  }).toList(),  
              // ".toList" is very important to convert the map into a proper iterable without major errors
              // It must be added to the end of the map obtained from the firestore data    
                    
             );
                 }),
           ],
         ),
             ),
                
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton(
                  child: const Icon( Icons.add),
                  onPressed: (){
                    showDialog(
                       context: context,
                       builder: (context) {
                         return Dialog(
                           child: Container(
                             child: Card(
                               child: Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   TextField(
                                     controller: nameUpdateController,
                                     decoration: const InputDecoration(
                                     labelText: "Item name",
                                   ),
                                   ),
                                   TextField(
                                     controller: detailUpdateController,
                                     decoration:const InputDecoration( 
                                     labelText: "Item Detail",

                                   ),
                                   ),
                                   ElevatedButton(
                                     
                                     onPressed: () {

                                      studentData.add({
                                        'Name': nameUpdateController.text,
                                        'Marks': int.parse( detailUpdateController.text),
                                      });
                                     
                                     
                                     clearingNameText();
                                     clearingDetailText();
                                     Navigator.pop(context);  
                                       }, 
                                    
                                   child: const Text("Submit"))
                                 ],
                               ) ,
                               ),
                           ),
                         );
                       }
                     );
                  } ,
                  
                  ),
                );
    
  }
}