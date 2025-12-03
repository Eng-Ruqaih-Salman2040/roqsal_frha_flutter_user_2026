import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
class CheckInterNet extends GetxController {
  var connectionInterNet = 0.obs;

  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult>_connectivitySubscription;

  StreamSubscription? subscription;
  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
    late SimpleConnectionChecker _simpleConnectionChecker = SimpleConnectionChecker()
      ..setLookUpAddress('pub.dev');

  //Optional method to pass the lookup string
    subscription = _simpleConnectionChecker.onConnectionChange.listen((connected) {
      print('connected is : '+connected.toString());
     if(connected){
       connectionInterNet.value=1;
     }
     else{
       connectionInterNet.value=0;
     }

    });
    // initConnectivity();
    // _connectivitySubscription=_connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }




  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    //_connectivitySubscription.cancel();
    subscription!.cancel();
  }


}