import 'package:flutter/material.dart';
import 'package:nalij/models/article.dart';
import 'package:nalij/ui/articlepreview.dart';

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
            if (snapshot.data != null) {
              return Flexible(
                  child: new RefreshIndicator(
                      onRefresh: refresh,
                      child: new ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ArticlePreview(
                                article: snapshot.data[index]
                            );
                          }
                      )
                  )
              );
            } else {
              return Text("Data is NULL");
            }
          } else {
            return CircularProgressIndicator();
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
