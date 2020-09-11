import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nalij/services/articleList.dart';
import 'package:nalij/ui/tabs.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Nalij());
}

class Nalij extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ArticleList>(
        create: (context) => ArticleList(), child: Tabs()
    );
  }
}
