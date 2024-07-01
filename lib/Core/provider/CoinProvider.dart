import 'package:flutter/material.dart';
import 'package:userboffee/Core/constants/functions/coins.dart';



class CoinProvider with ChangeNotifier {
  Coin _coin = Coin();

  int get coins => _coin.coins;

  void addCoins(int amount) {
    _coin.addCoins(amount);
    notifyListeners();
  }

  void subtractCoins(int amount) {
    _coin.subtractCoins(amount);
    notifyListeners();
  }
}