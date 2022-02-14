import 'package:shared_preferences/shared_preferences.dart';

class StorageModel {
  final _storage = SharedPreferences.getInstance();

  Future<String> getData() async {
    final storage = await SharedPreferences.getInstance();
    final cursList = storage.getString('curs');
    if (cursList != null) {
      return cursList;
    } else {
      return '';
    }
  }

  Future<void> setData(String stringCurs) async {
    final storage = await _storage;
    storage.setString('curs', stringCurs);
  }

  Future<void> delData() async {
    final storage = await _storage;
    storage.clear();
  }
}
