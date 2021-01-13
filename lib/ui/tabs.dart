import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nalij/services/api.dart';
import 'package:nalij/services/articleList.dart';
import 'package:nalij/services/firebase_auth.dart';
import 'package:nalij/services/miniPlayerStatus.dart';
import 'package:nalij/services/player.dart';
import 'package:nalij/ui/feedlist.dart';
import 'package:nalij/ui/playerUi.dart';
import 'package:nalij/ui/playlist.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_item.dart';
class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<RssItem>> rss() async {
    var client = http.Client();
    var response = await client.get('http://www.jamaicaobserver.com/rss/news/');
    var feed = RssFeed.parse(response.body);
    print(feed.title.toString() + " | " +
        feed.description.toString() + " | " +
        feed.link.toString() + " | " +
        feed.author.toString() + " | " +
        feed.items.toString() + " | " +
        feed.image.toString() + " | " +
        feed.cloud.toString() + " | " +
        feed.categories.toString() + " | " +
        feed.skipDays.toString() + " | " +
        feed.skipHours.toString() + " | " +
        feed.lastBuildDate.toString() + " | " +
        feed.language.toString() + " | " +
        feed.generator.toString() + " | " +
        feed.copyright.toString() + " | " +
        feed.docs.toString() + " | " +
        feed.managingEditor.toString() + " | " +
        feed.rating.toString() + " | " +
        feed.webMaster.toString() + " | " +
        feed.ttl.toString() + " | " +
        feed.dc.toString());
    return feed.items;
  }

  @override
  Widget build(BuildContext context) {
    var miniPlayer = Provider.of<MiniPlayerStatus>(context, listen: true);
    var auth = Provider.of<AuthenticationService>(context);
    print("REPAINT..........................");

    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: miniPlayer.isFullPlayer ? null : AppBar(
              leading: Icon(Icons.menu),
              actions: <Widget>[
                Icon(
                  Icons.search,
                  size: 25,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
              bottom: TabBar(tabs: [
                Tab(
                    child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.playlist_play),
                      Text("Playlist"),
                    ],
                  ),
                )),
                Tab(
                    child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.rss_feed),
                      Text("Feed"),
                    ],
                  ),
                )),
                Tab(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.local_library),
                        Text("Channels"),
                      ],
                    ),
                  )
                ),
                Tab(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.trending_up),
                          Text("Trending"),
                        ],
                      ),
                    )),
              ]),
              title: Container(
                alignment: Alignment(0.0, 0.0),
                padding: EdgeInsets.only(top: 0.0),
                child: SvgPicture.asset(
                  "assets/images/nalij_logo.svg",
                  semanticsLabel: 'Nalij Logo',
                  height: 50,
                ),
              ),
            ),
            body: Stack(
                children: [
                  TabBarView(
                    children: [
                      PlayList(articles: ArticleApi.fetchArticles(auth.idToken)),
                      Icon(Icons.rss_feed),
                      Icon(Icons.trending_up),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: ListTile(
                                leading: Icon(Icons.rss_feed, color: Colors.orange),
                                title: Text("Add RSS Subscription"),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Subscriptions",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(height: 10),
                            FeedList(feedItems: rss())
                          ]
                        ),
                      ),
                    ],
                  ),
                  getPlayer(context)
                ]
            ),
            //bottomNavigationBar: bottomPlayer(context)
        ),
      ),
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Color(0xffFFFFFF),
        scaffoldBackgroundColor: Colors.white,
        accentColor: Colors.blueAccent,
      ),
    );
  }

  Widget getPlayer(context){
    var articles = Provider.of<ArticleList>(context, listen: false);
    var player = Provider.of<Player>(context, listen: false);
    return Consumer2<ArticleList, Player>(
        builder: (context, articles, player, child) {
          return articles.playList == null
              ? Container()
              : PlayerUi(article: articles.playList[articles.currentIndex],
                  audioPlayer: player
                );
        }
    );
  }
}