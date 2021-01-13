import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nalij/services/articleList.dart';
import 'package:nalij/services/firebase_auth.dart';
import 'package:nalij/services/miniPlayerStatus.dart';
import 'package:nalij/services/player.dart';
import 'package:nalij/ui/tabs.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Nalij());
}

class Nalij extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return providerApp(context);
  }

  Widget providerApp(BuildContext context) {
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
          ),
          ChangeNotifierProvider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges,
          )
        ],
        child:  AuthenticationWrapper()
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    var anon;
    var auth = Provider.of<AuthenticationService>(context);
    if (auth.status == "inactive") {
      anon = auth.anonymousLogin();
      }

    return FutureBuilder(
      future: anon,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("Error Happened");
          return CircularProgressIndicator();
        }

        // Once complete, show your application
        if (snapshot.hasData) {
          auth.idToken = snapshot.data;
          return Tabs();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}