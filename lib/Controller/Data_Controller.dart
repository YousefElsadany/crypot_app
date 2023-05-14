//هذا الملف يتم استخدام الكلاس الموجود فيه من أجل جلب البيانات من ال Api

// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/Cryptodata.dart';
class DataBinding implements Bindings {
// default dependency
 @override
 void dependencies() {
   Get.lazyPut(() => DataController());
 }
}
class DataController extends GetxController {
  // ignore: non_constant_identifier_names
  CryptoDataModel? data_crypto;
  var isDataLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    Timer.periodic(Duration(seconds: 5), (timer) {
    getCryptoInformationFromApi();
  }); 
    
  }

  getCryptoInformationFromApi() async {
    try {
      if (data_crypto == null) {
        isDataLoading(true);
      }
      http.Response response = await http.get(
        Uri.tryParse(
            'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=5')!,
        headers: {'X-CMC_PRO_API_KEY': "5188fa9a-21ca-4c6a-b424-0a022c98536f"},
      );
      if (response.statusCode == 200) {
        /////successfully

        final result = jsonDecode(response.body);

        data_crypto = CryptoDataModel.fromJson(result);
        
        update();
        print(response.statusCode.toString());
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while data getting is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
