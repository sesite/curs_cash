import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurs_cash/controllers/curs_controller.dart';
import 'package:kurs_cash/pages/calc_form.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cursController = Get.find<CursController>();

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
              child: CalcForm(),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Курсы валют',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showSettingsPanel();
            },
            icon: const Icon(Icons.calculate, color: Colors.white),
          ),
        ],
      ),
      body: Obx(
        () => !_cursController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: ListView.builder(
                  itemCount: _cursController.cursList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Text(_cursController.cursList[index].numCode),
                        title: Text(_cursController.cursList[index].charCode),
                        subtitle: Text(_cursController.cursList[index].name),
                        trailing: Text(
                            _cursController.cursList[index].value.toString()),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
