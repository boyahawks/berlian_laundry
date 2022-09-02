import 'package:berlian_laundry/utils/Local_storage.dart';

class AppData {
  static set statusLogin(bool value) =>
      LocalStorage().saveToDisk(key: 'statusLogin', value: value);

  static bool get statusLogin {
    if (LocalStorage().getFromDisk(key: 'statusLogin') != null) {
      return LocalStorage().getFromDisk(key: 'statusLogin');
    }
    return false;
  }

  static set username(String value) =>
      LocalStorage().saveToDisk(key: 'username', value: value);

  static String get username {
    if (LocalStorage().getFromDisk(key: 'username') != null) {
      return LocalStorage().getFromDisk(key: 'username');
    }
    return "";
  }

  static set email(String value) =>
      LocalStorage().saveToDisk(key: 'email', value: value);

  static String get email {
    if (LocalStorage().getFromDisk(key: 'email') != null) {
      return LocalStorage().getFromDisk(key: 'email');
    }
    return "";
  }
}
