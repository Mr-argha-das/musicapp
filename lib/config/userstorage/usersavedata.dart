import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserModel {
  final String id;
  final String username;
  final String emailorphone;
  final String image;
  final String loginby;

  UserModel({
    required this.id,
    required this.username,
    required this.emailorphone,
    required this.image,
    required this.loginby,
  });

  // Convert UserModel to a map for saving in SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'emailorphone': emailorphone,
      'image': image,
      'loginby': loginby,
    };
  }

  // Create UserModel from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      emailorphone: map['emailorphone'] ?? '',
      image: map['image'] ?? '',
      loginby: map['loginby'] ?? '',
    );
  }
}

class UserStateNotifier extends StateNotifier<UserModel?> {
  UserStateNotifier() : super(null) {
    _loadUserFromPreferences();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userModel');

    if (userData != null) {
      // If user data exists, deserialize and update the state
      final Map<String, dynamic> userMap = jsonDecode(userData);
      state = UserModel.fromMap(userMap);
    }
  }

  // Save user data to SharedPreferences
  Future<void> saveUser(UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    final userMap = userModel.toMap();
    final userString = jsonEncode(userMap);

    await prefs.setString('userModel', userString);
    state = userModel; // Update the state with new user data
  }

  // Clear user data from SharedPreferences
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userModel');
    state = null; // Set state to null after clearing user data
  }
}

// Create a StateProvider for UserModel
final userProvider = StateNotifierProvider<UserStateNotifier, UserModel?>(
  (ref) => UserStateNotifier(),
);
