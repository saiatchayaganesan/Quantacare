// lib/utils/auth_service.dart
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

  class AuthService {
  final Logger logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

// Get current user
  User? get currentUser => _auth.currentUser;

// Get auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

// Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
  try {
// Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

if (googleUser == null) {
logger.w('Google sign In was aborted by user');
return null;
}

// Obtain the auth details from the request
final GoogleSignInAuthentication googleAuth =
await googleUser.authentication;

// Create a new credential
final credential = GoogleAuthProvider.credential(
accessToken: googleAuth.accessToken,
idToken: googleAuth.idToken,
);

// Sign in with the credential
final userCredential = await _auth.signInWithCredential(credential);
logger.i('Successfully signed in with Google: ${googleUser.email}');
return userCredential;
} catch (e) {
logger.e('Error signing in with Google', error: e);
rethrow;
}
}

// Sign out
Future<void> signOut() async {
try {
await Future.wait([
_auth.signOut(),
_googleSignIn.signOut(),
]);
} catch (e) {
logger.e('Error signing out', error: e);
rethrow;
}
}

// Check if user is signed in
bool isUserSignedIn() {
final isSignedIn = _auth.currentUser != null;
logger.d('User sign in status: $isSignedIn');
return isSignedIn;
}

// Get user display name
String? getUserDisplayName() {
final displayName = _auth.currentUser?.displayName;
logger.d('Retrieved user display name: $displayName');
return displayName;
}

// Get user email
String? getUserEmail() {
final email = _auth.currentUser?.email;
logger.d('Retrieved user email: $email');
return email;
}

// Get user photo URL
String? getUserPhotoUrl() {
final photoURL = _auth.currentUser?.photoURL;
logger.d('Retrieved user photo URL: $photoURL');
return photoURL;
}

// Get user ID
String? getUserId() {
final uid = _auth.currentUser?.uid;
logger.d('Retrieved user ID: $uid');
return uid;
}

// Delete user account
Future<void> deleteAccount() async {
try {
await _auth.currentUser?.delete();
logger.i('User account deleted successfully');
} catch (e) {
logger.e('Error deleting account', error: e);
rethrow;
}
}

// Update user profile
Future<void> updateUserProfile(
{String? displayName, String? photoURL}) async {
try {
await _auth.currentUser?.updateDisplayName(displayName);
await _auth.currentUser?.updatePhotoURL(photoURL);
logger.i('User profile updated successfully');
} catch (e) {
logger.e('Error updating profile', error: e);
rethrow;
}
}

// Check if email is verified
bool isEmailVerified() {
final isVerified = _auth.currentUser?.emailVerified ?? false;
logger.d('Email verification status: $isVerified');
return isVerified;
}

// Send email verification
Future<void> sendEmailVerification() async {
try {
await _auth.currentUser?.sendEmailVerification();
logger.i('Email verification sent successfully');
} catch (e) {
logger.e('Error sending email verification', error: e);
rethrow;
}
}
}
