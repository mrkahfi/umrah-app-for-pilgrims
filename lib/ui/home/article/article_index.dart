import 'package:app_jamaah_boilerplate/models/article/article.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/article/article_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ArticleIndexPage extends StatefulWidget {
  @override
  _ArticleIndexPageState createState() => _ArticleIndexPageState();
}

class _ArticleIndexPageState extends State<ArticleIndexPage> {
  ArticleStore _articleStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _articleStore = Provider.of<ArticleStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("Semua Artikel"),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildArticleIndex(),
    );
  }

  Widget _buildArticleIndex() {
    return _articleStore.isArticleEmpty
        ? Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 50),
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
        : Padding(
            padding: EdgeInsets.all(20),
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: _articleStore.articleListData.length,
              itemBuilder: (BuildContext context, int index) {
                Article article = _articleStore.articleListData[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: InkWell(
                    child: Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: "${article.pict.url}",
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width - 130,
                            child: ListView(
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${article.title}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 13,
                                      color: Colors.blueGrey[300],
                                    ),
                                    SizedBox(width: 3),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "posted by Admin",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.blueGrey[300],
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Get.toNamed(AppRoutes.DETAIL_ARTICLE, arguments: article);
                      Navigator.of(context)
                          .pushNamed(Routes.articleDetail, arguments: article);
                    },
                  ),
                );
              },
            ),
          );
  }
}
