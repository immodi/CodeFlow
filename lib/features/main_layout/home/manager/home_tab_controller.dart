import 'package:flutter/cupertino.dart';

class HomeTabController extends ChangeNotifier {
  int _currentTab = 0;
  final GlobalKey<NavigatorState> compilerTabKey = GlobalKey<NavigatorState>();

  int get currentTab => _currentTab;

  void changeTab(int index) {
    if (_currentTab != index) {
      _currentTab = index;
      notifyListeners();
      debugPrint('Tab changed to: $index');
    }
  }
}