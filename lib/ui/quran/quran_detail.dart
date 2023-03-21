import 'dart:io';

import 'package:app_jamaah_boilerplate/models/quran/ayah.dart';
import 'package:app_jamaah_boilerplate/models/quran/ayah_translate.dart';
import 'package:app_jamaah_boilerplate/models/quran/surah.dart';
import 'package:app_jamaah_boilerplate/stores/quran/quran_store.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:app_jamaah_boilerplate/widgets/base_app.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class QuranArguments {
  final String titleSurah;
  final int surahId;

  QuranArguments({this.titleSurah, this.surahId});
}

class QuranDetailPage extends StatefulWidget {
  @override
  _QuranDetailPageState createState() => _QuranDetailPageState();
}

class _QuranDetailPageState extends State<QuranDetailPage> {
  bool isPlay = false;
  bool updateIsSaved;
  int indexPlay;
  int updateIndexSave;
  QuranStore _quranStore;
  QuranArguments _arguments;
  AudioPlayer audioPlayer;
  final scrollDirection = Axis.vertical;
  AutoScrollController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _quranStore = Provider.of<QuranStore>(context);

    _arguments = ModalRoute.of(context).settings.arguments;

    _quranStore.getBookmarkList();
    if (_arguments != null) {
      _quranStore.getAyahs(_arguments.surahId);
      _quranStore.getAyahsTranslate(_arguments.surahId);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
    // audioPlayer
    if (Platform.isIOS) audioPlayer.startHeadlessService();
  }

