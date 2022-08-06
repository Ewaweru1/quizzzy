import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quizzzy/service/firebase_auth.dart';

import 'auth_test.mocks.dart';

@GenerateMocks([User, UserCredential, FirebaseAuth])
main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUser mockUser;
  late Auth auth;
  setUp(() {
    mockUser = MockUser();
    mockFirebaseAuth = MockFirebaseAuth();
    auth = Auth.test(mockFirebaseAuth);
    when(mockFirebaseAuth.currentUser).thenAnswer((_) => mockUser);
  });

  group("User login", () {
    test("Unsuccessful login", () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
            email: "user@mail.com", password: "Abc@12345"),
      ).thenAnswer(((_) =>
          throw FirebaseAuthException(code: "400", message: "Login failed")));
      expect(
          await auth.userLogin("user@mail.com", "Abc@12345"), "Login failed");
    });

    test("Non-verified user login", () async {
      when(mockUser.emailVerified).thenAnswer((_) => false);
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
            email: "user@mail.com", password: "Abc@12345"),
      ).thenAnswer((_) async => MockUserCredential());
      expect(
          await auth.userLogin("user@mail.com", "Abc@12345"), "Not Verified");
    });
  });

  group("User signup", () {
    test("Successful signup", () async {
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
            email: "user@mail.com", password: "Abc@12345"),
      ).thenAnswer((_) async => MockUserCredential());
      expect(await auth.userSignup("user@mail.com", "Abc@12345"), "Success");
    });

    test("Unsuccessful signup", () async {
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
            email: "user@mail.com", password: "Abc@12345"),
      ).thenAnswer(((_) =>
          throw FirebaseAuthException(code: "400", message: "Signup failed")));
      expect(
          await auth.userSignup("user@mail.com", "Abc@12345"), "Signup failed");
    });
  });

  group("User signout", () {
    test("Successful signout", () async {
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async {});
      expect(await auth.userSignout(), "Success");
    });

    test("Unsuccessful signout", () async {
      when(mockFirebaseAuth.signOut()).thenAnswer(((_) =>
          throw FirebaseAuthException(code: "400", message: "Signup failed")));
      expect(await auth.userSignout(), "Signup failed");
    });
  });
}
