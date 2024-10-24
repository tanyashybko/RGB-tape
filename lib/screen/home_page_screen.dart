import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothService {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? targetCharacteristic;

  get characteristics => null;

  Future<void> connectToDevice() async {
    // Начинаем сканирование устройств
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    // Слушаем результаты сканирования
    flutterBlue.scanResults.listen((results) async {
      for (ScanResult r in results) {
        if (r.device.name == "MyLEDDevice") {
          connectedDevice = r.device;
          await connectedDevice!.connect();  // Подключаемся к устройству
          await discoverServices();          // Открываем сервисы и находим нужную характеристику
          break;
        }
      }
    });

    flutterBlue.stopScan(); // Останавливаем сканирование
  }

  Future<void> discoverServices() async {
    if (connectedDevice != null) {
      // Получаем список сервисов устройства
      List<BluetoothService> services = (await connectedDevice!.discoverServices()).cast<BluetoothService>();
      for (BluetoothService service in services) {
        // Проходим по всем характеристикам каждого сервиса
        for (BluetoothCharacteristic c in service.characteristics) {
          if (c.uuid == Guid("YOUR_CHARACTERISTIC_UUID")) {  // Замените на нужный UUID
            targetCharacteristic = c;
            break;
          }
        }
      }
    }
  }

  void sendColorToLedStrip(Color color) {
    if (connectedDevice != null && targetCharacteristic != null) {
      // Преобразуем цвет в строку формата "R,G,B\n"
      String command = "${color.red},${color.green},${color.blue}\n";
      List<int> data = utf8.encode(command);  // Кодируем строку в байты

      // Отправляем данные на устройство через характеристику
      targetCharacteristic!.write(data, withoutResponse: true);
    }
  }
}
