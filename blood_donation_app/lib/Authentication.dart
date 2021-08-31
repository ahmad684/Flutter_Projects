import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<bool> signUp(String email, String password) async {
  try {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print(result.runtimeType);
    print(result.user!.uid);
  } catch (e) {
    print(e);
  }
  return Future.value(true);
}

Future<bool> signOut() async {
  await auth.signOut();
  return Future.value(true);
}
