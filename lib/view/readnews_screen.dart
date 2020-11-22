import 'package:flutter/material.dart';
import 'package:fluttermysql/models/constant.dart';

class ReadNews extends StatefulWidget {
  final String imgUrl;
  final String newsModelImg;
  final String newsModelTitle;
  final String newsModelContent;

  ReadNews(this.imgUrl, this.newsModelImg, this.newsModelTitle,
      this.newsModelContent);

  @override
  _ReadNewsState createState() => _ReadNewsState();
}

class _ReadNewsState extends State<ReadNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, innerBox) {
          return [
            SliverAppBar(
              backgroundColor: kLightGreen,
              expandedHeight: 200.0,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  padding: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                  color: kLightGreen.withOpacity(0.5),
                  child: Text(
                    widget.newsModelTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                background: Image.network(
                  '${widget.imgUrl + widget.newsModelImg}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            widget.newsModelContent,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
