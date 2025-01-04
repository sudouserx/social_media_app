import 'package:social_media_app/features/auth/domain/entities/app_user.dart';

/**
 * 
 * Outlines the possible Auth ops for the app
 * 
 */

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}
