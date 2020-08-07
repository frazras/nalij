import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:nalij/models/article.dart';
import 'dart:developer' as dev;

import 'package:nalij/ui/sizeConfig.dart';

class ArticlePreview extends StatefulWidget {
  final Article article;
  ArticlePreview({Key key, @required this.article}) : super(key:key);
  @override
  _ArticlePreviewState createState() => _ArticlePreviewState();
}

class _ArticlePreviewState extends State<ArticlePreview> {
  @override
  Widget build(BuildContext context, [int index]) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    print(widget.article);
    //dev.debugger();
    return Container(
      //height: 180.0,
      //width: size.width,
      child:Column(
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
                        width: (SizeConfig.safeBlockHorizontal * 65) - 16,
                        height: (SizeConfig.safeBlockVertical * 21),
                          child: AutoSizeText(
                          widget.article.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            ),
                          textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          width: (SizeConfig.safeBlockHorizontal * 65) - 16,
                          height: (SizeConfig.safeBlockVertical * 14),
                          child:
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,

                            children: <Widget>[
                              miniIcons(Icons.play_arrow, "${widget.article.plays}  "),
                              miniIcons(Icons.favorite_border, "${widget.article.likes}  "),
                              miniIcons(Icons.comment, "5  "),
                              miniIcons(Icons.access_time, "${widget.article.duration}  "),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(Icons.playlist_add,
                                      color: Colors.blueAccent,
                                      size: 25,)
                                  ],
                                ),
                              )
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0,
            right: 8.0,
            bottom: 8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Author: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Text(widget.article.author)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Source: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        )
                    ),
                    Text(Uri.parse(widget.article.source).host)
                  ],
                )
              ],
            ),
          ),
          Divider()
        ],
      )
    );
  }

  Widget miniIcons(icon, text){
    return Row(
      children: <Widget>[
        Icon(icon,
            size: 18
          ),
        Text(text,
          style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}
