import 'dart:convert';
import 'dart:math';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'secure_store.dart';

/// Classe responsable de la gestion du chiffrement sécurisé dans l’application.
///
/// Elle utilise une abstraction [SecureStore] pour lire et écrire les clés de chiffrement,
/// ce qui permet de rendre l'implémentation indépendante du support de stockage (mémoire, disque, FlutterSecureStorage, etc.).
///
/// Fonctionnalités :
/// - Génération et stockage sécurisé de clés (pour Realm ou mot de passe)
/// - Chiffrement et déchiffrement de chaînes de caractères avec AES-GCM
class Encryption {
  /// Instance de [SecureStore] injectée pour lire/écrire les clés de façon sécurisée.
  final SecureStore _secureStore;

  /// Clé utilisée pour stocker la clé de chiffrement du Realm (ou autre).
  final String encryptionKeyKey;

  /// Clé utilisée pour stocker la clé de chiffrement du mot de passe.
  final String passwordKey;

  /// Crée une instance de [Encryption] avec un [SecureStore] et les noms des clés.
  Encryption(this._secureStore, {
    required this.encryptionKeyKey,
    required this.passwordKey,
  });

  /// Récupère ou génère la clé de chiffrement utilisée pour Realm ou une autre base.
  ///
  /// Si aucune clé n'est trouvée ou si [newKey] est `true`, une nouvelle clé de 64 octets est générée et sauvegardée.
  /// Retourne la clé sous forme de liste d'octets.
  Future<List<int>> getRealmEncryptionKey({bool newKey = false}) async {
    String? storedKey = await _secureStore.read(key: encryptionKeyKey);
    if (storedKey == null || newKey) {
      final key = generateRandomKey(64);
      await _secureStore.write(
        key: encryptionKeyKey,
        value: base64UrlEncode(key),
      );
      return key;
    }
    return base64Url.decode(storedKey);
  }

  /// Récupère ou génère une clé de chiffrement pour les mots de passe.
  ///
  /// La clé générée est encodée en base64 et persistée.
  Future<String> getPasswordEncryptionKey() async {
    String? storedKey = await _secureStore.read(key: passwordKey);
    if (storedKey == null) {
      final key = generateRandomKey(32);
      final keyString = base64Url.encode(key);
      await _secureStore.write(key: passwordKey, value: keyString);
      return keyString;
    }
    return storedKey;
  }

  /// Chiffre une chaîne de caractères (ex. mot de passe) en utilisant AES-GCM.
  ///
  /// L’IV (vecteur d’initialisation) est généré aléatoirement et concaténé au résultat final.
  /// Retourne une chaîne encodée en base64 prête à être stockée.
  Future<String> encryptPassword(String password) async {
    final keyString = await getPasswordEncryptionKey();
    final key = encrypt.Key(base64Url.decode(keyString));
    final iv = encrypt.IV.fromSecureRandom(12);

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
    final encrypted = encrypter.encrypt(password, iv: iv);

    final combined = iv.bytes + encrypted.bytes;
    return base64Url.encode(combined);
  }

  /// Déchiffre une chaîne chiffrée précédemment avec [encryptPassword].
  ///
  /// L’IV est extrait des premiers 12 octets, puis utilisé pour reconstruire les données originales.
  Future<String> decryptPassword(String encryptedPassword) async {
    final keyString = await getPasswordEncryptionKey();
    final key = encrypt.Key(base64Url.decode(keyString));

    final combined = base64Url.decode(encryptedPassword);
    final iv = encrypt.IV(combined.sublist(0, 12));
    final encryptedBytes = combined.sublist(12);
    final encrypted = encrypt.Encrypted(encryptedBytes);

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.gcm));
    return encrypter.decrypt(encrypted, iv: iv);
  }

  /// Génère une clé aléatoire sécurisée de la taille spécifiée (en octets).
  static List<int> generateRandomKey(int length) {
    final rand = Random.secure();
    return List.generate(length, (_) => rand.nextInt(256));
  }
}
