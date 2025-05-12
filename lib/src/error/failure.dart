/// Représente un échec ou une erreur métier dans l'application.
///
/// Cette classe est souvent utilisée avec des types fonctionnels comme `Either<Failure, T>`
/// pour signaler un échec sans lancer d'exception.
///
/// Elle contient un simple [message] décrivant la nature de l'erreur.
///
/// Exemple :
/// ```dart
/// return Left(Failure('Impossible de charger les données'));
/// ```
class Failure {
  /// Message décrivant la cause de l’échec.
  final String message;

  /// Crée un [Failure] avec un message personnalisé, ou un message par défaut.
  Failure([this.message = 'Il y a eu une erreur']);
}
