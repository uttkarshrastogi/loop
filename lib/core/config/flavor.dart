import 'dev_config.dart';
import 'prod_config.dart';

//For dev make it true
const _isDev = true;

class FlavorConfig {
  FlavorConfig._();

  static var config = _isDev ? DevConfig.apiConfig : ProdConfig.apiConfig;

  static bool isDev = _isDev;
}
