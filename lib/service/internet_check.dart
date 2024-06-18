import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  ConnectivityService() {
    // Initialize connectivity subscription
  }

  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    }
    if (connectivityResult.contains(ConnectivityResult.none)) {
      // No available network types
      return false;
    }
    return false;
  }
}
