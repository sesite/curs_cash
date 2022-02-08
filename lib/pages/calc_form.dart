import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurs_cash/controllers/curs_controller.dart';

class CalcForm extends StatefulWidget {
  CalcForm({Key? key}) : super(key: key);

  @override
  State<CalcForm> createState() => _CalcFormState();
}

class _CalcFormState extends State<CalcForm> {
  late String _currentSumma = '0';

  @override
  Widget build(BuildContext context) {
    final _cursController = Get.find<CursController>();
    return Form(
      child: Obx(
        () => Column(
          children: [
            Text(
              'Конвертирование валют',
              style: TextStyle(fontSize: 22.0),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Введите сумму'),
                    validator: (val) =>
                        val!.isEmpty ? 'Пожалуйста, введите сумму' : null,
                    onChanged: (val) => setState(() => _currentSumma = val),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField(
                    value: _cursController.cursList[10].charCode,
                    items: [
                      DropdownMenuItem(
                          value: _cursController.cursList[10].charCode,
                          child: Text(_cursController.cursList[10].charCode)),
                      DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                      DropdownMenuItem(value: 'GBP', child: Text('GBP')),
                    ],
                    onChanged: (Object? value) {},
                  ),
                )
              ],
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                const Expanded(child: Text('Результат ')),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                  _currentSumma,
                  maxLines: 1,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
