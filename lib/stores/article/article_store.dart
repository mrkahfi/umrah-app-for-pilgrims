import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/article/article.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
part 'article_store.g.dart';

class ArticleStore = _ArticleStoreBase with _$ArticleStore;

abstract class _ArticleStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _ArticleStoreBase(Repository repository) {
    this._repository = repository;
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<ArticleList> emptyArticleResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<ArticleList> fetchArticlesFuture =
      ObservableFuture<ArticleList>(emptyArticleResponse);

  @observable
  Article article;

  @observable
  ObservableList<Article> articleListData = ObservableList<Article>();

  @observable
  bool success = false;

  @computed
  bool get isArticleEmpty => articleListData.isEmpty;

  @computed
  bool get loading => fetchArticlesFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getArticles() async {
    final future = _repository.getArticles();
    fetchArticlesFuture = ObservableFuture(future);

    future.then((articleList) {
      if (articleListData.isNotEmpty) {
        articleListData.clear();
      }
      articleListData.addAll(articleList.articles);
    }).catchError((error) async {
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
