//هذا الملف يحتوي على كلاس ويدجيت لبناء المخطط

import 'package:flutter/material.dart';
//هذه الباكج من خلالها نولد المخططات
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/Chart_Data.dart';
import '../model/Cryptodata.dart';

// ignore: non_constant_identifier_names
Widget LineChart(USD dataa) {
  dynamic next(x, y) => y - x;
  var data = [
    Chart_Data_Day(next(110.0, 140.0), 1),
    Chart_Data_Day(next(9.0, 41.0), 2),
    Chart_Data_Day(next(140.0, 200.0), 3),
    Chart_Data_Day(dataa.percentChange24h, 4),
    Chart_Data_Day(dataa.percentChange1h, 5),
    Chart_Data_Day(next(110.0, 140.0), 6),
    Chart_Data_Day(next(9.0, 41.0), 7),
    Chart_Data_Day(next(140.0, 200.0), 8),
    Chart_Data_Day(dataa.percentChange24h, 9),
    Chart_Data_Day(dataa.percentChange1h, 10),
    Chart_Data_Day(next(110.0, 140.0), 12),
    Chart_Data_Day(next(9.0, 41.0), 13),
    Chart_Data_Day(dataa.percentChange1h, 14),
    Chart_Data_Day(next(9.0, 41.0), 15),
    Chart_Data_Day(next(140.0, 200), 16),
    Chart_Data_Day(dataa.percentChange24h, 17),
    Chart_Data_Day(dataa.percentChange1h, 18),
    Chart_Data_Day(next(110.0, 140.0), 19),
    Chart_Data_Day(next(9.0, 41.0), 20),
    Chart_Data_Day(next(140.0, 200.0), 21),
    Chart_Data_Day(dataa.percentChange24h, 22),
    Chart_Data_Day(next(110.0, 140.0), 23),
  ];
  return Center(
    child: SfCartesianChart(
      margin: const EdgeInsets.all(20),
      borderColor: Colors.transparent,
      borderWidth: 0,
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        maximum: 10,
        minimum: 1,
        interval: 1,
        isVisible: true,
        borderColor: Colors.transparent,
        borderWidth: 0,
      ),
      primaryYAxis: NumericAxis(
        // maximum: 10000,//أقصى حجم
        // minimum: 100,//أصغر حجم
        // interval: 10,//تقسيم البيانات كل 10
        isVisible: false,
        borderColor: Colors.transparent,
        borderWidth: 0,
      ),
      series: <ChartSeries<Chart_Data_Day, int>>[
        SplineAreaSeries(
            dataSource: data,
            borderWidth: 2,
            borderColor: Colors.blue,
            isVisible: true,
            markerSettings: const MarkerSettings(
              color: Colors.black,
              borderWidth: 4,
              isVisible: true,
            ),
            xValueMapper: (Chart_Data_Day data, _) =>
                data.day, //استخدمنا كلاس Chart_Data_Day الموجود في مجلد Model
            yValueMapper: (Chart_Data_Day data, _) => data.price,
            splineType: SplineType.natural,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade50,
                  Colors.white,
                ]))
      ],
    ),
  );
}
