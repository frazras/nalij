import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nalij/services/api.dart';
import 'package:nalij/ui/articlepreview.dart';
import 'package:nalij/ui/playlist.dart';
//import 'package:flutter_svg/flutter_svg.dart';


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
    var _value = 0.0;
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.menu),
            actions: <Widget>[
              Icon(Icons.search,
                size: 25,),
              SizedBox(width: 20,),
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  child: FittedBox(fit:BoxFit.fitWidth,
                    child:Row(
                      children: <Widget>[
                        Icon(Icons.playlist_play),
                        Text("Playlist"),
                      ],
                    ),
                  )
                ),
                Tab(
                    child: FittedBox(fit:BoxFit.fitWidth,
                      child:Row(
                        children: <Widget>[
                          Icon(Icons.trending_up),
                          Text("Trending"),
                        ],
                      ),
                    )
                ),
                Tab(
                  child: FittedBox(fit:BoxFit.fitWidth,
                    child:Row(
                      children: <Widget>[
                        Icon(Icons.local_library),
                        Text("Topics"),
                      ],
                    ),
                  )
                ),
]           ),
            title: Container(
              alignment: Alignment(0.0, 0.0),
              padding: EdgeInsets.only(top: 0.0),
              child: SvgPicture.asset(
                "assets/images/nalij_logo.svg",
                semanticsLabel: 'Hymnal Logo',
                height: 60,
              ),
            ),
          ),
          body: TabBarView(
            children: [
              PlayList(articles: ArticleApi.fetchArticles()),
              Icon(Icons.trending_up),
              Icon(Icons.local_library),
              //Icon(Icons.directions_bike),
            ],
          ),
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
}