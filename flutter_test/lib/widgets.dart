import 'package:bluetooth/bluetooth.dart';
// import 'package:bluetooth/gen/flutterblue.pb.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';

class ScanResultTile {
  final ScanResult result;
  final Function onTap;
  ScanResultTile({this.result, this.onTap});
}

class ServiceTile {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;
  ServiceTile({this.service, this.characteristicTiles});
}

class CharacteristicTile {
  final BluetoothCharacteristic characteristic;
  final Function onReadPressed;
  final Function onWritePressed;
  final Function onNotificationPressed;
  final List<DescriptorTile> descriptorTiles;

  CharacteristicTile(
      {this.characteristic,
      this.descriptorTiles,
      this.onNotificationPressed,
      this.onReadPressed,
      this.onWritePressed});
}

class DescriptorTile {
  final BluetoothDescriptor descriptor;
  final Function onReadPressed;
  final Function onWritePressed;

  DescriptorTile({this.onWritePressed, this.onReadPressed, this.descriptor});
}
