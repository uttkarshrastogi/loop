import 'api_config.dart';

class DevConfig {
  DevConfig._();
  static ApiConfiguations apiConfig = ApiConfiguations(
    staticURL: {},
    host: {
      "render": ApiConfig(
        url: "https://loop-backend-8uow.onrender.com/api",
        headerData: {
          // "appId": "5a56ff0749ca4ba88cc762e8696d424d",
          // "apiSecretKey": "120082229742359458532408477966240924237",
        },
        apiEndpoints: {
          //onboarding
          "create_goal": ApiEndpoint(
            path: "/goals/create/",
            method: Method.POST,
          ),"get_goal": ApiEndpoint(
            path: "/goals/get/",
            method: Method.GET,
          ),"update_goal": ApiEndpoint(
            path: "/goals/update/{goal_id}",
            method: Method.PATCH,
          ),"delete_goal": ApiEndpoint(
            path: "/goals/delete/{goal_id}",
            method: Method.DELETE,
          ),
        },
      ),
    },
  );
}
