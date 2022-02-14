import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kurs_cash/models/curs_data_model.dart';
import 'package:kurs_cash/models/storage_model.dart';

class CursController extends GetxController {
  var cursList = <CursDataModel>[].obs;
  var isLoading = false.obs;
  final _storeModel = StorageModel();

  @override
  void onInit() async {
    super.onInit();
    await getDataStorage();
    if (!isLoading.value) {
      await getDataApi();
    }
  }

  void addCurs(Map<String, dynamic> data) {
    cursList.clear();
    data.forEach((key, value) {
      CursDataModel _cursModel = CursDataModel.fromJson(value);

      cursList.add(CursDataModel(
          iD: _cursModel.iD,
          charCode: _cursModel.charCode,
          numCode: _cursModel.numCode,
          name: _cursModel.name,
          previous: _cursModel.previous,
          value: _cursModel.value));
    });
  }

  Future<void> getDataApi() async {
    print('getDataApi');
    Dio dio = Dio();
    final response =
        await dio.get('https://www.cbr-xml-daily.ru/daily_json.js');

    if (response.statusCode == 200) {
      Map<String, dynamic> datadecode = jsonDecode(response.data);
      Map<String, dynamic> datadeCurs = (datadecode['Valute']);
      addCurs(datadeCurs);
      _storeModel.setData(response.data);
      isLoading.value = true;
    } else {
      Get.snackbar(
          'Ошибка загрузки данных API', response.statusCode.toString());
    }
  }

  Future<void> getDataStorage() async {
    print('getDataStorage');
    var stringStorage = await _storeModel.getData();
    if (stringStorage != '') {
      var mapStorage = jsonDecode(stringStorage);
      Map<String, dynamic> datadeCurs = (mapStorage['Valute']);
      addCurs(datadeCurs);
      isLoading.value = true;
    }
  }
}
