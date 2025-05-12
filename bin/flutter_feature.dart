import 'dart:io';

/// Point d'entrée du script CLI.
/// Gère les arguments de ligne de commande pour créer automatiquement des fichiers de features, pages et cubits.
void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart flutter_feature.dart add <type> <feature_name> [name]');
    exit(1);
  }

  final action = arguments[0];

  if (action == 'add') {
    if (arguments.length < 3) {
      print('Usage: dart flutter_feature.dart add <type> <feature_name> [name]');
      exit(1);
    }

    final type = arguments[1];           // Type : feature, page ou cubit
    final featureName = arguments[2];    // Nom de la feature
    final baseDir = 'lib/features/$featureName'; // Chemin racine de la feature
    final featureClassName = toCapitalCase(featureName); // Nom en PascalCase

    if (type == 'feature') {
      createFeature(featureName, featureClassName, baseDir);
    } else if (type == 'page') {
      if (arguments.length < 4) {
        print('Usage: dart flutter_feature.dart add page <feature_name> <page_name>');
        exit(1);
      }
      final pageName = arguments[3];
      createPage(featureName, featureClassName, baseDir, pageName);
    } else if (type == 'cubit') {
      if (arguments.length < 4) {
        print('Usage: dart flutter_feature.dart add cubit <feature_name> <cubit_name>');
        exit(1);
      }
      final cubitName = arguments[3];
      createCubit(featureName, featureClassName, baseDir, cubitName);
    } else {
      print('Unknown type: $type');
      exit(1);
    }
  } else {
    print('Unknown action: $action');
    exit(1);
  }
}

/// Crée la structure complète d’une feature avec ses dossiers, classes et fichiers bloc, modèle, repository, etc.
void createFeature(String featureName, String featureClassName, String baseDir) {
  final directories = [
    '$baseDir/data/datasources',
    '$baseDir/data/models',
    '$baseDir/data/repositories',
    '$baseDir/domain/entities',
    '$baseDir/domain/repositories',
    '$baseDir/domain/usecases',
    '$baseDir/presentation/bloc',
    '$baseDir/presentation/pages',
    '$baseDir/presentation/widgets',
  ];

  for (var dir in directories) {
    Directory(dir).createSync(recursive: true);
  }

  // Fichier du data source
  File('$baseDir/data/datasources/${featureName}_data_source.dart')
      .writeAsStringSync('''
abstract interface class ${featureClassName}DataSource {
  // TODO: Définir les méthodes du data source
}
''');

  // Implémentation remote du data source
  File('$baseDir/data/datasources/${featureName}_remote_data_source.dart')
      .writeAsStringSync('''
import '${featureName}_data_source.dart';

class ${featureClassName}RemoteDataSource implements ${featureClassName}DataSource {
  // TODO: Implémenter les méthodes du data source
}
''');

  // Fichier modèle
  File('$baseDir/data/models/${featureName}_model.dart')
      .writeAsStringSync('''
import '../../domain/entities/$featureName.dart';

class ${featureClassName}Model extends $featureClassName {
  // TODO: Implémenter les modèles
}
''');

  // Interface repository
  File('$baseDir/domain/repositories/${featureName}_repository.dart')
      .writeAsStringSync('''
abstract interface class ${featureClassName}Repository {
  // TODO: Définir les méthodes du repository
}
''');

  // Implémentation du repository
  File('$baseDir/data/repositories/${featureName}_repository_impl.dart')
      .writeAsStringSync('''
import '../../domain/repositories/${featureName}_repository.dart';
import '../datasources/${featureName}_data_source.dart';

class ${featureClassName}RepositoryImpl implements ${featureClassName}Repository {
  final ${featureClassName}DataSource dataSource;

  ${featureClassName}RepositoryImpl(this.dataSource);

  // TODO: Implémenter les méthodes du repository
}
''');

  // Entité de domaine
  File('$baseDir/domain/entities/$featureName.dart')
      .writeAsStringSync('''
class $featureClassName {
  // TODO: Définir les propriétés et méthodes
}
''');

  // Bloc principal
  File('$baseDir/presentation/bloc/${featureName}_bloc.dart')
      .writeAsStringSync('''
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '${featureName}_event.dart';
part '${featureName}_state.dart';

class ${featureClassName}Bloc extends Bloc<${featureClassName}Event, ${featureClassName}State> {
  ${featureClassName}Bloc() : super(${featureClassName}InitialState()) {
    on<${featureClassName}Event>((event, emit) {
      // TODO: Implémenter le comportement des événements
    });
  }
}
''');

  // Events du bloc
  File('$baseDir/presentation/bloc/${featureName}_event.dart')
      .writeAsStringSync('''
part of '${featureName}_bloc.dart';

@immutable
sealed class ${featureClassName}Event {}

class ${featureClassName}InitialEvent extends ${featureClassName}Event {}
''');

  // States du bloc
  File('$baseDir/presentation/bloc/${featureName}_state.dart')
      .writeAsStringSync('''
part of '${featureName}_bloc.dart';

@immutable
sealed class ${featureClassName}State {}

class ${featureClassName}InitialState extends ${featureClassName}State {}

class ${featureClassName}LoadingState extends ${featureClassName}State {}

class ${featureClassName}FailureState extends ${featureClassName}State {
  final String message;
  ${featureClassName}FailureState(this.message);
}
''');

  // Page liste par défaut
  File('$baseDir/presentation/pages/${featureName}_list_page.dart')
      .writeAsStringSync('''
import 'package:flutter/material.dart';
import '../../../../core/widgets/reusable/page_layout.dart';

class ${featureClassName}ListPage extends StatelessWidget {
  static const String route = "/$featureName/liste";
  const ${featureClassName}ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      body: Container(),
      // TODO: Implémenter la page UI
    );
  }
}
''');

  print('Feature "$featureName" créée avec succès !');
}

