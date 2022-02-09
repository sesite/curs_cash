import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kurs_cash/service/curs_data_model.dart';

class CursController extends GetxController {
  var cursList = <CursDataModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Dio dio = Dio();
  Future<void> getData() async {
    final response =
        await dio.get('https://www.cbr-xml-daily.ru/daily_json.js');
    if (response.statusCode == 200) {
      Map<String, dynamic> datadecode = jsonDecode(response.data);
      Map<String, dynamic> datadecode1 = (datadecode['Valute']);
      datadecode1.forEach((key, value) {
        CursDataModel _cursModel = CursDataModel.fromJson(value);

        cursList.add(CursDataModel(
            iD: _cursModel.iD,
            charCode: _cursModel.charCode,
            numCode: _cursModel.numCode,
            name: _cursModel.name,
            previous: _cursModel.previous,
            value: _cursModel.value));
      });
      isLoading.value = true;
    } else {
      Get.snackbar(
          'Ошибка загрузки данных API', response.statusCode.toString());
    }
  }
}
