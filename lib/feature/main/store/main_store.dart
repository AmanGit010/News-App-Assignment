import 'package:mobx/mobx.dart';
part 'main_store.g.dart';

class MainStore = _MainStoreBase with _$MainStore;

abstract class _MainStoreBase with Store {
  @observable
  bool isLoading = false;

  @observable
  bool isGridView = false;

  @action
  void toggleGridView() {
    isGridView = !isGridView;
  }

  // @action
  // Future<void> getNews() {
  //   return ;
  // }
}
