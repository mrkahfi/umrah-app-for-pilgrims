import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart';

class ConvertVar {
  static String dateToConvert(String dateConvert, String format) {
    String tgl = dateConvert.split('T')[0];
    int year = int.parse(tgl.split("-")[0]);
    int month = int.parse(tgl.split("-")[1]);
    int day = int.parse(tgl.split("-")[2]);
    final depart = DateTime(year, month, day);
    var formatterr = new DateFormat('$format');

    return formatterr.format(depart);
  }

  static String dateTimeToConvert(String dateConvert) {
    List tgl = dateConvert.split('T');
    int year = int.parse(tgl[0].split("-")[0]);
    int month = int.parse(tgl[0].split("-")[1]);
    int day = int.parse(tgl[0].split("-")[2]);
    int hour = int.parse(tgl[1].split(":")[0]);
    int minute = int.parse(tgl[1].split(":")[1]);

    final depart = DateTime(year, month, day, hour, minute);
    final nowTime = DateTime.now();
    var formatNow = new DateFormat("dd");
    var formattDay = new DateFormat('dd');
    // var formatterr = new DateFormat('hh:mm');
    if (formatNow.format(nowTime) == formattDay.format(depart)) {
      return "$hour:$minute";
    }

    var formatt = new DateFormat('dd MMM');
    return formatt.format(depart);
  }

  static Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  static String convertUrlPhoto(String pict) {
    String url = pict.contains("/image-not-found.png")
        ? "${Endpoints.protocol}${Endpoints.baseUrl}$pict"
        : pict;
    return url;
  }

  static String dateToStringConvert(DateTime date, String format) {
    var formatterr = new DateFormat('$format');
    return formatterr.format(date);
  }

  static String toSimbolCurrency(String currency) {
    Map<String, dynamic> cSimbol = Map<String, dynamic>();
    cSimbol.addAll({"IDR": "Rp"});
    cSimbol.addAll({"USD": '\$'});

    return cSimbol[currency];
  }

  static String toDecimal(int decimal) {
    NumberFormat curr = new NumberFormat("#,###", "en_ID");
    return curr.format(decimal).toString();
  }

  static String toDecimalMilion(int decimal) {
    NumberFormat curr = new NumberFormat("#,###", "en_ID");
    return curr.format(decimal / 1000000).toString();
  }

  static String parseHtmlString(String htmlString) {
    var document = parse(htmlString);
    String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
  }
}
