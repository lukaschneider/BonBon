import 'package:flutter/material.dart';

class BonModel extends ChangeNotifier {
  final List<Bon> _availableBons = [
    Bon(Colors.red.shade500, 'Limo', 2.00),
    Bon(Colors.pink.shade100, 'Pinktwenty', 2.80),
    Bon(Colors.yellow.shade600, 'Pommes', 3.00),
    Bon(Colors.grey.shade200, 'Waffel', 1.50),
    Bon(Colors.blue.shade300, 'Bier/Radler, Kaffee, Wein/Wein gesprizt', 2.50),
  ];

  List<Bon> get availableBons => _availableBons;

  final List<Bon> _selectedBons = [];

  List<Bon> get selectedBons => _selectedBons;

  double get selectedBonsValue =>
      _selectedBons.fold(0, (total, bon) => total + bon.value);

  void selectBon(Bon bon) {
    _selectedBons.insert(0, bon);
    notifyListeners();
  }

  void removeSelectedBonAt(index) {
    _selectedBons.removeAt(index);
    notifyListeners();
  }

  void clearSelectedBon() {
    _selectedBons.clear();
    notifyListeners();
  }
}

@immutable
class Bon {
  final Color color;
  final String description;
  final double value;

  const Bon(this.color, this.description, this.value);
}
