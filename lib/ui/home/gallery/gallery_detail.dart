import 'package:flutter/material.dart';

class GalleryDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String urlImage = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: "detail_$urlImage",
            child: Image.network(
              urlImage,
            ),
          ),
        ),
      ),
    );
  }
}
