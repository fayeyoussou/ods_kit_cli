# 🛠️ ODS Kit CLI

Un kit de démarrage modulaire pour projets Flutter & Dart, avec un **générateur de code en ligne de commande**, des **helpers prêts à l’emploi**, et une structure basée sur le **Clean Architecture**.

> Compatible CLI pur (Dart-only), sans dépendance Flutter obligatoire.

---

## ✨ Fonctionnalités

- 🚀 Générateur de features/pages/cubits via CLI
- 🔐 Gestion du chiffrement avec injection de stockage sécurisé (`SecureStore`)
- 🧠 Helpers réutilisables (`String`, `Date`, `Validation`, `File`)
- 📦 Compatible avec `fpdart` et `Either<Failure, Success>`
- 🧪 Prêt pour les tests et l’intégration continue

---

## 📦 Installation

Ajoutez à votre projet :

```yaml
dependencies:
  ods_kit_cli:
    git:
      url: https://github.com/votre-utilisateur/ods_kit_cli.git
```

> 📌 Bientôt disponible sur [pub.dev](https://pub.dev/packages/ods_kit_cli)

---

## ⚙️ Utilisation CLI

### Générer une feature :

```bash
dart run flutter_feature add feature client
```

### Ajouter une page à une feature :

```bash
dart run flutter_feature add page client detail
```

### Ajouter un cubit :

```bash
dart run flutter_feature add cubit client loading
```

📁 Résultat :

```
lib/features/client/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   └── repositories/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

---

## 🔐 Chiffrement avec `Encryption`

```dart
final encryption = Encryption(
  InMemorySecureStore(),
  encryptionKeyKey: 'realm_key',
  passwordKey: 'password_key',
);

final encrypted = await encryption.encryptPassword('secret123');
final decrypted = await encryption.decryptPassword(encrypted);
```

👨‍🔧 Implémentation par défaut fournie : `InMemorySecureStore`.

---

## 🧰 Utilitaires intégrés

### Validation

```dart
ValidationHelper.isValidEmail('test@mail.com');
ValidationHelper.isRequired('valeur');
```

### Helpers

- `StringHelper.capitalize("test")`
- `NumberHelper.toFixed(3.14159, 2)`
- `DateHelper.format(DateTime.now())`
- `FileHelper.readFile(path)`

---

## 📖 Architecture

Basé sur Clean Architecture :

```
feature/
├── data/
├── domain/
└── presentation/
```

---

## 📄 Exemples de cas d'utilisation

```dart
class GetUser implements UseCase<User, IdParams> {
  final UserRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(IdParams params) {
    return repository.getById(params.id);
  }
}
```

---

## ✅ À venir

- [ ] Générateur de usecases automatiques
- [ ] Support des tests unitaires pour chaque génération
- [ ] Plugin VSCode / CLI interactif

---

## 📝 Licence

[MIT](LICENSE)

---

## 👨‍💻 Auteur

Développé par [Youdev](https://github.com/fayeyoussou)
