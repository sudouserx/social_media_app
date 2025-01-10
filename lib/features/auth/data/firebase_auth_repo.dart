import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/features/auth/domain/entities/app_user.dart';
import 'package:social_media_app/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      // signin
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create current user instance ?
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
      );

      // return the user
      return user;
    } catch (e) {
      throw Exception('Login failed ${e.toString()}');
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
    try {
      // signup
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create current user instance ?
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      // save user in firestore
      await firebaseFirestore.collection("users").doc(user.uid).set(
            user.toJson(),
          );

      // return the user
      return user;
    } catch (e) {
      throw Exception('Registration failed ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    // get user currently logged in from firebase
    final currentUser = firebaseAuth.currentUser;

    if (currentUser == null) {
      return null;
    }

    return AppUser(
      uid: currentUser.uid,
      email: currentUser.email!,
      name: '',
    );
  }
}
