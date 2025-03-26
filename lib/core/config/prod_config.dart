
import 'api_config.dart';

class ProdConfig {
  ProdConfig._();

  static ApiConfiguations apiConfig = ApiConfiguations(
    staticURL: {},
    host: {
      "auth": ApiConfig(
        url: "https://rms.rbstaging.in/api/v2",
        headerData: {
          'appId': "5a56ff0749ca4ba88cc762e8696d424d",
          'apiSecretKey': "120082229742359458532408477966240924237",
        },
        apiEndpoints: {
          //onboarding
          "get_otp": ApiEndpoint(path: "/auth/otp/generate-otp", method: Method.POST),
          "verify_otp": ApiEndpoint(path: "/auth/otp/verify-otp", method: Method.POST),
          "questionnaire_create": ApiEndpoint(path: "/customer/questionare/create_question_response", method: Method.POST),
          "questionnaire_get": ApiEndpoint(path: "/customer/questionare/get_questions", method: Method.GET),
          //Offline Documents
          "get_policy":ApiEndpoint(path: "/customer/policies/", method: Method.GET),
          "get_family":ApiEndpoint(path: "/customer/family-details", method: Method.GET),
          "post_policy":ApiEndpoint(path: "/customer/policies/upload_policy", method: Method.POST),
          "delete_policy":ApiEndpoint(path: "/customer/policies/", method: Method.DELETE),

          // Family Details
          "fetch_family_details": ApiEndpoint(
              path: "/customer/family-details", method: Method.GET),
          "create_family_details": ApiEndpoint(
              path: "/customer/family-details", method: Method.POST),
          "update_family_details": ApiEndpoint(
              path: "/customer/family-details/{family_id}",
              method: Method.PATCH),
          "delete_family_details": ApiEndpoint(
              path: "/customer/family-details/{family_id}",
              method: Method.DELETE),
        },
      )
    },
  );
}