
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';

class ArticlePreview extends StatefulWidget {
  @override
  _ArticlePreviewState createState() => _ArticlePreviewState();
}

class _ArticlePreviewState extends State<ArticlePreview> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 100.0,
      width: 200,
      child:Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network('https://picsum.photos/128/100'),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                        width: size.width - 170,
                        height: 60,
                          child: AutoSizeText(
                          "This is an article title that is probably a little longer than the regular title",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            ),
                          textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          width: size.width - 170,
                          height: 40,
                          child:
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,

                            children: <Widget>[
                              miniIcons(Icons.play_arrow, "2.51K  "),
                              miniIcons(Icons.favorite_border, "253  "),
                              miniIcons(Icons.comment, "5  "),
                              miniIcons(Icons.access_time, "3:13  "),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(Icons.playlist_add,
                                      color: Colors.blueAccent,
                                      size: 25,),
                                    Text("")
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
