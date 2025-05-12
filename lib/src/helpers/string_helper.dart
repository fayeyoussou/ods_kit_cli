class StringHelper {
  // Vérifier si une chaîne est vide ou null
  static bool isNullOrEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  // Capitaliser la première lettre d'une chaîne
  static String capitalize(String str) {
    if (isNullOrEmpty(str)) return str;
    return str[0].toUpperCase() + str.substring(1);
  }

  // Vérifier si une chaîne est un email valide
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Vérifier si une chaîne est un numéro de téléphone valide
  static bool isValidPhoneNumber(String phone) {
    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
    return phoneRegex.hasMatch(phone);
  }

  // Tronquer une chaîne si elle dépasse une longueur donnée
  static String truncate(String str, int maxLength) {
    if (isNullOrEmpty(str)) return str;
    return str.length <= maxLength ? str : '${str.substring(0, maxLength)}...';
  }
}