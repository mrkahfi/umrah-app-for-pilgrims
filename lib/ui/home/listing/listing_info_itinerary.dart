import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/models/listing/itinerary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class ListingInfoIteneraryPage extends StatefulWidget {
  @override
  _ListingInfoIteneraryPageState createState() =>
      _ListingInfoIteneraryPageState();
}

class _ListingInfoIteneraryPageState extends State<ListingInfoIteneraryPage> {
  List<Itineraries> itinerary;

  @override
  Widget build(BuildContext context) {
    itinerary = ModalRoute.of(context).settings.arguments;
    return Theme(
      data: ListAppTheme.buildLightTheme(),
      child: Container(child: _buildInfoItinerary(context)),
    );
  }

  Widget _buildInfoItinerary(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(context),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.88,
                      child: _buildListItinerary(context),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListItinerary(BuildContext context){
    return itinerary.length > 0 
        ? timelineModel(context, TimelinePosition.Left)
        : Container(
          padding: EdgeInsets.only(top: 15, left: 5, right: 5),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Image.asset(
                "assets/images/blank_file.png",
                height: 50,
              ),
              SizedBox(height: 10),
              Text(
                "Belum ada data itinerary",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              )
            ]),
          ));
  }

  Widget getAppBarUI(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ListAppTheme.buildLightTheme().backgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20, left: 10),
                  child: Icon(Icons.close),
                ),
              ),
              Expanded(
                child: Text(
                  "Jadwal Kegiatan",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                width: AppBar().preferredSize.height + 20,
                height: AppBar().preferredSize.height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              )
            ],
          ),
        ));
  }

  timelineModel(BuildContext context, TimelinePosition position) =>
      Timeline.builder(
          itemBuilder: centerTimelineBuilder,
          shrinkWrap: true,
          lineColor: Colors.blueAccent,
          itemCount: itinerary.length,
          physics: position == TimelinePosition.Left
              ? ClampingScrollPhysics()
              : BouncingScrollPhysics(),
          position: position);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final listing = itinerary[i];
    return TimelineModel(
      Card(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 8.0,
              ),
              Text(
                listing.title,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Html(
                data: listing.description,
              ),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
      position:
          i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
      isFirst: i == 0,
      isLast: i == itinerary.length,
      iconBackground: Colors.blueAccent,
      icon: Icon(
        Icons.album,
        color: Colors.white,
        size: 32.0,
      ),
    );
  }
}
