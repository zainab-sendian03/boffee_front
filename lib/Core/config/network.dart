import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

enum status { offline, online }

class Conictivity extends ChangeNotifier {
  StreamController<status> connection = StreamController();

  Conictivity() {
    Connectivity().onConnectivityChanged.listen((event) {
      if (event.first == ConnectivityResult.mobile ||
          event.first == ConnectivityResult.wifi) {
            connection.add(status.online);

      } else {
        connection.add(status.offline);
      }
    });
  }
}
