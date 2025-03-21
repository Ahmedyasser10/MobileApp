import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

final supabase = Supabase.instance.client;

/// Sign up a new user with additional metadata
Future<void> signUp({
  required String email,
  required String password,
  required String name,
  required String studentId,
  String? gender,
  String? level,
}) async {
  try {
    // Step 1: Sign up the user using Supabase Auth
    final authResponse = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
        'student_id': studentId,
        'gender': gender,
        'level': level,
      },
    );

    if (authResponse.user == null) {
      throw Exception('Sign-up failed: User is null');
    }

    print('User signed up successfully!');
  } on AuthException catch (e) {
    // Handle Supabase Auth errors
    throw Exception('Sign-up failed: ${e.message}');
  } catch (e) {
    // Handle other errors
    throw Exception('Sign-up failed: $e');
  }
}

/// Upload a profile photo to Supabase Storage
Future<String> uploadProfilePhoto(File imageFile, String userId) async {
  try {
    final fileName = 'profile_$userId.jpg';
    final fileBytes = await imageFile.readAsBytes();

    // Upload the image to Supabase Storage
    await supabase.storage
        .from('profileimages') // Ensure the bucket name is correct
        .uploadBinary(fileName, fileBytes);

    // Get the public URL of the uploaded image
    final imageUrl = supabase.storage
        .from('profileimages')
        .getPublicUrl(fileName);

    return imageUrl;
  } catch (e) {
    print('Error uploading profile photo: $e'); // Log the error
    throw Exception('Failed to upload profile photo: $e');
  }
}

/// Update user metadata (including profile photo URL)
Future<void> updateUserMetadata({
  String? name,
  String? studentId,
  String? gender,
  String? level,
  String? profileImageUrl,
}) async {
  try {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User is not logged in');
    }

    // Update user metadata
    await supabase.auth.updateUser(
      UserAttributes(
        data: {
          ...user.userMetadata ?? {},
          'name': name,
          'student_id': studentId,
          'gender': gender,
          'level': level,
          'profile_image_url': profileImageUrl, // Ensure this is set
        },
      ),
    );

    print('User metadata updated successfully!');
  } catch (e) {
    print('Error updating metadata: $e'); // Log the error
    throw Exception('Failed to update user metadata: $e');
  }
}
/// Log out the user
Future<void> logout() async {
  await supabase.auth.signOut();
}
Future<void> login(String email, String password) async {
  final response = await supabase.auth.signInWithPassword(
    email: email,
    password: password,
  );
  if (response.user == null) {
    throw Exception('Login failed');
  }
}