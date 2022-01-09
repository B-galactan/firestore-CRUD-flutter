
import 'package:flutter/material.dart';
import 'package:flutter_db/models/models.dart';
import 'package:provider/provider.dart';

//Try and learn BottomNavigator

class DataBaseList extends StatefulWidget {
  const DataBaseList({ Key? key }) : super(key: key);

  @override
  State<DataBaseList> createState() => _DataBaseListState();
}

class _DataBaseListState extends State<DataBaseList> {

  final nameUpdateController =  TextEditingController();
  final detailUpdateController = TextEditingController();

  @override
  Widget build(BuildContext context)  {
    FoodNotifier myNotifier = Provider.of<FoodNotifier>(context);
    
    void clearingNameText(){
      nameUpdateController.clear();
    }

    void clearingDetailText(){
      detailUpdateController.clear();
    }

    return Scaffold(
            appBar: AppBar(title: Text('DataBase List'),),

          body:SingleChildScrollView(
            physics: const ScrollPhysics(),
           child: Column(
             mainAxisSize: MainAxisSize.max,
             children: [
               ListView.builder(
                 physics: const NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 itemCount: myNotifier.itemList.length,
                 itemBuilder: (context, index) => Card(
                   child: ListTile(
                     title: Text(myNotifier.itemList[index].itemName.toString()),
                     subtitle: Text(myNotifier.itemList[index].itemDetail.toString()),
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
                                       if(nameUpdateController.text.isNotEmpty && detailUpdateController.text.isNotEmpty){
                                           
                                      myNotifier.updateMyBox(index,Item(itemName: nameUpdateController.text,
                                                                       itemDetail: detailUpdateController.text));
                                            
                                      myNotifier.addToBox(Item(itemName: nameUpdateController.text,
                                                              itemDetail: detailUpdateController.text));                                 
                                            
                                      myNotifier.openMyBox();
                                      clearingNameText();
                                      clearingDetailText();
                                     
                                     Navigator.pop(context);
                                    
                                       } else {
                                     Navigator.pop(context);
                                       }
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
                                myNotifier.deleteFromBox(index);
                              },
                             ),
                             
                       ]
                     
                      
                    ),
                     
                   ),
                 ),
                 
                 ),
               
             ],
           ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70.0),
                  child: Row(
                  children: [ 
                    FloatingActionButton(
                    
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
                                         if(nameUpdateController.text.isNotEmpty || detailUpdateController.text.isNotEmpty){
                                             
                                            myNotifier.addToBox(Item(itemName: nameUpdateController.text,
                                                                itemDetail: detailUpdateController.text));
                                        
                                        myNotifier.openMyBox();
                                       
                                       Navigator.pop(context);
                                       clearingNameText();
                                       clearingDetailText();
                                         
                                         } else {
                                       Navigator.pop(context);
                                         }
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
                                    const SizedBox(width: 70.0,),
                                
                  FloatingActionButton(
                    child: const Icon( Icons.arrow_forward_ios),
                    onPressed: (){
                      Navigator.pushNamed(context, '/fireStoreDB');
                    },
                  ),
                    
                    ],
                                    ),
                ),
                  

        );
  }
}