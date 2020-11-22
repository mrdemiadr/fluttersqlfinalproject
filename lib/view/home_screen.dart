import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttermysql/models/constant.dart';
import 'package:fluttermysql/services/sharedpreferences.dart';
import 'package:fluttermysql/view/addnews_screen.dart';
import 'package:fluttermysql/view/editnews_screen.dart';
import 'package:fluttermysql/view/login_screen.dart';
import 'package:fluttermysql/view/readnews_screen.dart';
import 'package:http/http.dart' as http;
import 'package:fluttermysql/models/newsmodel.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  static const String id = 'homescreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String usernameAPI, idUser;
  var newsList = List<NewsModel>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _getPref();
    _getNewsData();
  }

  _getPref() async {
    await SharedPref.getPref().then((value) {
      setState(() {
        if (value != null) {
          usernameAPI = value;
        } else {
          usernameAPI = '';
        }
      });
    });
  }

  _getNewsData() async {
    newsList.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseURL.kDetailUrl);
    if (response.statusCode == 200) {
      final newsData = jsonDecode(response.body);
      newsData.forEach((data) {
        final listData = NewsModel(
          idNews: data['id_news'],
          image: data['image'],
          title: data['title'],
          content: data['content'],
          description: data['description'],
          dateNews: data['date_news'],
          idUser: data['id_user'],
          username: data['username'],
        );
        newsList.add(listData);
      });
      setState(() {
        loading = false;
      });
    } else {
      throw Exception('Failed to load News');
    }
  }

  _deleteNews(String idNews) async {
    final response =
        await http.post(BaseURL.kDeleteUrl, body: {'id_news': idNews});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      _getNewsData();
    } else {
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Hero(
            tag: 'animasilogo',
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: Image.asset('assets/img/lemonlime.png'),
            ),
          ),
          title: Text('Welcome $usernameAPI'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                SharedPref.signOut();
                Navigator.pushNamed(context, LoginScreen.id);
              },
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => _getNewsData(),
          child: loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: newsList.length,
                  itemBuilder: (context, i) {
                    final newsBody = newsList[i];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReadNews(
                                BaseURL.kImageUrl,
                                newsBody.image,
                                newsBody.title,
                                newsBody.content)));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120.0,
                              height: 100.0,
                              margin: EdgeInsets.only(right: 20.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          BaseURL.kImageUrl + newsBody.image),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    newsBody.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(newsBody.description),
                                      Text('  |  '),
                                      Text(newsBody.dateNews),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      MaterialButton(
                                        color: kLightGreen,
                                        child: Text('Edit'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => EditNews(
                                                newsBody, _getNewsData),
                                          ));
                                        },
                                      ),
                                      Text('  |  '),
                                      MaterialButton(
                                        color: kLightGreen,
                                        child: Text('Delete'),
                                        onPressed: () {
                                          _deleteNews(newsBody.idNews);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddNewsScreen()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
