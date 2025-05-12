
/// Classe utilitaire pour les validations de formulaires et la gestion des champs de texte.
class ValidationHelper {
  /// Vérifie si le mot de passe est valide (minimum 8 caractères).
  static bool isValidPassword(String password) {
    return password.length >= 8;
  }

  /// Vérifie si un nom est valide (minimum 2 caractères).
  static bool isValidName(String name) {
    return name.length >= 2;
  }

  /// Vérifie si un code postal est valide (exactement 5 chiffres).
  static bool isValidPostalCode(String code) {
    final RegExp postalCodeRegex = RegExp(r'^\d{5}$');
    return postalCodeRegex.hasMatch(code);
  }





}
