import 'package:app_jamaah_boilerplate/models/quran/surah.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/quran/quran_store.dart';
import 'package:app_jamaah_boilerplate/ui/quran/quran_detail.dart';
import 'package:app_jamaah_boilerplate/utils/remove_glow.dart';
import 'package:app_jamaah_boilerplate/widgets/base_app.dart';
import 'package:app_jamaah_boilerplate/widgets/base_asset.dart';
import 'package:app_jamaah_boilerplate/widgets/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class QuranPage extends StatefulWidget {
  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  var _appBarHeight = 0.0, _statusBarHeight = 0.0;

  QuranStore _quranStore;
  final searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _quranStore = Provider.of<QuranStore>(context);
    if (_quranStore.isSurahsEmpty) {
      _quranStore.getSurahs();
    }
  }

  @override
  Widget build(BuildContext context) {
    _statusBarHeight = MediaQuery.of(context).padding.top;
    _appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, scrolling) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              backgroundColor: Colors.lightBlueAccent,
              elevation: 0,
              pinned: true,
              expandedHeight: 260,
              forceElevated: scrolling,
              leading: BackButton(color: Colors.white),
              flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.black),
                    foregroundDecoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(BaseAsset.bgPictures),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: _appBarHeight + _statusBarHeight + Size.size24,
                        left: Size.size16,
                        right: Size.size16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Al-Qur'an",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 56,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ),
        ];
      },
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: _appBarHeight),
            child: ScrollConfiguration(
                behavior: RemoveGlow(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: 40, bottom: 7, left: 5, right: 5),
                        child: Row(
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
                                        child: new Text("Surat"),
                                        textColor:
                                            _quranStore.selectedButton == 1
                                                ? Colors.white
                                                : Colors.black,
                                        color: _quranStore.selectedButton == 1
                                            ? Colors.lightBlueAccent
                                            : Colors.grey[100],
                                        onPressed: () =>
                                            _quranStore.setSelectionTab(1),
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0)),
                                      )),
                                );
                              },
                            ),
                            SizedBox(width: 5),
                            Observer(
                              builder: (context) {
                                return Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Container(
                                      width: 200,
                                      height: 40,
                                      child: new FlatButton(
                                        child: new Text("Tersimpan"),
                                        textColor:
                                            _quranStore.selectedButton == 2
                                                ? Colors.white
                                                : Colors.black,
                                        color: _quranStore.selectedButton == 2
                                            ? Colors.lightBlueAccent
                                            : Colors.grey[100],
                                        onPressed: () {
                                          _quranStore.getBookmarkList();
                                          _quranStore.setSelectionTab(2);
                                        },
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    30.0)),
                                      )),
                                );
                              },
                            ),
                          ],
                        )),
                    _buildSearchBar(context),
                    Expanded(
                      child: Observer(builder: (_) {
                        return _quranStore.loadingSurah
                            ? Center(
                                child: SpinKitWave(
                                  color: Colors.blue[300],
                                  type: SpinKitWaveType.center,
                                  size: 30,
                                ),
                              )
                            : _quranStore.selectedButton == 2 &&
                                    _quranStore.surahListBookmark != null
                                ? ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount:
                                        _quranStore.surahListBookmark.length,
                                    itemBuilder: (context, index) => itemSurat(
                                        _quranStore.surahListBookmark, index),
                                  )
                                : searchController.text.isEmpty
                                    ? ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount:
                                            _quranStore.surahListData.length,
                                        itemBuilder: (context, index) =>
                                            itemSurat(_quranStore.surahListData,
                                                index),
                                      )
                                    : _quranStore.isSearchListEmpty
                                        ? Center(
                                            child: Text(
                                                "Surat Yang Anda cari tidak ditemukan"),
                                          )
                                        : ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount: _quranStore
                                                .searchSurahList.length,
                                            itemBuilder: (context, index) =>
                                                itemSurat(
                                                    _quranStore.searchSurahList,
                                                    index),
                                          );
                      }),
                    )
                  ],
                )),
          ),
        ],
      ),
    ));
    // );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Observer(builder: (context) {
      return _quranStore.selectedButton == 1
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: searchController,
                      onChanged: _quranStore.onSearchTextChanged,
                      autofocus: false,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          hintText: "Cari Surat",
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
            )
          : Container();
    });
  }

  Widget itemSurat(List<DataSurah> listQuran, int index) {
    return Container(
      color: (index % 2 == 0) ? Colors.white : Colors.grey[100],
      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
      child: InkWell(
        onTap: () {
          _quranStore.setSelectionTab(1);
          Navigator.pushNamed(context, Routes.quranDetail,
              arguments: QuranArguments(
                  titleSurah: listQuran[index].englishName,
                  surahId: listQuran[index].number));
        },
        child: Container(
          margin: EdgeInsets.all(Size.size16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  styleText(listQuran[index].englishName, Size.size16,
                      Colors.black, FontWeight.normal, 1, null),
                  styleText(
                      listQuran[index].englishNameTranslation +
                          ' | ' +
                          "${listQuran[index].numberOfAyahs}" +
                          ' ayat',
                      Size.size12,
                      Colors.grey,
                      FontWeight.normal,
                      2,
                      null),
                ],
              ),
              Spacer(),
              (_quranStore.selectedButton == 2)
                  ? Center(
                      child: Text(
                          "Ayat ke ${_quranStore.surahListBookmark[index].indexAyah + 1}"),
                    )
                  : Container(
                      height: Size.size40,
                      child: Image.asset(BaseAsset.imagesSurat[index]),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
