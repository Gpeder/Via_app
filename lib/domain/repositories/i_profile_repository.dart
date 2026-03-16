import 'package:via_app/model/user_model.dart';

abstract class IProfileRepository {
  Future<UserProfile> getUserProfile(String id);
}
