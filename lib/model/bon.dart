import 'package:flutter/material.dart';

class BonModel extends ChangeNotifier {
  List<Bon> _availableBons = [
    Bon(Colors.red.shade500, 'Limo', 2.00),
    Bon(Colors.pink.shade100, 'Pinktwenty', 2.80),
    Bon(Colors.yellow.shade600, 'Pommes', 3.00),
    Bon(Colors.grey.shade200, 'Waffel', 1.50),
    Bon(Colors.blue.shade300, 'Bier/Radler, Kaffee, Wein/Wein gesprizt', 2.50),
  ];

  List<Bon> get availableBons => _availableBons;

  List<Bon> _selectedBons = [];

  List<Bon> get selectedBons => _selectedBons;

  double get selectedBonsValue =>
      _selectedBons.fold(0, (total, bon) => total + bon.value);

  void selectBon(Bon bon) {
    var newBon = List<Bon>.from(_selectedBons);
    newBon.insert(0, bon);
    _selectedBons = newBon;
    notifyListeners();
  }

  void removeSelectedBonAt(index) {
    var newBon = List<Bon>.from(_selectedBons);
    newBon.removeAt(index);
    _selectedBons = newBon;
    notifyListeners();
  }

  void clearSelectedBon() {
    _selectedBons = List<Bon>.empty();
    notifyListeners();
  }

  void setAvailableBon(List<Bon> bon) {
    _availableBons = bon;
    clearSelectedBon();
  }

  void setAvailableBonAtIndex(Bon bon, int index) {
    var newBon = List<Bon>.from(_availableBons);
    newBon[index] = bon;
    setAvailableBon(newBon);
  }

  void removeAvailableBonAtIndex(int index) {
    var newBon = List<Bon>.from(_availableBons);
    newBon.removeAt(index);
    setAvailableBon(newBon);
  }
}

class Bon {
  Color color;
  String description;
  double value;

  Bon(this.color, this.description, this.value);
}
