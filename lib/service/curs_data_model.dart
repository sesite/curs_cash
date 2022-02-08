class CursDataModel {
  String iD;
  String numCode;
  String charCode;
  String name;
  double value;
  double previous;

  CursDataModel(
      {required this.iD,
      required this.numCode,
      required this.charCode,
      required this.name,
      required this.value,
      required this.previous});

  factory CursDataModel.fromJson(Map<String, dynamic> json) {
    //print(json);
    return CursDataModel(
      iD: json['ID'],
      numCode: json['NumCode'],
      charCode: json['CharCode'],
      name: json['Name'],
      value: json['Value'],
      previous: json['Previous'],
    );
  }
}
