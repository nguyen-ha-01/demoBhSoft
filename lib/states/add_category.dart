import 'package:flutter/material.dart';

class AddCategory extends ChangeNotifier {
  String _iconSrc = "";
  int _color = 0xff000000;
  List<int> _colors = [];
  void init() {
    _colors.add(0xfffff111);
    _colors.add(0xff9ff111);
    _colors.add(0xff6ff111);
    _colors.add(0xff7ff111);
    _colors.add(0xff8ff111);

    notifyListeners();
  }

  List<int> getColors() => _colors;
  void setIconSrc(String v) {
    _iconSrc = v;
    notifyListeners();
  }

  void setColor(int p) {
    _color = p;
    notifyListeners();
  }

  String getIconSrc() => _iconSrc;
  int getColor() => _color;
}
