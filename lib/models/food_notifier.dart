
import 'package:flutter_db/models/models.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:hive/hive.dart';


class FoodNotifier with ChangeNotifier{
      List<Food> _foodList = [];
       UnmodifiableListView<Food> get foodList => UnmodifiableListView(_foodList);


      

      List<Item> _itemList =  [
            Item(itemName: "Shop Item", itemDetail: "Item Detail")
      ];
      List<Item> get itemList => this._itemList;

   

      void addFood(Food food){
        _foodList.add(food);
        notifyListeners(); 
      }

      void resetList(){
        _foodList.clear();
        notifyListeners();
      }

      
        addToBox(Item item) async {
          var box =  await Hive.openBox("shopItems");
         await box.put(item.itemName.toString(), item.itemDetail);
         notifyListeners();
      }


     openMyBox() async{
       var theBox = await Hive.openBox("shopItems");
        var boxMap = theBox.toMap();
        _itemList = boxMap.entries.map((entry) => Item(itemName: entry.key, itemDetail: entry.value)).toList();
        notifyListeners();

     }

     updateMyBox(int index, Item item) async{
       var theBox = await Hive.openBox("shopItems");
        await theBox.deleteAt(index);

         var boxMap = theBox.toMap();
        _itemList = boxMap.entries.map((entry) => Item(itemName: entry.key, itemDetail: entry.value)).toList();

        notifyListeners();

     }

     deleteFromBox(int index) async{
            var theBox = await Hive.openBox("shopItems");
            await theBox.deleteAt(index);
            var boxMap = theBox.toMap();
          _itemList = boxMap.entries.map((entry) => Item(itemName: entry.key, itemDetail: entry.value)).toList();

            notifyListeners();
     }

     fireStoreAdd(Item item){

     }


     

    
}