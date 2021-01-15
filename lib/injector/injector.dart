import 'package:get_it/get_it.dart';
import 'package:runn_wear/repositories/marathon_repository.dart';
import 'package:runn_wear/repositories/user_repository.dart';
import 'package:runn_wear/services/api_service.dart';
import 'package:runn_wear/services/auth_service.dart';
import 'package:runn_wear/services/rest_api_service.dart';

GetIt injector = GetIt.instance;

extension Init on GetIt {
  void setup() {
    this.registerSingleton<AuthService>(GoogleAuth());
    this.registerSingleton<APIService>(ReSTAPIService());
    this.registerSingleton<MarathonRepository>(MarathonRepository());
    this.registerSingleton<UserRepository>(UserRepository());
  }

  void tearDown() {
    this.unregister<APIService>();
  }
}
