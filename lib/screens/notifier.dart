import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyChangeNotifier extends ChangeNotifier {
  
  String _name = 'here';
  String get name => _name;

  set nme(String newName) {
    _name = newName;
    notifyListeners();
  }
}
