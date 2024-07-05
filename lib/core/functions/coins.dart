class Coin {
  int _coins = 0;

  int get coins => _coins;

  void addCoins(int amount) {
    _coins += amount;
  }

  void subtractCoins(int amount) {
    if (_coins >= amount) {
      _coins -= amount;
    }
  }
}
