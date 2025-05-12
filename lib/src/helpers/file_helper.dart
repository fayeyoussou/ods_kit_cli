import 'dart:io';

class FileHelper {
  // Obtenir le répertoire de stockage local de l'application
  static Future<Directory> getAppDirectory() async {
    final dir = Directory('${Directory.current.path}/.ods');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }


  // Lire un fichier
  static Future<String> readFile(String path) async {
    final file = File(path);
    return await file.readAsString();
  }

  // Écrire dans un fichier
  static Future<void> writeFile(String path, String content) async {
    final file = File(path);
    await file.writeAsString(content);
  }

  // Vérifier si un fichier existe
  static Future<bool> fileExists(String path) async {
    final file = File(path);
    return await file.exists();
  }

  // Supprimer un fichier
  static Future<void> deleteFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}