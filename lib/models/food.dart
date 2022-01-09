import 'package:flutter/foundation.dart';


class Food with ChangeNotifier{
  late String _foodName;
  late String _foodColor;

 String get  foodName => _foodName;
 String get foodColor => _foodColor;

  Food(this._foodName, this._foodColor);

  
}