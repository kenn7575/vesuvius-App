import 'package:device_info_plus/device_info_plus.dart';
//platform
import 'dart:io' show Platform;

Future<String> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    var androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id; // Unique device ID
  } else if (Platform.isIOS) {
    var iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor ?? iosInfo.model; // Unique device ID
  } else if (Platform.isMacOS) {
    var macInfo = await deviceInfo.macOsInfo;
    return macInfo.model; // Unique device ID
  } else if (Platform.isWindows) {
    var windowsInfo = await deviceInfo.windowsInfo;
    return windowsInfo.computerName; // Unique device ID
  } else if (Platform.isLinux) {
    var linuxInfo = await deviceInfo.linuxInfo;
    return linuxInfo.name; // Unique device ID
  } else {
    return 'Unknown device';
  }
}
