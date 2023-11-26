import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app_2/models/user.dart';
import 'package:my_app_2/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userFromFirebaseUser(User user){
    return user != null ? MyUser(uid:user.uid) : MyUser(uid: 'XXX') ;
  }

  Stream<MyUser?> get user{
    return _auth
        .authStateChanges()
        .map((User?user)
          => _userFromFirebaseUser(user!));
  }

  Future signInAnon() async{
    try{
      UserCredential result =  await _auth.signInAnonymously();
      User? user = result.user;
      if (user != null){
        return _userFromFirebaseUser(user);
      }

    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future registerWithEmailAndPassword( String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      await DatabaseService(uid: user?.uid).updateUserData('NULL', 'X', DateTime.now(), DateTime.now(),0);
      return _userFromFirebaseUser(user!);


    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword( String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user= result.user;

      return _userFromFirebaseUser(user!);

    }catch(e){
      print(e.toString());
      return null;
    }
  }


  Future sigOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}