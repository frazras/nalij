import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_item.dart';

class FeedList extends StatefulWidget {
  final Future<List<RssItem>> feedItems;
  FeedList({Key key, @required this.feedItems}) : super(key:key);
  @override
  _FeedListState createState() => _FeedListState();
}


class _FeedListState extends State<FeedList> {

  Widget _buildList() {
    return FutureBuilder(
        future: widget.feedItems,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              return Flexible(
                  child: new RefreshIndicator(
                      onRefresh: refresh,
                      child: new ListView.builder(
                          cacheExtent: 9999,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                           /* return ArticlePreview(
                                article: snapshot.data[index],
                                index: index
                            );*/
                            //print(Uri.parse(snapshot.data[index].link).scheme + "://" + Uri.parse(snapshot.data[index].link).host + "/favicon.ico");
                            return ListTile(
                              leading: Image.network(Uri.parse(snapshot.data[index].link).scheme + "://" + Uri.parse(snapshot.data[index].link).host + "/favicon.ico"),
                              title: Text(snapshot.data[index].title),
                              trailing: IconButton(icon: Icon(Icons.playlist_add), onPressed: null),
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
    return _buildList();
  }
}
