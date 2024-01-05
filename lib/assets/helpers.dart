import 'package:get/get.dart';
import 'dart:convert';
String minutesToHours(minutes, separator) {
  minutes = double.parse(minutes);
  var hours = (minutes / 60).floor();
  var remainingMinutes = (minutes % 60);
  if(separator != '') {
    return "$hours$separator$remainingMinutes";
  }
  return '${hours}H ${remainingMinutes}m';
}