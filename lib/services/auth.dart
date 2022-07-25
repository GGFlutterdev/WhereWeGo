import 'dart:convert';
import 'dart:math';
 // ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uni_events/services/database.dart';

class Auth{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //auth change user stream
  Stream<String> get user{
    return _auth.authStateChanges().map(_myUserUidFromFirebaseUser);
  }

  String _myUserUidFromFirebaseUser(User? user) => user!.uid;

  //MyUser _myUserFromFirebaseUser(User? user){ return MyUser(uid: user!.uid); }

  //register with email e pass
  
  Future registerWithEmailAndPassword(String email, String password, String username, {required bool isAdmin, required bool isSubscribed}) async{
    try{
      final UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final User? user= result.user;

      //Create a new document for the user with the uid
      await Database(uid: user!.uid).updateUserData(username, 0, isAdmin: isAdmin, isSubscribed: isSubscribed);
      return _myUserUidFromFirebaseUser(user);
    } on Exception catch(e){
      throw Exception(e);
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String pass) async{
    try{
      final UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      final User user= result.user!;
      return _myUserUidFromFirebaseUser(user);
    } on Exception catch(e){
      throw Exception(e);
    }
  }

  Future signinWithGoogle()async{
    try{
      final GoogleSignInAccount? _signInAccount =await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleAuth =await  _signInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth.accessToken,
        idToken: _googleAuth.idToken,
      );
      final UserCredential result = await _auth.signInWithCredential(credential);
      final User? user = result.user;
      final bool res = await Database().userAlredyExists(user!.uid);
      if(res==false) {
        Database(uid: user.uid).updateUserData(
          user.displayName??'',
          0,
          isAdmin: false,
          isSubscribed: false,
        );
      }
      return _myUserUidFromFirebaseUser(user);
    }catch(e){
      return;
    }
  }

  Future googleSignOut() async{
    try{
      await _googleSignIn.disconnect();
      return await _auth.signOut();
    }
    catch(e){
      return;
    }
  }

  //sign out
  Future signOut() async{
    try{ return await _auth.signOut(); }
    catch(e){
      return;
    }
  }

  void resetPassword(String email){
    _auth.sendPasswordResetEmail(email: email);
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future signInWithApple() async {
  // To prevent replay attacks with the credential returned from Apple, we
  // include a nonce in the credential request. When signing in with
  // Firebase, the nonce in the id token returned by Apple, is expected to
  // match the sha256 hash of `rawNonce`.
  final rawNonce = generateNonce();
  final nonce = sha256ofString(rawNonce);

  // Request credential for the currently signed in Apple account.
  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: nonce,
  );

  // Create an `OAuthCredential` from the credential returned by Apple.
  final oauthCredential = OAuthProvider("apple.com").credential(
    idToken: appleCredential.identityToken,
    rawNonce: rawNonce,
  );

  // Sign in the user with Firebase. If the nonce we generated earlier does
  // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    final UserCredential result = await _auth.signInWithCredential(oauthCredential);
    final User? user = result.user;
    _myUserUidFromFirebaseUser(user);
    return user;
  }
}
