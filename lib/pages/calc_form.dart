import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kurs_cash/controllers/curs_controller.dart';

class CalcForm extends StatefulWidget {
  CalcForm({Key? key}) : super(key: key);

  @override
  State<CalcForm> createState() => _CalcFormState();
}

class _CalcFormState extends State<CalcForm> {
  final _cursController = Get.find<CursController>();
  late String _currentSumma = '0';
  late String _currentSumma2 = _cursController.cursList[10].value.toString();
  late double _currentSumma3 = 0;

  void summa() {
    _currentSumma3 = double.parse(
        (double.parse(_currentSumma) / double.parse(_currentSumma2))
            .toStringAsFixed(4));
  }

  @override
  Widget build(BuildContext context) {
    initState() {
      super.initState();
      summa();
    }

    return Form(
      child: Obx(
        () => Column(
          children: [
            const Text(
              'Конвертирование валют',
              style: TextStyle(fontSize: 22.0),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                        hintText: 'Введите сумму в рублях'),
                    validator: (val) =>
                        val!.isEmpty ? 'Пожалуйста, введите сумму' : null,
                    onChanged: (val) => setState(() => {
                          _currentSumma = val,
                          summa(),
                        }),
                  ),
                ),
                /* const SizedBox(width: 10), */
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(child: Text('Результат ')),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                  _currentSumma3.toString(),
                  maxLines: 1,
                )),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField(
                    value: _cursController.cursList[10].value.toString(),
                    /* items: [
                      DropdownMenuItem(
                          value: _cursController.cursList[10].charCode,
                          child: Text(_cursController.cursList[10].charCode)),
                      DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                      DropdownMenuItem(value: 'GBP', child: Text('GBP')),
                    ], */
                    items: _cursController.cursList.map((item) {
                      return DropdownMenuItem(
                        value: item.value.toString(),
                        child: Text(item.charCode),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => {
                          _currentSumma2 = val.toString(),
                          summa(),
                        }),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
