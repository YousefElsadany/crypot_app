// ignore_for_file: override_on_non_overriding_member, non_constant_identifier_names, duplicate_ignore

import 'dart:async';
import 'dart:math';

import 'package:chess/Controller/Data_Controller.dart';
import 'package:chess/model/Chart_Data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Components/List_Comp.dart';
import 'Components/linechart_comp.dart';
import 'model/Crypto_Data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// ignore: duplicate_ignore
class _MyHomePageState extends State<MyHomePage> {
  // ignore: non_constant_identifier_names
  int CryptoType = 4;
  // ignore: non_constant_identifier_names
  int DateType = 0;
  //قائمة من عناصر الاوبجيكت Crypto_Data
  late List<Crypto_Data> dataa = [
    Crypto_Data('assets/images/btc.png', 'name', 'Discription', 3221, 2131,
        231.1, true),
    Crypto_Data('assets/images/sol.png', 'name', 'Discription', 3221, 2131,
        231.1, true),
    Crypto_Data('assets/images/avax.png', 'name', 'Discription', 3221, 2131,
        231.1, false),
    Crypto_Data('assets/images/ether.png', 'name', 'Discription', 3221, 2131,
        231.1, true),
    Crypto_Data('assets/images/uni.png', 'name', 'Discription', 3221, 2131,
        231.1, false),
  ];
  //قائمة من عناصر الأوبجكت Chart_Data_day
  late List<Chart_Data_Day> data, data2, data3, data4, data5;

// ignore: override_on_non_overriding_member
  @override
//هذا التابع مستخدم  لتوليد قيم عشوائة على اسعار العملات
  void change_value(int index) {
    dataa[index].price = dataa[index].price + Random().nextDouble();
    dataa[index].price_down = dataa[index].price_down + Random().nextDouble();
    dataa[index].price_up = dataa[index].price_up + Random().nextDouble();
    data[index].price = data[index].price + Random().nextDouble();
  }

  @override
  void initState() {
    super.initState();
    // هذا التابع من أجل تحديد مدة استدعاء التابع change_value
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        change_value(0);
        change_value(1);
        change_value(2);
        change_value(3);
        change_value(4);
      });
    });
    data = [
      Chart_Data_Day(200, 1),
      Chart_Data_Day(100, 2),
      Chart_Data_Day(250, 3),
      Chart_Data_Day(300, 4),
      Chart_Data_Day(500, 5),
      Chart_Data_Day(400, 6),
      Chart_Data_Day(1000, 7),
      Chart_Data_Day(600, 8),
      Chart_Data_Day(600, 9),
      Chart_Data_Day(1000, 10),
    ];
    data2 = [
      Chart_Data_Day(500, 1),
      Chart_Data_Day(400, 2),
      Chart_Data_Day(600, 3),
      Chart_Data_Day(1000, 4),
      Chart_Data_Day(200, 5),
      Chart_Data_Day(100, 6),
      Chart_Data_Day(250, 7),
      Chart_Data_Day(300, 8),
      Chart_Data_Day(100, 9),
      Chart_Data_Day(250, 10),
    ];
    data3 = [
      Chart_Data_Day(200, 1),
      Chart_Data_Day(300, 2),
      Chart_Data_Day(100, 3),
      Chart_Data_Day(700, 4),
      Chart_Data_Day(800, 5),
      Chart_Data_Day(290, 6),
      Chart_Data_Day(10, 7),
      Chart_Data_Day(400, 8),
      Chart_Data_Day(800, 9),
      Chart_Data_Day(950, 10),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DataController());
    // controller.getCryptoInformationFromApi();
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),

        body:
            //  GetBuilder(
            //     init: DataController(),
            //     builder: (DataController controller) {
            //       return 
            controller.isDataLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      :
            Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Profits',
              style: TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(
                controller.data_crypto!.data!.length,
                (index) => TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: CryptoType == index
                            ? Colors.blue.shade50
                            : Colors.white),
                    onPressed: () {
                      setState(() {
                        CryptoType = index;
                      });
                    },
                    child: Text(
                      controller.data_crypto!.data![index].name!,
                      style: TextStyle(
                          color:
                              CryptoType == index ? Colors.blue : Colors.black),
                    )),
              ),
            ),
            // هنا قمنا باستدعا الكلاس LineChart ووضعه في ال Container
            Container(
              alignment: Alignment.center,
              child: LineChart(controller
              .data_crypto!.data![CryptoType].quote!.uSD!),
            ),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            DateType == 5 ? Colors.blue.shade50 : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          DateType = 5;
                        });
                      },
                      child: Text(
                        'all',
                        style: TextStyle(
                            color: DateType == 5 ? Colors.blue : Colors.black),
                      )),
                ),
                Expanded(
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: DateType == 4
                              ? Colors.blue.shade50
                              : Colors.white),
                      onPressed: () {
                        setState(() {
                          DateType = 4;
                        });
                      },
                      child: Text(
                        'years 5',
                        style: TextStyle(
                            color: DateType == 4 ? Colors.blue : Colors.black),
                      )),
                ),
                Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: DateType == 3
                                ? Colors.blue.shade50
                                : Colors.white),
                        onPressed: () {
                          setState(() {
                            DateType = 3;
                          });
                        },
                        child: Text(
                          'One year',
                          style: TextStyle(
                              color:
                                  DateType == 3 ? Colors.blue : Colors.black),
                        ))),
                Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: DateType == 2
                                ? Colors.blue.shade50
                                : Colors.white),
                        onPressed: () {
                          setState(() {
                            DateType = 2;
                          });
                        },
                        child: Text(
                          'months 3',
                          style: TextStyle(
                              color:
                                  DateType == 2 ? Colors.blue : Colors.black),
                        ))),
                Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: DateType == 0
                                ? Colors.blue.shade50
                                : Colors.white),
                        onPressed: () {
                          setState(() {
                            DateType = 0;
                          });
                        },
                        child: Text(
                          'months 1',
                          style: TextStyle(
                              color:
                                  DateType == 0 ? Colors.blue : Colors.black),
                        ))),
                Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: DateType == 1
                                ? Colors.blue.shade50
                                : Colors.white),
                        onPressed: () {
                          setState(() {
                            DateType = 1;
                          });
                        },
                        child: Text(
                          'day',
                          style: TextStyle(
                              color:
                                  DateType == 1 ? Colors.blue : Colors.black),
                        ))),
              ],
            ),
            // Padding(
            //   padding:
            //       EdgeInsets.symmetric(horizontal: 20, vertical: 0.0),
            //   child: Row(
            //     children: [
            //       Padding(
            //           padding: EdgeInsets.symmetric(
            //               horizontal: 20, vertical: 0.0),
            //           child: Text(
            //             'profits',
            //             style: TextStyle(
            //                 color: Colors.green, fontSize: 20),
            //           )),
            //       Text(
            //         'losses',
            //         style: TextStyle(color: Colors.red, fontSize: 20),
            //       ),
            //     ],
            //   ),
            // ),
            //هنا قمنا باستدعاء element ليكون العنصر في القائمة

            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) =>
                  element(controller.data_crypto!.data!, index),
              itemCount: controller.data_crypto!.data!.length,
            )),
          ],
        ),
        // }),
        // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}
