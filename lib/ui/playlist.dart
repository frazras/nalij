import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:nalij/models/article.dart';
import 'package:nalij/services/articleList.dart';
import 'package:nalij/ui/articlepreview.dart';
import 'package:provider/provider.dart';

class PlayList extends StatefulWidget {
  final Future<List<Article>> articles;
  PlayList({Key key, @required this.articles}) : super(key:key);

  @override
  _PlayListState createState() => _PlayListState();
}


class _PlayListState extends State<PlayList> {

  Widget _buildList() {
    return FutureBuilder(
        future: widget.articles,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              var articles = Provider.of<ArticleList>(context, listen: false);
              articles.playList =  snapshot.data;
              return Flexible(
                  child: new RefreshIndicator(
                      onRefresh: refresh,
                      child: new ListView.builder(
                          cacheExtent: 9999,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ArticlePreview(
                                article: snapshot.data[index],
                                index: index
                            );
                          }
                      )
                  )
              );
            } else {
              return Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<Null> refresh() {
    return new Future<Null>.value();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          _buildList(),
        ],
      ),
    );
  }
}
