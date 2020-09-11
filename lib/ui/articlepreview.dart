import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:nalij/models/article.dart';
import 'package:nalij/services/articleList.dart';
import 'package:nalij/services/player.dart';
import 'package:nalij/ui/playerUi.dart';
import 'package:nalij/ui/sizeConfig.dart';
import 'package:provider/provider.dart';

class ArticlePreview extends StatefulWidget {
  final Article article;
  final int index;
  ArticlePreview({Key key, @required this.article, @required this.index}) : super(key: key);
  @override
  _ArticlePreviewState createState() => _ArticlePreviewState();
}

class _ArticlePreviewState extends State<ArticlePreview> with ChangeNotifier{
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return InkWell(
      onTap: () {
          var articles = Provider.of<ArticleList>(context, listen: false);
          articles.currentIndex = widget.index;
          articles.audioPlayer.play(widget.article.narrationUrl);
      },
      child: Container(
          //height: 180.0,
          //width: size.width,
          child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                width: (SizeConfig.safeBlockHorizontal * 35) - 16,
                child: Image.network(widget.article.image),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: (SizeConfig.safeBlockHorizontal * 65),
                          //height: (SizeConfig.safeBlockVertical * 21),
                          child: AutoSizeText(
                            widget.article.title,
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                            width: (SizeConfig.safeBlockHorizontal * 65),
                            //height: (SizeConfig.safeBlockVertical * 14),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                miniIcons(Icons.play_arrow,
                                    "${widget.article.plays}  "),
                                miniIcons(Icons.favorite_border,
                                    "${widget.article.likes}  "),
                                miniIcons(Icons.comment, "5  "),
                                miniIcons(Icons.access_time,
                                    "${widget.article.duration}  "),
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(
                                        Icons.playlist_add,
                                        color: Colors.blueAccent,
                                        size: 25,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Author: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(widget.article.author)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Source: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(Uri.parse(widget.article.source).host)
                  ],
                )
              ],
            ),
          ),
          Divider()
        ],
      )),
    );
  }

  Widget miniIcons(icon, text) {
    return Row(
      children: <Widget>[
        Icon(icon, size: SizeConfig.safeBlockHorizontal * 5),
        Text(
          text,
          style: TextStyle(
              color: Colors.black,
              fontSize: SizeConfig.safeBlockHorizontal * 3,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
