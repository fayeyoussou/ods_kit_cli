import 'implemented_exception.dart';

/// Exception personnalisée représentant une erreur interne de l'application.
///
/// Cette exception est utilisée pour signaler une anomalie inattendue ou un bug dans le système,
/// souvent non directement lié à l'utilisateur ou à un appel réseau.
///
/// Elle implémente [ImplementedException] pour l’identifier comme une exception gérée
/// dans le cadre de la logique métier ou d'infrastructure.
///
/// Exemple :
/// ```dart
/// throw InternalException('Une erreur interne est survenue lors du traitement des données');
/// ```
class InternalException implements ImplementedException {
  /// Message d'erreur décrivant l’anomalie interne.
  @override
  final String message;

  /// Crée une instance de [InternalException] avec un [message] explicite.
  const InternalException(this.message);

  /// Retourne le message d'erreur sous forme de texte.
  @override
  String toString() {
    return message;
  }
}
