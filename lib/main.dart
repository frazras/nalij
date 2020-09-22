import 'package:flutter/widgets.dart';
import 'package:nalij/services/articleList.dart';
import 'package:nalij/services/miniPlayerStatus.dart';
import 'package:nalij/services/player.dart';
import 'package:nalij/ui/tabs.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Nalij());
}

class Nalij extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MiniPlayerStatus>(
            create: (context) => MiniPlayerStatus()
          ),
          ChangeNotifierProvider<Player>(
          create: (context) => Player()
          ),
          ChangeNotifierProvider<ArticleList>(
          create: (context) => ArticleList()
          )
        ],
        child:  Tabs()
    );
  }
}
