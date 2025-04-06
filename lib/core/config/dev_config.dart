import 'api_config.dart';

class DevConfig {
  DevConfig._();

  static ApiConfiguations apiConfig = ApiConfiguations(
    staticURL: {},
    host: {
      "ai": ApiConfig(
        url: "https://api.rabbithole.cred.club/v1",
        headerData: {
          // Example headers if needed
          // "appId": "YOUR_APP_ID",
          // "apiSecretKey": "YOUR_SECRET_KEY",
        },
        apiEndpoints: {
          "chat_completions": ApiEndpoint(
            path: "/chat/completions",
            method: Method.POST,
          ),
          // Add more endpoints if required later
        },
      ),

      "render": ApiConfig(
        url: "https://loop-backend-8uow.onrender.com/api",
        headerData: {
          // Example headers if needed
          // "appId": "YOUR_APP_ID",
          // "apiSecretKey": "YOUR_SECRET_KEY",
        },
        apiEndpoints: {
          // Goal Endpoints
          "create_goal": ApiEndpoint(
            path: "/goals/create/",
            method: Method.POST,
          ),
          "get_goal": ApiEndpoint(
            path: "/goals/get/",
            method: Method.GET,
          ),
          "update_goal": ApiEndpoint(
            path: "/goals/update/{goal_id}",
            method: Method.PATCH,
          ),
          "delete_goal": ApiEndpoint(
            path: "/goals/delete/{goal_id}",
            method: Method.DELETE,
          ),
        },
      ),
    },
  );
}
