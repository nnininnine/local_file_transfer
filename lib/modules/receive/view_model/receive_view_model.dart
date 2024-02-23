import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class ReceiveViewModelDelegate {
  void setState(VoidCallback fn);
}

class ReceiveViewModel {
  // MARK: Properties

  ReceiveViewModelDelegate? delegate;

  String? ssid;
  String? password;

  String? qrData;

  // MARK: Methods

  MethodChannel getChannel() {
    const channelName = 'app.local_file_transfer.com/test_channel';
    return const MethodChannel(channelName);
  }

  Future<void> shareHotspot() async {
    // check permission
    Map<Permission, PermissionStatus> statuses =
        await [Permission.location, Permission.nearbyWifiDevices].request();

    if (statuses[Permission.location]!.isGranted &&
        statuses[Permission.nearbyWifiDevices]!.isGranted) {
      getChannel().invokeMethod<String>("shareHotspot").then((value) {
        if (value != null) {
          List<String> strList = value.split(':');
          ssid = strList.first;
          password = strList.last;
        }
        if (kDebugMode) {
          print('result');
          print(value);
        }
      }).onError((error, stackTrace) {
        ssid = null;
        password = null;
        if (kDebugMode) {
          print(error);
        }
      });
    }
  }
}
