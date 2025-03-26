import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

// Sealed class for event names
class AnalyticsEvent {
  final String name;

  const AnalyticsEvent._(this.name);

  // Define allowed events
  static const AnalyticsEvent login = AnalyticsEvent._('login');
  static const AnalyticsEvent logout = AnalyticsEvent._('logout');
  static const AnalyticsEvent motorPolicy = AnalyticsEvent._('motor_policy');
  static const AnalyticsEvent lifePolicy = AnalyticsEvent._('life_policy');
  static const AnalyticsEvent healthPolicy = AnalyticsEvent._('health_policy');
  static const AnalyticsEvent policyCardHome =
      AnalyticsEvent._('policy_card_home');
  static const AnalyticsEvent addPolicyHome =
      AnalyticsEvent._('add_policy_home');
  static const AnalyticsEvent vehiclePolicyCardHome =
      AnalyticsEvent._('vehicle_policy_card_home');
  static const AnalyticsEvent vehicleChallanCardHome =
      AnalyticsEvent._('vehicle_challan_card_home');
  static const AnalyticsEvent vehiclePolutionCardHome =
      AnalyticsEvent._('vehicle_pollution_card_home');
  static const AnalyticsEvent exploreGarage =
      AnalyticsEvent._('explore_garage');
  static const AnalyticsEvent setupYourFinance =
      AnalyticsEvent._('setup_your_finance');
  static const AnalyticsEvent setupYourHealth =
      AnalyticsEvent._('setup_your_health');
  static const AnalyticsEvent vehicleSetting =
      AnalyticsEvent._('vehicle_setting');
  static const AnalyticsEvent vehicleRemoved =
      AnalyticsEvent._('vehicle_removed');
  static const AnalyticsEvent vehiclePolicyCard =
      AnalyticsEvent._('vehicle_policy_card');
  static const AnalyticsEvent vehicleChallanCard =
      AnalyticsEvent._('vehicle_challan_card');
  static const AnalyticsEvent vehiclePolutionCard =
      AnalyticsEvent._('vehicle_pollution_card');
  static const AnalyticsEvent vehicleFastagCard =
      AnalyticsEvent._('vehicle_fastag_card');
  static const AnalyticsEvent vehicleClaimCard =
      AnalyticsEvent._('vehicle_claim_card');
  static const AnalyticsEvent viewAllCalculators =
      AnalyticsEvent._('view_all_calculators');
  static const AnalyticsEvent sipCalculator =
      AnalyticsEvent._('sip_calculator');
  static const AnalyticsEvent termInsuranceCalculator =
      AnalyticsEvent._('term_insurance_calculator');
  static const AnalyticsEvent bmiCalculator =
      AnalyticsEvent._('bmi_calculator');
  static const AnalyticsEvent childSavingCalculator =
      AnalyticsEvent._('child_saving_calculator');
  static const AnalyticsEvent savingCalculator =
      AnalyticsEvent._('saving_calculator');
  static const AnalyticsEvent loanProtectionCalculator =
      AnalyticsEvent._('loan_protection_calculator');
  static const AnalyticsEvent incomeReplacementCalculator =
      AnalyticsEvent._('income_replacement_calculator');
  static const AnalyticsEvent healthInsuranceCalculator =
      AnalyticsEvent._('health_insurance_calculator');
  static const AnalyticsEvent taxSavingCalculator =
      AnalyticsEvent._('tax_saving_calculator');
  static const AnalyticsEvent familyMemberDeleted =
      AnalyticsEvent._('family_member_deleted');
  static const AnalyticsEvent policyDownload =
      AnalyticsEvent._('policy_download');
  static const AnalyticsEvent policyPreview =
      AnalyticsEvent._('policy_preview');

  // Factory constructor to allow custom event names
  factory AnalyticsEvent(String eventName) {
    return AnalyticsEvent._(eventName);
  }
}

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Generic function to log events
  static Future<void> logEvent(AnalyticsEvent event,
      {Map<String, Object>? parameters}) async {
    log('Event: ${event.name} ${parameters != null ? ', Parameters : $parameters' : ""}');
    await _analytics
        .logEvent(
      name: event.name,
      parameters: parameters,
    )
        .catchError((e) {
      log('Even error: ${e.toString()}');
    });
  }
}
