import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:app_jamaah_boilerplate/models/listing/listing.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/listing/listing_store.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchPage extends StatefulWidget {
  // final HomeController _controller = Get.find();
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  final searchController = TextEditingController();
  ListingStore _listingStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _listingStore = Provider.of<ListingStore>(context);
    if (_listingStore.isListingEmpty) _listingStore.getListings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text("Cari Paket"),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 20,
            ),
            _buildSearchBar(context),
            SizedBox(
              height: 10,
            ),
            _buildListingList()
          ],
        ));
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: searchController,
              onChanged: _listingStore.onSearchTextChanged,
              autofocus: false,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  hintText: "Search Here",
                  contentPadding: EdgeInsets.all(10),
                  hintStyle: TextStyle(fontSize: 14),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue)),
                  focusColor: Colors.blue,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    splashColor: Colors.white,
                    hoverColor: Colors.white,
                    onPressed: () {
                      searchController.clear();
                    },
                    color: Colors.blueGrey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey))),
            )),
      ],
    );
  }

  Widget _buildListingList() {
    return Expanded(
        child: searchController.text.isEmpty
            ? _listingStore.isListingEmpty
                ? Container(
                    padding:
                        EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 50),
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                    ))
                : ListView.builder(
                    itemCount: _listingStore.listingListData.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      Listing listing = _listingStore.listingListData[index];
                      return _listingCard(listing);
                    })
            : _listingStore.searchListData.isEmpty
                ? Center(
                    child: Text("Paket Yang Anda cari tidak tersedia"),
                  )
                : ListView.builder(
                    itemCount: _listingStore.searchListData.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      Listing listing = _listingStore.searchListData[index];
                      return _listingCard(listing);
                    }));
  }

  Widget _listingCard(Listing listing) {
    String urlPhoto = listing.pict.url.contains("/image-not-found.png")
        ? "${Endpoints.protocol}${Endpoints.baseUrl}${listing.pict.medium.url}"
        : listing.pict.medium.url;
    return GestureDetector(
      child: Card(
        elevation: 0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: "$urlPhoto",
                height: 180,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 170,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "${listing.name}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.event_note,
                      size: 15,
                      color: Colors.blueGrey[300],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Berangkat ${ConvertVar.dateToConvert(listing.departureAt, "dd MMM yyyy")}",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey[400]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      size: 15,
                      color: Colors.blueGrey[300],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Paket ${listing.days} Hari",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey[400]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.hotel,
                      size: 15,
                      color: Colors.blueGrey[300],
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    RatingBar(
                      initialRating: listing.hotelStar.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 13,
                      ignoreGestures: true,
                      unratedColor: Colors.blueGrey[200],
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.airline_seat_recline_normal,
                      size: 15,
                      color: Colors.blueGrey[300],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    (listing.availableSeats <= 10)
                        ? Text(
                            "Tersisa ${listing.availableSeats} Kursi",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          )
                        : Text(
                            "Tersisa ${listing.availableSeats} Kursi",
                            style: TextStyle(
                                color: Colors.blueGrey[300],
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 12, left: 2),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.blueGrey[300],
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                          children: [
                            TextSpan(text: "Mulai "),
                            TextSpan(
                                text: (listing.currency == "IDR")
                                    ? "${ConvertVar.toSimbolCurrency(listing.currency)} ${ConvertVar.toDecimalMilion(listing.priceStart)} juta"
                                    : "${ConvertVar.toSimbolCurrency(listing.currency)} ${ConvertVar.toDecimal(listing.priceStart)}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))
                          ]),
                    ))
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.listingDetail, arguments: listing.id);
      },
    );
  }
}
