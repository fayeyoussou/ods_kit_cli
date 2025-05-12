import '../../ods_kit_cli.dart';

/// Exception personnalisée représentant une erreur provenant du serveur.
///
/// Cette classe implémente [ImplementedException] pour signaler qu’il s’agit d’une erreur
/// connue, souvent liée à des réponses HTTP ou des services distants.
///
/// Utilisation typique :
/// ```dart
/// throw ServerException('Erreur 500 : Serveur indisponible');
/// ```
///
/// Elle encapsule simplement un message d’erreur lisible.
class ServerException implements ImplementedException {
  /// Message d'erreur détaillant l’origine de l’exception.
  @override
  final String message;

  /// Crée une nouvelle exception serveur avec un [message] explicite.
  const ServerException(this.message);

  /// Retourne le message sous forme de chaîne.
  @override
  String toString() {
    return message;
  }
}
