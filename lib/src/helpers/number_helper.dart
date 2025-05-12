class NumberHelper {
  // Formater un nombre avec des séparateurs de milliers
  static String formatNumber(double number, {int decimalPlaces = 2}) {
    return number.toStringAsFixed(decimalPlaces).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }

  // Convertir une chaîne en nombre (double)
  static double? parseDouble(String str) {
    return double.tryParse(str);
  }

  // Vérifier si un nombre est pair
  static bool isEven(int number) {
    return number % 2 == 0;
  }

  // Limiter un nombre entre une valeur minimale et maximale
  static double clamp(double value, double min, double max) {
    return value < min ? min : (value > max ? max : value);
  }
}