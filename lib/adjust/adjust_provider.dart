import 'package:flutter/material.dart';

class AdjustProvider extends ChangeNotifier {
  double revCounterMaxValue = 7000;

  void setRevCounterMaxValue(double value) {
    revCounterMaxValue = value;
    notifyListeners();
  }
}
