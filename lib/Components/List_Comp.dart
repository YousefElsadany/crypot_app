// ignore_for_file: file_names
// هذا الملف لبناء العنصر داخل القائمة
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chess/model/Crypto_Data.dart';

import 'package:flutter/material.dart';

import '../model/Cryptodata.dart';

Widget element(List<Data> data, int index) {
  var coinIconUrl =
      "https://raw.githubusercontent.com/spothq/cryptocurrency-icons/master/128/color/";
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                // ignore: prefer_interpolation_to_compose_strings
                "\$" +
                    (data[index].quote!.uSD!.price.toDouble() )
                        .toStringAsFixed(2),
                style: const TextStyle(
                    color: Colors.green, fontWeight: FontWeight.w500),
              ),
              // Text(data[index].value?'+${data[index].price_down.round()}':'-${data[index].price_down.round()}',
              //     style: TextStyle(color: data[index].value?Colors.green:Colors.red)),
            ],
          ),
        ),
        Expanded(
            child: Text(
          data[index].quote!.uSD!.percentChange7d.toStringAsFixed(2) +
              "%".toString(),
          style: TextStyle(
            color: data[index].quote!.uSD!.percentChange7d >= 0
                ? Colors.green
                : Colors.red,
          ),
        )),

        Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${data[index].symbol!}USD',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text('${data[index].name!.toUpperCase()}/US DOLLAR'),
            ],
          ),
        ),
        // ignore: avoid_unnecessary_containers
        Container(
          height: 40.0,
          width: 40.0,
          child: CachedNetworkImage(
            imageUrl:
                (("$coinIconUrl${data[index].symbol!}.png").toLowerCase()),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/btc.png',
              scale: 3,
            ),
          ),
        ),
      ],
    ),
  );
}
