import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:nalij/services/api.dart';
import 'package:nalij/services/articleList.dart';
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
    var articles = Provider.of<ArticleList>(context);
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: articles.isFullPlayer ? null : AppBar(
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
            body: miniPlayerBar(context),
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

  bool hideAppBar(){
    bool isHidden = false;
    print("VVVVVVVVVVVV");
    Consumer<ArticleList>(
        builder: (context, articles, child) {
          isHidden = articles.isFullPlayer;
          print(isHidden);
          return Container();
        });
    return isHidden;
  }

  Widget miniPlayerBar(context) {
    return  Stack(
      children: [
        TabBarView(
          children: [
            PlayList(articles: ArticleApi.fetchArticles()),
            Icon(Icons.local_library),
            Icon(Icons.local_library),
            //Icon(Icons.directions_bike),
          ],
        ),
        Miniplayer(
        minHeight: 70,
        maxHeight: 570,
        builder: (height, percentage) {
          return Consumer<ArticleList>(
            builder: (context, articles, child) {
              if (articles.isFullPlayer && percentage < 1) {
                articles.isFullPlayer = false;
              }

              if (!articles.isFullPlayer && percentage == 1) {
                articles.isFullPlayer = true;
              }

              print("Rebuild Player");
              print(height);
              print(percentage);
              print(articles.isFullPlayer);

              return articles.currentIndex == null
                ? Container()
                : BottomAppBar(
                  child: PlayerUi(
                      article: articles.playList[articles.currentIndex],
                      audioPlayer: articles.audioPlayer,
                      percentage: percentage
                    ),
                  );
            },
          );
        },
      )]
    );
  }
}