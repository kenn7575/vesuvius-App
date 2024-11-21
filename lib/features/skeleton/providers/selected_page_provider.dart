import 'package:flutter/material.dart';

class SelectedPageProvider extends ChangeNotifier {
  String selectedPage;

  SelectedPageProvider({
    this.selectedPage = "/",
  });

  void changePage(String newPage) {
    selectedPage = newPage;
    notifyListeners();
  }
}
