/// Interface de base pour toutes les exceptions personnalisées de l'application.
/// 
/// Permet de regrouper les exceptions métiers ou connues sous un même type,
/// facilitant leur gestion centralisée (ex : affichage de message utilisateur).
///
/// Chaque exception implémentant cette interface doit fournir un [message].
abstract class ImplementedException implements Exception {
  /// Message décrivant l’exception.
  String get message;
}
