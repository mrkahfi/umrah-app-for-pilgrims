// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ArticleStore on _ArticleStoreBase, Store {
  Computed<bool> _$isArticleEmptyComputed;

  @override
  bool get isArticleEmpty =>
      (_$isArticleEmptyComputed ??= Computed<bool>(() => super.isArticleEmpty,
              name: '_ArticleStoreBase.isArticleEmpty'))
          .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_ArticleStoreBase.loading'))
      .value;

  final _$fetchArticlesFutureAtom =
      Atom(name: '_ArticleStoreBase.fetchArticlesFuture');

  @override
  ObservableFuture<ArticleList> get fetchArticlesFuture {
    _$fetchArticlesFutureAtom.reportRead();
    return super.fetchArticlesFuture;
  }

  @override
  set fetchArticlesFuture(ObservableFuture<ArticleList> value) {
    _$fetchArticlesFutureAtom.reportWrite(value, super.fetchArticlesFuture, () {
      super.fetchArticlesFuture = value;
    });
  }

  final _$articleAtom = Atom(name: '_ArticleStoreBase.article');

  @override
  Article get article {
    _$articleAtom.reportRead();
    return super.article;
  }

  @override
  set article(Article value) {
    _$articleAtom.reportWrite(value, super.article, () {
      super.article = value;
    });
  }

  final _$articleListDataAtom = Atom(name: '_ArticleStoreBase.articleListData');

  @override
  ObservableList<Article> get articleListData {
    _$articleListDataAtom.reportRead();
    return super.articleListData;
  }

  @override
  set articleListData(ObservableList<Article> value) {
    _$articleListDataAtom.reportWrite(value, super.articleListData, () {
      super.articleListData = value;
    });
  }

  final _$successAtom = Atom(name: '_ArticleStoreBase.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$getArticlesAsyncAction = AsyncAction('_ArticleStoreBase.getArticles');

  @override
  Future<dynamic> getArticles() {
    return _$getArticlesAsyncAction.run(() => super.getArticles());
  }

  @override
  String toString() {
    return '''
fetchArticlesFuture: ${fetchArticlesFuture},
article: ${article},
articleListData: ${articleListData},
success: ${success},
isArticleEmpty: ${isArticleEmpty},
loading: ${loading}
    ''';
  }
}
