import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nalij/services/api.dart';
import 'package:nalij/services/articleList.dart';
import 'package:nalij/services/miniPlayerStatus.dart';
import 'package:nalij/services/player.dart';
import 'package:nalij/ui/playerUi.dart';
import 'package:nalij/ui/playlist.dart';
import 'package:provider/provider.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var miniPlayer = Provider.of<MiniPlayerStatus>(context, listen: true);
    print("REPAINT..........................");
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
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
                      Icon(Icons.trending_up),
                      Text("Trending"),
                    ],
                  ),
                )),
                Tab(
                    child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.local_library),
                      Text("Topics"),
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
                      PlayList(articles: ArticleApi.fetchArticles()),
                      Icon(Icons.trending_up),
                      Icon(Icons.local_library),
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