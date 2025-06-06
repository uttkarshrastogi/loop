import 'api_config.dart';

class DevConfig {
  DevConfig._();

  static ApiConfiguations apiConfig = ApiConfiguations(
    staticURL: {},
    host: {
      "mistral": ApiConfig(
        url: "http://10.0.2.2:11434",
        headerData: {
          // Example headers if needed
          // "appId": "YOUR_APP_ID",
          // "apiSecretKey": "YOUR_SECRET_KEY",
        },
        apiEndpoints: {
          "chat_completions": ApiEndpoint(
            path: "/api/generate",
            method: Method.POST,
          ),
          // Add more endpoints if required later
        },
      ),
      "open-router": ApiConfig(
        url: "https://openrouter.ai",
        headerData: {
          // Example headers if needed
          // "appId": "YOUR_APP_ID",
          // "apiSecretKey": "YOUR_SECRET_KEY",
        },
        apiEndpoints: {
          "chat_completions": ApiEndpoint(
            path: "/api/v1/completions",
            method: Method.POST,
          ),
          // Add more endpoints if required later
        },
      ),
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
      "firebase": ApiConfig(
        url: "https://generateplan-2dsjy3di5q-uc.a.run.app",
        headerData: {
          // Example headers if needed
          // "appId": "YOUR_APP_ID",
          // "apiSecretKey": "YOUR_SECRET_KEY",
        },
        apiEndpoints: {
          "chat_completions": ApiEndpoint(
            path: "",
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
