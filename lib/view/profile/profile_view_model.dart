import 'package:flutter/material.dart';
import 'package:via_app/domain/repositories/i_profile_repository.dart';
import 'package:via_app/model/user_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final IProfileRepository _repository;

  UserProfile? _user;
  bool _isLoading = false;
  String? _errorMessage;

  ProfileViewModel(this._repository);

  UserProfile? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadProfile(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _repository.getUserProfile(userId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {}

  void editProfile() {}
}
