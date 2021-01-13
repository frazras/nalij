import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  var idToken;
  var status = "inactive";

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> anonymousLogin() async {
    this.status = "active";
    try {
      final anon = await _firebaseAuth.signInAnonymously();

      print("ANON login successful");
      this.status = "inactive";
      return anon.user.getIdToken();
    } on FirebaseAuthException catch (e) {
      this.status = "inactive";
      return e.message;
    }
  }
  /*
            if(res.user) {
                const userData: User = {
                    email: "anonymous@getnalij.com",
                    firstName: "AnonymousUser",
                    id: res.user.uid,
                    isAnonymous: true,
                    created: firebase.firestore.FieldValue.serverTimestamp(),
                };

                //await firebase.firestore().collection('/users').doc(res.user.uid).set(userData);

                // Production VS Local Dev API
                let api_user_url = "";
                if ( window.location.hostname === 'localhost') {
                    const path = 'http://localhost:5001/nalij-api/us-central1/app/';
                    api_user_url = path + '/api/user';
                } else {
                    // production code
                    api_user_url =  '/api/user';
                }
                console.log("YURL NONYMUSS LAGIN");
                await fetch(api_user_url, {
                    method: 'post',
                    headers: new Headers({
                        'auth-token': authToken
                    }),
                    body: JSON.stringify({user:userData})
                });
   */
}