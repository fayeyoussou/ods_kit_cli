/// Interface abstraite représentant un système de stockage sécurisé.
///
/// Cette interface définit deux méthodes principales :
/// - [write] : pour écrire une valeur de manière sécurisée avec une clé donnée.
/// - [read] : pour lire une valeur stockée en fonction de sa clé.
///
/// Elle permet d'abstraire le mécanisme de stockage (local, mémoire, sécurisé, etc.)
/// afin de rendre les classes comme `Encryption` indépendantes de l’implémentation concrète.
abstract class SecureStore {
  /// Écrit une valeur [value] dans le stockage sécurisé avec la clé [key].
  Future<void> write({required String key, required String value});

  /// Lit une valeur sécurisée associée à la clé [key].
  /// Retourne la valeur si elle existe, ou `null` sinon.
  Future<String?> read({required String key});
}
