import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class SyncData {
  final Connectivity _connectivity = Connectivity();
  final StreamController<List<ConnectivityResult>> _connectivityStreamController =
      StreamController<List<ConnectivityResult>>();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  Future<void> sync(Future<void> Function() doOnChange) async {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((event) async {
      _connectivityStreamController.add(event);
      if (!event.contains(ConnectivityResult.none)) {
        doOnChange();
      }
    });
  }

  void dispose() {
    _connectivityStreamController.close();
    _connectivitySubscription.cancel();
  }
}
