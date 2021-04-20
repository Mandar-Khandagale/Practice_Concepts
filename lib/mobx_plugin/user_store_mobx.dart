import 'package:form/model_classes/user_data_model_class.dart';
import 'package:form/mobx_plugin/network_services.dart';
import 'package:mobx/mobx.dart';

part 'user_store_mobx.g.dart';

/// Used to create observable and action for observers in mobx plugin

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store{

  final NetworkServices httpClient = NetworkServices();

  @observable
  ObservableFuture<List<UsersData>> userListFuture;

  @action
  Future fetchUsers() => userListFuture = ObservableFuture(httpClient.getData('https://jsonplaceholder.typicode.com/todos').
  then((users) => users));
}