  @override
  void dispose() {
    super.dispose();
    _quranStore.dispose();
    if (audioPlayer != null) audioPlayer.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          "Surah ${_arguments.titleSurah}",
          style: TextStyle(fontSize: Size.size16, color: Colors.white),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context)),
        // actions: <Widget>[
        //   Padding(
        //       padding: EdgeInsets.only(right: 10.0),
        //       child: GestureDetector(
        //         onTap: () {},
        //         child: Icon(
        //           Icons.more_vert,
        //           color: Colors.white,
        //         ),
        //       )),
        // ],
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: _buildAyahContent())),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAyahContent() {
    return Observer(
      builder: (context) {
        return _quranStore.loadingAyah
            ? Center(
                child: SpinKitWave(
                  color: Colors.lightBlueAccent,
                  type: SpinKitWaveType.center,
                  size: 30,
                ),
              )
            : _buildAyahList();
      },
    );
  }

  Widget _buildAyahList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(_quranStore.indexBookmark);
    });
    return !_quranStore.isAyahsEmpty
        ? ListView.builder(
            scrollDirection: scrollDirection,
            controller: controller,
            itemCount: _quranStore.ayahListData.length,
            itemBuilder: (context, index) =>
                itemAyat(_quranStore.ayahListData, index, _ayatTranslate(index)
                    // , _showIconBookmark(index)
                    ),
          )
        : Center(
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
          );
  }

  play(var index, var url) async {
    audioPlayer = new AudioPlayer(playerId: "$index");
    int result = await audioPlayer.play(url);
    if (result == 1) {
      // success
      print("Playing......");
      setState(() {
        isPlay = true;
        indexPlay = index;
      });
    }
    if (_quranStore.indexBookmark != null && _quranStore.indexBookmark > index) {
      _quranStore.isSaveBookmark = false;
      setState(() {
        updateIsSaved = true;
        updateIndexSave = _quranStore.indexBookmark;
      });
      _quranStore.indexBookmark = indexPlay;
    } else if (_quranStore.indexBookmark != null && _quranStore.indexBookmark < index){
      _quranStore.isSaveBookmark = false;
      setState(() {
        updateIsSaved = true;
        updateIndexSave = _quranStore.indexBookmark;
      });
      _quranStore.indexBookmark = indexPlay;
    }
    audioPlayer.onPlayerCompletion.listen((event) {
      print("Selesai play......");
      setState(() {
        isPlay = false;
        indexPlay = index;
      });
      indexPlay = indexPlay + 1;
      if (_quranStore.ayahListData.length > indexPlay) {
        if (_quranStore.indexBookmark != null &&  _quranStore.isSaveBookmark) {
          _quranStore.isSaveBookmark = false;
          setState(() {
            updateIsSaved = true;
            updateIndexSave = indexPlay - 1;
          });
        }
        _quranStore.indexBookmark = indexPlay;
        _scrollToIndex(indexPlay);
        play(indexPlay, _quranStore.ayahListData[indexPlay].audio);
      }
    });
  }

  pause(var index) async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      // success
      print("Pause......");
      setState(() {
        isPlay = false;
        indexPlay = index;
      });
    }
  }

  stop(var index) async {
    int result = await audioPlayer.stop();
    if (result == 1) {
      // success
      print("Stop......");
      setState(() {
        isPlay = false;
        indexPlay = index;
      });
    }
  }

  updateBookmark() {
    setState(() {
      updateIsSaved = _quranStore.isSaveBookmark;
      updateIndexSave = _quranStore.indexBookmark;
    });
  }

  Future _scrollToIndex(int index) async {
    await controller.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
    controller.highlight(index);
  }

  Widget _wrapScrollTag({int index, Widget child}) => AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );

  Widget itemAyat(List<Ayahs> listArab, var index, Widget widgetTranslate
      // ,Widget widgetBookmark
      ) {
    return _wrapScrollTag(
      index: index,
      child: InkWell(
        onDoubleTap: () {
          var surah = DataSurah(
              number: _quranStore.ayahs.data.number,
              name: _quranStore.ayahs.data.name,
              englishName: _quranStore.ayahs.data.englishName,
              englishNameTranslation:
                  _quranStore.ayahs.data.englishNameTranslation,
              numberOfAyahs: _quranStore.ayahs.data.numberOfAyahs,
              revelationType: _quranStore.ayahs.data.revelationType,
              numberAyahId: _quranStore.ayahs.data.ayahs[index].number,
              indexAyah: index);
          if (_quranStore.isSaveBookmark) {
            print("deleteBookmark....true..delete");
            _quranStore.deleteBookmarkSurah(surah);
            _quranStore.isSaveBookmark = false;
            _quranStore.indexBookmark = null;
            // saveBookmark(surah, index, false);
            updateBookmark();
          } else {
            print("savedBookmark....else..save");
            _quranStore.saveBookmarkSurah(surah);
            _quranStore.isSaveBookmark = true;
            _quranStore.indexBookmark = index;
            // saveBookmark(surah, index, true);
            updateBookmark();
          }
        },
        child: Container(
          color: (index % 2 == 1) ? Colors.white : Colors.grey[50],
          child: Container(
            margin: EdgeInsets.only(
              top: Size.size16,
              right: Size.size16,
              bottom: Size.size16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    // widgetBookmark,
                    (_quranStore.isSaveBookmark &&
                            _quranStore.indexBookmark == index)
                        ? Container(
                            width: Size.size40,
                            height: Size.size32,
                            margin: EdgeInsets.only(right: Size.size16),
                            decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.bookmark,
                                  color: Colors.teal[100],
                                ),
                                onPressed: () {},
                              ),
                            ),
                          )
                        : (updateIsSaved != null && updateIndexSave == index)
                            ? Container(
                                width: Size.size40,
                                height: Size.size32,
                                margin: EdgeInsets.only(right: Size.size16),
                                decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8))),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.bookmark,
                                      color: Colors.teal[100],
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              )
                            : Container(),
                    SizedBox(height: 2),
                    Container(
                      width: Size.size40,
                      height: Size.size32,
                      margin: EdgeInsets.only(right: Size.size16),
                      decoration: BoxDecoration(
                          color: Colors.teal[200],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: Center(
                        child: Text(
                          _quranStore.ayahListData[index].numberInSurah
                              .toString(),
                          style: TextStyle(
                              color: Colors.white, fontSize: Size.size14),
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    (isPlay && indexPlay == index)
                        ? Container(
                            width: Size.size40,
                            height: Size.size40,
                            margin: EdgeInsets.only(right: Size.size16),
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  pause(index);
                                },
                              ),
                            ),
                          )
                        : Container(
                            width: Size.size40,
                            height: Size.size40,
                            margin: EdgeInsets.only(right: Size.size16),
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (isPlay == true && indexPlay != -1) {
                                    stop(indexPlay);
                                  }
                                  play(index,
                                      _quranStore.ayahListData[index].audio);
                                },
                              ),
                            ),
                          )
                  ],
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: Text(
                          listArab[index].text,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: Size.size18,
                              color: (isPlay && indexPlay == index)
                                  ? Colors.lightBlueAccent
                                  : Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      widgetTranslate
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _ayatTranslate(var index) {
    return Observer(builder: (context) {
      return _quranStore.isAyahsTranslateEmpty
          ? Theme(
              data: Theme.of(context)
                  .copyWith(accentColor: Colors.lightBlueAccent),
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              margin: EdgeInsets.only(top: Size.size8),
              child: Text(
                _quranStore.ayahTranslateListData[index].text,
                textAlign: TextAlign.left,
                style:
                    TextStyle(fontSize: Size.size14, color: Colors.teal[200]),
              ),
            );
    });
  }

  Widget _showIconBookmark(var index) {
    return Observer(
      builder: (context) {
        return _quranStore.isSaveBookmark && _quranStore.indexBookmark == index
            ? Container(
                width: Size.size40,
                height: Size.size32,
                margin: EdgeInsets.only(right: Size.size16),
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.bookmark,
                      color: Colors.teal[100],
                    ),
                    onPressed: () {},
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
