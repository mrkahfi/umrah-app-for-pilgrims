import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:global_configuration/global_configuration.dart';

class SaiPage extends StatefulWidget {
  @override
  _SaiPageState createState() => _SaiPageState();
}

int _current = 0;
const List<String> buttonTitles = [
  "Mulai Menuju Shofa",
  "Lanjut ke Marwah",
  "Saya sudah di Marwah",
  "Lanjut ke Shofa",
  "Saya sudah di Shofa",
  "Lanjut ke Marwah",
  "Saya sudah di Marwah",
  "Lanjut ke Shofa",
  "Saya sudah di Shofa",
  "Lanjut ke Marwah",
  "Saya sudah di Marwah",
  "Lanjut ke Shofa",
  "Saya sudah di Marwah",
  "Lanjut ke Marwah",
  "Saya sudah di Marwah",
];

const List<String> messages = [
  null,
  "Lanjut ke Marwah",
  "Saya sudah di Marwah",
  "Lanjut ke Shofa",
  "Saya sudah di Shofa",
  "Lanjut ke Marwah",
  "Saya sudah di Marwah",
  "Lanjut ke Shofa sekarang",
  "Saya sudah di Shofa",
  "Lanjut ke Marwah",
  "Saya sudah di Marwah",
  "Lanjut ke Shofa",
  "Saya sudah di Marwah",
  "Lanjut ke Marwah",
  "Saya sudah di Marwah",
];

class _SaiPageState extends State<SaiPage> {
  List<Widget> items;
  static GlobalConfiguration cfg;
  String buttonTitle = "Mulai";
  CarouselSlider carouselSlider;
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();

    buttonTitle = "Mulai";

    _current = 0;
    cfg = new GlobalConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    items = [
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Ketika Mendekat ke Shofa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa_mulai'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: cfg.getValue('doa_mulai_trans_id'),
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Ketika Berada di Bukit Shofa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Menghadap Ka'bah sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: cfg.getValue('doa_trans_id'),
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Sai 1 : Dari Shofa ke Marwah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa_default'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: "",
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#2",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Ketika Berada di Bukit Marwah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Menghadap Ka'bah sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: cfg.getValue('doa_trans_id'),
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#2",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Sai 2 : Dari Marwah ke Shofa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa_default'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: "",
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#3",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Ketika Berada di Bukit Shofa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Menghadap Ka'bah sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: cfg.getValue('doa_trans_id'),
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#3",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Sai 3 : Dari Shofa ke Marwah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa_default'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: "",
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#4",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Ketika Berada di Bukit Marwah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Menghadap Ka'bah sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: cfg.getValue('doa_trans_id'),
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#4",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Sai 4 : Dari Marwah ke Shofa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa_default'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: "",
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#5",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Ketika Berada di Bukit Shofa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Menghadap Ka'bah sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: cfg.getValue('doa_trans_id'),
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#5",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Sai 5 : Dari Shofa ke Marwah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa_default'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: "",
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#6",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Ketika Berada di Bukit Marwah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Menghadap Ka'bah sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: cfg.getValue('doa_trans_id'),
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#6",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Sai 6 : Dari Marwah ke Shofa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa_default'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: "",
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#7",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Ketika Berada di Bukit Shofa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Menghadap Ka'bah sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: cfg.getValue('doa_trans_id'),
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 15, left: 15, right: 20, bottom: 20),
                    decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0))),
                    child: Text("#7",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.white))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Sai 7 : Dari Shofa ke Marwah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ))),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Sambil membaca",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
            SizedBox(
              height: 20,
            ),
            Html(
              data: cfg.getValue('doa_default'),
              // defaultTextStyle: TextStyle(fontSize: 24, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
            Html(
              data: "",
              // defaultTextStyle: TextStyle(fontSize: 18, color: Colors.black87),
              // padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            ),
          ],
        ),
      ),
    ];

    carouselSlider = CarouselSlider(
        items: items,
        carouselController: buttonCarouselController,
        options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 0.95,
            aspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height * 0.85),
            onPageChanged: (index, reason) {
              print("index: $index");
              setState(() {
                _current = index;
                buttonTitle = buttonTitles[index];
              });
            }));

    Container bottomButton = Container(
      color: Color(0xe2fafafb),
      padding: EdgeInsets.only(left: 20.0, bottom: 20.0, right: 20.0, top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 10.0),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: new LinearGradient(
              colors: [
                Colors.blue,
                Colors.blueAccent,
              ],
              begin: const FractionalOffset(0.2, 0.2),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: MaterialButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.red,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
              child: Text(
                buttonTitle,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            onPressed: () => (carouselSlider != null &&
                    !buttonTitles[_current].contains("sudah"))
                ? _showConfirmationDialog(messages[_current])
                : movePage()),
      ),
    );

    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xe2fafafb),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
                child:
                    Container(color: Color(0xe2fafafb), child: carouselSlider)),
            bottomButton,
            SizedBox(
              height: 20,
            )
          ],
        ));
  }

  static const channel = MethodChannel("com.example.app_jamaah_boilerplate.channel");

  // ignore: missing_return
  Future<String> getSteps() async {
    // ignore: unused_local_variable
    String stepNumber;
    try {
      final String result = await channel.invokeMethod("step");
      stepNumber = "Step  $result";
    } on PlatformException catch (e) {
      print("ERROR ${e.message}");
    }
  }

  void _showConfirmationDialog(String message) {
    if (message != null) {
      String positiveButtonText = 'Lanjut';
      String negativeButtonText = 'Nanti';

      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              content: Text(
                message,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      _dismissDialog();
                      movePage();
                      (positiveButtonText == "Lanjut")
                          ? getSteps()
                          : print(positiveButtonText);
                    },
                    child: Text(positiveButtonText,
                        style: TextStyle(color: Colors.green))),
                FlatButton(
                  onPressed: () {
                    print('belum');
                    _dismissDialog();
                  },
                  child: Text(negativeButtonText,
                      style: TextStyle(color: Colors.red)),
                )
              ],
            );
          });
    } else {
      if (carouselSlider != null) {
        buttonCarouselController.animateToPage(_current < items.length ? _current + 1 : 0,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    }
  }

  void movePage() {
    buttonCarouselController.animateToPage(_current < items.length ? _current + 1 : 0,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  _dismissDialog() {
    Navigator.pop(context);
  }
}
