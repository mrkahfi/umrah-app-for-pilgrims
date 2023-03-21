import 'dart:collection';

import 'package:app_jamaah_boilerplate/ui/manasik/sai.dart';
import 'package:app_jamaah_boilerplate/ui/manasik/thawaf.dart';
import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class ManasikPage extends StatefulWidget {
  @override
  _ManasikPageState createState() => _ManasikPageState();
}

class _ManasikPageState extends State<ManasikPage> {
  List<Map<String, String>> _manasiks = [];
  List<StatefulWidget> _pages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
                    "Panduan Ibadah Manasik",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 0)),
                  Text(
                    "Serangkaian manasik dan ibadah-ibadah selama di tanah suci",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 0)),
                ],
              )),
          Container(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: _manasiks.length > 0
                        ? timelineModel(TimelinePosition.Left)
                        : Container(),
                  ),
                ],
              ))
        ]));
  }

  // static GlobalConfiguration cfg;

  var selectedButton = 1;

  @override
  void initState() {
    super.initState();
    // cfg = new GlobalConfiguration();
    Map<String, String> manasik = HashMap();
    manasik["title"] = "Berniat Ihram di Miqat";
    manasik["subtitle"] = "";
    manasik["icon"] = "ic_ihram.png";
    _manasiks.add(manasik);
    _pages.add(null);

    manasik = HashMap();
    manasik["title"] = "Tawaf Mengelilingi Kabah";
    manasik["subtitle"] = "Wajib suci";
    manasik["icon"] = "manasik_icon.png";
    _manasiks.add(manasik);
    _pages.add(new ThawafPage());

    manasik = HashMap();
    manasik["title"] = "Sai antara Sofa dan Marwah";
    manasik["subtitle"] = "Dianjurkan suci";
    manasik["icon"] = "ic_manasik_sai.png";
    _manasiks.add(manasik);
    _pages.add(new SaiPage());

    manasik = HashMap();
    manasik["title"] = "Tahallul / Bercukur";
    manasik["subtitle"] = "";
    manasik["icon"] = "ic_bald.png";
    _manasiks.add(manasik);
    _pages.add(null);
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      lineColor: Colors.blueAccent,
      itemCount: 4,
      physics: position == TimelinePosition.Left
          ? ClampingScrollPhysics()
          : BouncingScrollPhysics(),
      position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    Map<String, String> manasik = _manasiks[i];
    String icon = "assets/images/${manasik["icon"]}";
    return TimelineModel(
      GestureDetector(
        onTap: () => _pages[i] != null
            ? Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => _pages[i]))
            : null,
        child: Card(
          elevation: 0,
          margin: EdgeInsets.symmetric(vertical: 16.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 8.0,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(manasik["title"],
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                      color: i == 1 || i == 2
                                          ? Colors.black
                                          : Colors.grey))),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(manasik["subtitle"],
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: i == 1 || i == 2
                                      ? Colors.blueAccent
                                      : Colors.grey)),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                      Image.asset(
                        icon,
                        height: 60,
                        width: 60,
                      )
                    ])),
          ),
        ),
      ),
      position:
          i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
      isFirst: i == 0,
      isLast: i == 4,
      iconBackground: i == 1 || i == 2 ? Colors.blueAccent : Colors.grey,
      icon: Icon(
        Icons.album,
        color: Colors.white,
        size: 32.0,
      ),
    );
  }
}
