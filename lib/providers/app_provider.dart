import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AppProvider extends ChangeNotifier {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  bool _status = false;
  bool _statusAuto = false;
  bool _isSwitched = false;
  int _speedPump = 0;
  int _setSoilmoisture = 0;
  int _soilMoisture = 0;
  String _time = "";

  // Add getters for your state variables
  bool get status => _status;
  bool get statusAuto => _statusAuto;
  bool get isSwitched => _isSwitched;
  int get speedPump => _speedPump;
  int get setSoilmoisture => _setSoilmoisture;
  int get soilMoisture => _soilMoisture;
  String get time => _time;

  AppProvider(BuildContext context) {
    updateStatus(context);
    updateStatusAuto(context);
    updateSwitched(context);
    updateSpeedPump(context);
    updateSetSoilmoisture(context);
    updateSoilMoisture(context);
    updateTime(context);
  }

  bool isWidgetMounted(BuildContext context) {
    final state = Scaffold.of(context);
    return state.mounted;
  }

  // Add methods to update the state
  void updateStatus(BuildContext context) {
    _databaseReference
        .child('ESP32/setControl/PUMP/status')
        .onValue
        .listen((event) {
      int status = (event.snapshot.value as int);
      if (isWidgetMounted(context)) {
        _status = status == 1;
        notifyListeners();
      }
    });
  }

  void updateStatusAuto(BuildContext context) {
    _databaseReference
        .child('ESP32/setControl/setAutoMode/pump')
        .onValue
        .listen((event) {
      int statusAuto = (event.snapshot.value as int);
      if (isWidgetMounted(context)) {
        _statusAuto = statusAuto == 1;
        notifyListeners();
      }
    });
  }

  void updateSwitched(BuildContext context) {
    _databaseReference
        .child('ESP32/setControl/setTimerMode/pump')
        .onValue
        .listen((event) {
      int settime = (event.snapshot.value as int);
      if (isWidgetMounted(context)) {
        _isSwitched = (settime == 1);
        notifyListeners();
      }
    });
  }

  void updateSpeedPump(BuildContext context) {
    _databaseReference
        .child('ESP32/setControl/PUMP/speedPump')
        .onValue
        .listen((event) {
      int speedpump = (event.snapshot.value as int);

      if (isWidgetMounted(context)) {
        _speedPump = speedpump;
        notifyListeners();
      }
    });
  }

  void updateSetSoilmoisture(BuildContext context) {
    _databaseReference
        .child('ESP32/setControl/PUMP/setSoilmoilsture')
        .onValue
        .listen((event) {
      int setSoilmoisture = (event.snapshot.value as int);

      if (isWidgetMounted(context)) {
        _setSoilmoisture = setSoilmoisture;
        notifyListeners();
      }
    });
  }

  void updateSoilMoisture(BuildContext context) {
    _databaseReference
        .child('ESP32/views/TrTs/soil_moisture')
        .onValue
        .listen((event) {
      int soilMoisture = (event.snapshot.value as int);

      if (isWidgetMounted(context)) {
        _soilMoisture = soilMoisture;
        notifyListeners();
      }
    });
  }

  void updateTime(BuildContext context) {
    _databaseReference
        .child('ESP32/views/RTC1307/Time')
        .onValue
        .listen((event) {
      var time = event.snapshot.value;

      if (isWidgetMounted(context)) {
        _time = time.toString();
        notifyListeners();
      }
    });
  }
}
