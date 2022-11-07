import 'package:flutter/material.dart';

class AdjustProvider extends ChangeNotifier {
  double revCounterMaxValue = 7000;
  double currentRevCounterValue = 0;

  void setRevCounterMaxValue(double value) {
    revCounterMaxValue = value;
    notifyListeners();
  }

  void setCurrentRevCounterValue(double value) {
    currentRevCounterValue = value;
    notifyListeners();
  }
}
