//This file helps with creating an adapter for the hive database with the data

import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 100, adapterName: "ItemAdapter")
class Item extends HiveObject{

  @HiveField(0)
  final dynamic itemName;

  @HiveField(1)
  final dynamic itemDetail;

   get getName => this.itemName;
   get getDetail => this.itemDetail;


Item({this.itemName, this.itemDetail});

}