/// Crée un fichier de page Flutter dans une feature existante.
void createPage(String featureName, String featureClassName, String baseDir, String pageName) {
  final pageClassName = '$featureClassName${toCapitalCase(pageName)}Page';
  final pageFileName = '${featureName}_${pageName}_page.dart';
  final pageDir = '$baseDir/presentation/pages';

  Directory(pageDir).createSync(recursive: true);

  File('$pageDir/$pageFileName').writeAsStringSync('''
import 'package:flutter/material.dart';
import '../../../../core/widgets/reusable/page_layout.dart';

class $pageClassName extends StatelessWidget {
  static const String route = "/$featureName/$pageName";
  const $pageClassName({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      body: Container(),
      // TODO: Implémenter la page UI
    );
  }
}
''');

  print('Page "$pageName" pour feature "$featureName" créée avec succès !');
}

/// Crée un cubit simple pour une feature ou pour le core.
void createCubit(String featureName, String featureClassName, String baseDir, String cubitName) {
  final cubitClassName = '${toCapitalCase(cubitName)}Cubit';
  final cubitFileName = '${cubitName}_cubit.dart';
  final cubitDir = featureName == 'core'
      ? 'lib/core/cubits/$cubitName'
      : '$baseDir/presentation/cubits/$cubitName';

  Directory(cubitDir).createSync(recursive: true);

  File('$cubitDir/$cubitFileName').writeAsStringSync('''
import 'package:flutter_bloc/flutter_bloc.dart';

class $cubitClassName extends Cubit<dynamic> {
  $cubitClassName() : super(null);

  // TODO: Implémenter la logique du Cubit
}
''');

  print('Cubit "$cubitName" créé avec succès !');
}

/// Convertit une chaîne snake_case ou kebab-case en PascalCase.
String toCapitalCase(String text) {
  return text.split(RegExp(r'[_\-]')).map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1);
  }).join();
}
