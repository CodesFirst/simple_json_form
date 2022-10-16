import 'package:flutter/widgets.dart';

class SimpleJsonFromViewModel extends ChangeNotifier {
  SimpleJsonFromViewModel();

  int _indexForm = 0;

  int get indexForm => _indexForm;

  void init(int index) {
    _indexForm = index;
  }

  void _setIndexForm(int index) {
    _indexForm = index;
    notifyListeners();
  }

  void changeIndexForm(int index) => _setIndexForm(index);
}
