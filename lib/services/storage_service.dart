import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_alphermix/models/user.dart';
import 'package:the_alphermix/models/fusion_result.dart';

class StorageService {
  static const String _userKey = 'user_data';
  static const String _historyKey = 'fusion_history';

  Future<User?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      if (userJson == null) return null;
      return User.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_userKey, jsonEncode(user.toJson()));
    } catch (e) {
      return false;
    }
  }

  Future<List<FusionResult>> getHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(_historyKey);
      if (historyJson == null) return [];
      final List<dynamic> decoded = jsonDecode(historyJson) as List<dynamic>;
      return decoded.map((item) => FusionResult.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveFusionResult(FusionResult result) async {
    try {
      final history = await getHistory();
      history.insert(0, result);
      if (history.length > 50) {
        history.removeRange(50, history.length);
      }
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_historyKey, jsonEncode(history.map((r) => r.toJson()).toList()));
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_historyKey);
    } catch (e) {
      return false;
    }
  }
}
