/// Représente les paramètres utilisés pour la pagination d'une liste.
/// 
/// Cette classe est utile pour gérer la récupération de données paginées,
/// notamment dans le cadre d'une API ou d'une interface utilisateur avec défilement infini.
///
/// - [pageKey] : identifiant de la page actuelle (souvent l’offset ou l’index de page).
/// - [pageSize] : nombre d’éléments à récupérer par page.
/// - [searchQuery] : chaîne de recherche facultative à appliquer à la requête.
class PageQueryParams {
  final int pageKey;
  final int pageSize;
  final String? searchQuery;

  /// Crée une instance de [PageQueryParams] avec les paramètres spécifiés.
  PageQueryParams({
    required this.pageKey,
    required this.pageSize,
    this.searchQuery,
  });
}
