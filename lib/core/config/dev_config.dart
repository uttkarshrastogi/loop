
import 'api_config.dart';

class DevConfig {
  DevConfig._();
  static ApiConfiguations apiConfig = ApiConfiguations(
    staticURL: {
      "termsAndConditions":
          "https://www.renewbuy.com/terms-conditions?mobileApp=true",
      "privacy_policy":
          "https://www.renewbuy.com/privacy-policy?mobileApp=true",
      "terms_conditions":
          "https://www.renewbuy.com/terms-conditions?mobileApp=true",
      "sip_calculator":
          "https://react.rbstaging.in/calculators/sip-calculator?mobileApp=true",
      "term_insurance":
          "https://react.rbstaging.in/calculators/term-coverage?mobileApp=true",
      "bmi_calculator":
          "https://react.rbstaging.in/calculators/bmi-calculator?mobileApp=true",
      "child_saving_calculator":
          "https://react.rbstaging.in/calculators/child-education-planning?mobileApp=true",
      "saving_calculator":
          "https://react.rbstaging.in/calculators/savings-calculator?mobileApp=true",
      "loan_protection":
          "https://react.rbstaging.in/calculators/loan-protection-calculator?mobileApp=true",
      "income_replacement":
          "https://react.rbstaging.in/calculators/income-replacement-calculator?mobileApp=true",
      "tax_saving":
          "https://react.rbstaging.in/calculators/tax-saving-calculator?mobileApp=true",
      "health_insurance":
          "https://react.rbstaging.in/calculators/health-coverage?mobileApp=true",
      "motor_apex": 'https://apex.renewbuyinsurance.com/motor/',
      "tollfreeNumber": '18004197852',
      "loginTerms": 'https://www.renewbuy.com/terms-conditions?mobileApp=true',
      //shop
      "Motor": "https://apex.renewbuyinsurance.com/motor/",//?mobile_no=1234567891
      "Health": "https://health.renewbuyinsurance.com/health/basic-details",
      "Life": "https://www.renewbuyinsurance.com/life-insurance",//cookies
      "For_commercial_vehicle":
          "https://www.renewbuyinsurance.com/motor-insurance",//cookies
      "RB_Health":
          "https://www.renewbuyfinsure.com/renewbuy-health/#/buy-online",
      "Auto_Loans": "https://www.renewbuyfinsure.com/autoloan/calculator/6",
    },
    host: {
      "unicorn": ApiConfig(
        url: "https://api-unicorn.rbstaging.in/api/v1/unicorn",
        headerData: {
          "appId": "5a56ff0749ca4ba88cc762e8696d424d",
          "apiSecretKey": "120082229742359458532408477966240924237",
        },
        apiEndpoints: {
          //onboarding
          "get_otp":
              ApiEndpoint(path: "/auth/otp/generate-otp", method: Method.POST),
          "verify_otp":
              ApiEndpoint(path: "/auth/otp/verify-otp", method: Method.POST),

          "verify_mobile":
              ApiEndpoint(path: "/auth/otp/verify-mobile", method: Method.POST),
          "verify_pan":
              ApiEndpoint(path: "/tp-service/pan/", method: Method.POST),
          "upload_puc": ApiEndpoint(
              path: "/customer/vehicle/upload_puc_doc", method: Method.POST),
          "update_family_pic": ApiEndpoint(
              path: "/customer/update_family_pic", method: Method.PATCH),

          "questionnaire_create": ApiEndpoint(
              path: "/customer/questionare/create_question_response",
              method: Method.POST),
          "questionnaire_get": ApiEndpoint(
              path: "/customer/questionare/get_questions", method: Method.GET),
          "get_profile":
              ApiEndpoint(path: "/auth/user/user-details", method: Method.GET),
          "update_profile": ApiEndpoint(
              path: "/auth/user/user-details", method: Method.PATCH),
          "update_profile_pic": ApiEndpoint(
              path: "/auth/user/update-profile-pic", method: Method.PATCH),
          "delete_user":
              ApiEndpoint(path: "/auth/user/delete_user", method: Method.POST),

          "get_city":
              ApiEndpoint(path: "/customer/city/get_city", method: Method.GET),
          //Offline Documents
          "get_policy":
              ApiEndpoint(path: "/customer/policies/", method: Method.GET),
          "get_family":
              ApiEndpoint(path: "/customer/family-details", method: Method.GET),
          "post_policy": ApiEndpoint(
              path: "/customer/policies/upload_policy", method: Method.POST),
          "delete_policy": ApiEndpoint(
              path: "/customer/policies/{id}", method: Method.DELETE),

          // Family Details
          "fetch_family_details":
              ApiEndpoint(path: "/customer/family-details", method: Method.GET),
          "fetch_family_id_details": ApiEndpoint(
              path: "/customer/family_details_by_id/{id}", method: Method.GET),
          "create_family_details": ApiEndpoint(
              path: "/customer/family-details", method: Method.POST),
          "update_family_details": ApiEndpoint(
              path: "/customer/family-details/{family_id}",
              method: Method.PATCH),
          "delete_family_details": ApiEndpoint(
              path: "/customer/family-details/{family_id}",
              method: Method.DELETE),

          //support
          "fetch_policy_number": ApiEndpoint(
              path: "/customer/policies/get_policy_numbers",
              method: Method.POST),
          "fetch_policy_details": ApiEndpoint(
              path: "/customer/policies/get_policy_by_number",
              method: Method.POST),
          "submit_feedback": ApiEndpoint(
              path: "/customer/helpdesk/create_feedback", method: Method.POST),
          "get_support_ticket_list": ApiEndpoint(
              path: "/customer/helpdesk/consumer_tickets", method: Method.GET),

          //Vehicle
          "get_vehicle":
              ApiEndpoint(path: "/customer/vehicle/", method: Method.GET),
          "add_vehicle":
              ApiEndpoint(path: "/customer/vehicle/", method: Method.POST),
          "validate_vehicle": ApiEndpoint(
              path: "/customer/vehicle/validate_user_vehicle",
              method: Method.POST),
          "delete_vehicle": ApiEndpoint(
              path:
                  "/customer/vehicle/delete_user_vehicle?vehicle_id={vehicle_id}",
              method: Method.DELETE),
          "vehicle_challan": ApiEndpoint(
              path:
                  "/customer/vehicle/challan_details?vehicle_number={vehicle_number}",
              method: Method.GET),

          //home
          "get_policy_card": ApiEndpoint(
              path: "/customer/policies/user_policy_renewal",
              method: Method.GET),
        },
      ),
      "search": ApiConfig(url: "https://dev.renewbuy.com/api/v1", headerData: {
        "appId": "5a56ff0749ca4ba88cc762e8696d424d",
        "apiSecretKey": "120082229742359458532408477966240924237",
      }, apiEndpoints: {
        //support
        "fetch_financier":
            ApiEndpoint(path: "/search/financier//", method: Method.GET),
        "fetch_manufacturer":
            ApiEndpoint(path: "/search/manufacturer/", method: Method.GET),
        "fetch_model": ApiEndpoint(path: "/search/model/", method: Method.GET),
        "fetch_variant":
            ApiEndpoint(path: "/search/variant/", method: Method.GET),
      }),
      "unicornV2": ApiConfig(
        url: "https://myaccount.rbstaging.in/api/v2",
        headerData: {
          "key-1": "7b574be9-96c2-4afc-934e-a333f9d27e94",
          "key-2": "YiBYbVTAOIT6TD2k8L3S22pou4IVBdR6",
        },
        apiEndpoints: {
          //support
          "fetch_endorsement_type": ApiEndpoint(path: "", method: Method.GET),
          "fetch_document":
              ApiEndpoint(path: "/tickets/document_list/", method: Method.POST),
          "create_endorsement_ticket": ApiEndpoint(
              path: "/tickets/create_ticket/", method: Method.POST),
          "create_ticket":
              ApiEndpoint(path: "/tickets/create_ticket/", method: Method.POST),
          "create_add_ticket": ApiEndpoint(
              path: "/tickets/additional_files_upload/",
              method: Method.POST), //claims
        },
      ),
      "unicornCms": ApiConfig(
        url: "https://cms.rbstaging.in/api",
        headerData: {
          'Authorization':
              'Bearer a85cf4c337b5e41691b41c492bb8a11b05e4c632c3bf90f8ec216eaabce091ce67379d12ba8d8afe13ebb12d76e5dfe84b573f90e04c7957f7d0c2bd37e638bc2cbc0b9eb7b7460749d5c7fd861cad16801994a9d23caa677f2fe90dfc0056a0310860ab865a1a1cfb8f7d556e0c433cd5e946a533bf9f20c197c9484f35be3c',
        },
        apiEndpoints: {
          //support
          "fetch_faq": ApiEndpoint(path: "/faq-helps", method: Method.GET),
          "home_content":
              ApiEndpoint(path: "/app-home-page", method: Method.GET),
        },
      ),
    },
  );
}
