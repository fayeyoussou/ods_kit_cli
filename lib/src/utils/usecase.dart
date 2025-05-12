import 'package:fpdart/fpdart.dart';
import '../error/failure.dart';

/// EN:
/// Abstract base class representing a use case that returns a result of type [SuccessType]
/// or a [Failure], using functional programming with Either.
/// Implement this class for each business logic operation.
///
/// FR :
/// Classe de base abstraite représentant un cas d'utilisation retournant soit un [SuccessType],
/// soit un [Failure], en utilisant la programmation fonctionnelle avec Either.
/// À implémenter pour chaque opération métier.
abstract interface class UseCase<SuccessType, Params> {
  /// EN: Executes the use case with the given [params] and returns a result wrapped in Either.
  /// FR: Exécute le cas d'utilisation avec les [params] et retourne un résultat encapsulé dans Either.
  Future<Either<Failure, SuccessType>> call(Params params);
}

/// EN:
/// Class representing empty parameters for a use case.
/// Use when the use case doesn't require any input.
///
/// FR:
/// Classe représentant des paramètres vides pour un cas d'utilisation.
/// À utiliser lorsque le cas d'utilisation ne nécessite aucune entrée.
class NoParams {}

/// EN:
/// Class representing a simple use case parameter that carries an [id].
/// Useful for operations like "getById", "deleteById", etc.
///
/// FR:
/// Classe représentant un paramètre simple contenant un [id].
/// Utile pour des opérations comme "getById", "deleteById", etc.
class IdParams {
  final dynamic id;

  /// EN: Creates an [IdParams] instance with the given [id].
  /// FR: Crée une instance de [IdParams] avec l'[id] fourni.
  IdParams(this.id);
}
