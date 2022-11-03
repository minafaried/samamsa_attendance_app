import 'dart:math';

import 'package:attendance_app/features/Home/model/entities/Memper..dart';
import 'package:attendance_app/features/Home/model/services/memperServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MemperStatus { Loading, Error, Normal }

class MempersController extends ChangeNotifier {
  List<Memper> _mempers = [];
  late MemperStatus memperStatus = MemperStatus.Normal;
  late String errorMessage;
  MemperServices memperServices = MemperServices();
  List<Memper>? get mempers {
    return _mempers;
  }

  Future<void> getMempers(String family) async {
    memperStatus = MemperStatus.Loading;
    _mempers = [];
    notifyListeners();
    try {
      List? resData = await memperServices.getMempers(family);
      if (resData == null || resData.length == 0) {
        memperStatus = MemperStatus.Error;
        _mempers = [];
        notifyListeners();
        return;
      }
      resData.forEach((element) {
        Memper memper = Memper.fromJson(element);
        _mempers.add(memper);
      });
      memperStatus = MemperStatus.Normal;
      notifyListeners();
    } catch (e) {
      memperStatus = MemperStatus.Error;
      errorMessage = "error.. try again";
      print(e);
      _mempers = [];
      notifyListeners();
      return;
    }
  }

  Future<void> sendAttendance(String family, String event) async {
    memperStatus = MemperStatus.Loading;
    notifyListeners();
    try {
      List<Map<String, dynamic>> sendedData = [];
      _mempers.forEach((element) {
        if (element.isAttende == false) {
          memperStatus = MemperStatus.Error;
          notifyListeners();
          return;
        }
        sendedData.add(element.toMap());
      });
      await memperServices.sendAttendance(family, event, sendedData).then((_) {
        memperStatus = MemperStatus.Normal;
        notifyListeners();
      });
    } catch (e) {
      memperStatus = MemperStatus.Error;
      errorMessage = "error.. try again";
      _mempers = [];
      notifyListeners();
      return;
    }
  }
}
