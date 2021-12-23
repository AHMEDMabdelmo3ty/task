// ignore_for_file: file_names

class GetSemsterDeathChartModel {
  late String msg;
  late List<Data> data;

  GetSemsterDeathChartModel({required this.msg, required this.data});

  GetSemsterDeathChartModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data =  <Data>[];
    json['data'].forEach((v) {
      data.add( Data.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  late String semster;
  late String death;
  late String cases;
  late String killedAndDisposedOf;

  Data({required this.semster, required this.death, required this.cases, required this.killedAndDisposedOf});

  Data.fromJson(Map<String, dynamic> json) {
    semster = json['semster'];
    death = json['death'];
    cases = json['cases'];
    killedAndDisposedOf = json['killedAndDisposedOf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['semster'] = this.semster;
    data['death'] = this.death;
    data['cases'] = this.cases;
    data['killedAndDisposedOf'] = this.killedAndDisposedOf;
    return data;
  }
}
