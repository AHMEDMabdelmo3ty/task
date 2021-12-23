// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:task/model/GetSemsterDeathChartModel.dart';
import 'package:task/remote_network/cach_helper.dart';
import 'package:task/remote_network/dio_helper.dart';

class BarChartAPI extends StatefulWidget {
  const BarChartAPI({Key? key}) : super(key: key);

  @override
  State<BarChartAPI> createState() => _BarChartAPIState();
}

class _BarChartAPIState extends State<BarChartAPI> {
   List<Data> genders=[];
   bool loading = true;

  @override
  void initState() {
    super.initState();
    getData('Najran');
  }
// دا الفنكشن الخاصه بجلب البيانات
  void getData(city) async {
    var response = await http.get(
        Uri.parse(
            'https://animals.a3rff.com/api/Animals/GetSemsterDeathChart?city'
                //هنا لو عاوز تضيف بلد مثلا هتعمل كدا
                + city

        ),
        headers: {
          "Authorization": "Bearer " + CacheHelper.getData('token'),



        },).then((value) {
      GetSemsterDeathChartModel tempdata =
      GetSemsterDeathChartModel.fromJson(json.decode(value.body));
      setState(() {
        genders = tempdata.data;
        loading = false;


      });
    });
   ;

  }
  // دا ياسطا الجزء الخاص بالرسم البيانى
   List<charts.Series<Data, String>> _createSampleData() {
     return [
       // دا الجزء الخاص بالعمود
       charts.Series<Data, String>(
         data: genders,
         id: 'sales',
         colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
         //دا الاسم بتاع العمود
         domainFn: (Data genderModel, _) => genderModel.semster,
         // دا العدد
         measureFn: (Data genderModel, _) => int.parse(genderModel.cases),
       ),

       charts.Series<Data, String>(
         data: genders,
         id: 'sales',
         colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
         domainFn: (Data genderModel, _) => '',
         measureFn: (Data genderModel, _) => int.parse(genderModel.death),
       ),
     ];
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar Chart"),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          child: charts.BarChart(
            _createSampleData(),
            animate: true,
          ),
        ),
      ),
    );
  }
}