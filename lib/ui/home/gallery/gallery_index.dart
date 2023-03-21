import 'package:app_jamaah_boilerplate/models/gallery/gallery.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/gallery/gallery_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class GalleryIndexPage extends StatefulWidget {
  @override
  _GalleryIndexPageState createState() => _GalleryIndexPageState();
}

class _GalleryIndexPageState extends State<GalleryIndexPage> {
  GalleryStore _galleryStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _galleryStore = Provider.of<GalleryStore>(context);

    if (_galleryStore.isTestimonialEmpty) _galleryStore.getTestimonials();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 3;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        primary: true,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Galeri dan Testimoni",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 0)),
                  Text(
                    "Berikut testimoni dan foto-foto perjalanan jamaah selama umrah",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 0)),
                  Row(
                    children: <Widget>[
                      Observer(
                        builder: (context) {
                          return Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                                width: 200,
                                height: 40,
                                child: new FlatButton(
                                  child: new Text("Galeri"),
                                  textColor: _galleryStore.selectedButton == 1
                                      ? Colors.white
                                      : Colors.black,
                                  color: _galleryStore.selectedButton == 1
                                      ? Colors.blue
                                      : Colors.white,
                                  onPressed: () =>
                                      _galleryStore.setSelectionTab(1),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                )),
                          );
                        },
                      ),
                      SizedBox(width: 10),
                      Observer(
                        builder: (context) {
                          return Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                                width: 200,
                                height: 40,
                                child: new FlatButton(
                                  child: new Text("Testimoni"),
                                  textColor: _galleryStore.selectedButton == 2
                                      ? Colors.white
                                      : Colors.black,
                                  color: _galleryStore.selectedButton == 2
                                      ? Colors.blue
                                      : Colors.white,
                                  onPressed: () =>
                                      _galleryStore.setSelectionTab(2),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                )),
                          );
                        },
                      ),
                    ],
                  )
                ],
              )),
          SizedBox(height: 20),
          Observer(
            builder: (context) {
              return _galleryStore.loadingTestimonial
                  ? Center(
                      child: SpinKitWave(
                        color: Colors.blue[300],
                        type: SpinKitWaveType.center,
                        size: 30,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 10, right: 20),
                      child: _galleryStore.galleryListSelected.length != 0
                          ? GridView.count(
                              crossAxisCount: 3,
                              physics: BouncingScrollPhysics(),
                              childAspectRatio: itemWidth / itemHeight,
                              shrinkWrap: true,
                              children: List.generate(
                                  _galleryStore.galleryListSelected.length,
                                  (index) {
                                Gallery item =
                                    _galleryStore.galleryListSelected[index];
                                return Padding(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 5,
                                        bottom: 10),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed(Routes.galleryDetail, arguments: item.pict.url);
                                        },
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image: item.pict.url,
                                              height: 1000,
                                              fit: BoxFit.cover,
                                            ))));
                              }))
                          : Padding(
                              padding: EdgeInsets.all(100),
                              child: Column(children: <Widget>[
                                Image.asset(
                                  "assets/images/blank_file.png",
                                  height: 50,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Belum ada item",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                )
                              ]),
                            ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
