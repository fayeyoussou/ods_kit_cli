import 'package:intl/intl.dart'; // Pour le formatage des dates

class DateHelper {
  // Formater une date en chaîne de caractères
  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(date);
  }

  // Convertir une chaîne de caractères en DateTime
  static DateTime parseDate(String dateString, {String pattern = 'yyyy-MM-dd'}) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.parse(dateString);
  }

  // Obtenir la date d'aujourd'hui sans l'heure
  static DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  // Vérifier si deux dates sont égales (en ignorant l'heure)
  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  // Ajouter un nombre de jours à une date
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  // Soustraire un nombre de jours à une date
  static DateTime subtractDays(DateTime date, int days) {
    return date.subtract(Duration(days: days));
  }

  // Calculer la différence en jours entre deux dates
  static int differenceInDays(DateTime date1, DateTime date2) {
    final difference = date1.difference(date2);
    return difference.inDays;
  }

  // Vérifier si une date est dans le passé
  static bool isPastDate(DateTime date) {
    return date.isBefore(today);
  }

  // Vérifier si une date est dans le futur
  static bool isFutureDate(DateTime date) {
    return date.isAfter(today);
  }

  // Obtenir le premier jour du mois
  static DateTime getFirstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  // Obtenir le dernier jour du mois
  static DateTime getLastDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  // Vérifier si une année est bissextile
  static bool isLeapYear(DateTime date) {
    final year = date.year;
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }
}