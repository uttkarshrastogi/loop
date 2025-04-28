import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:loop/core/config/flavor.dart';
import 'package:loop/core/services/analytics_service.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';

final List<Map<String, dynamic>> policyNoDataFound = [
  {
    "id": 1,
    "title": "Buy your\nMotor Insurance",
    "subtitle": "",
    "image": "assets/images/icon_motor.png",
    "screen": "Insurance",
  },
  {
    "id": 2,
    "title": "Buy your\nLife Insurance",
    "subtitle": "",
    "image": "assets/images/icon_life.png",
    "screen": "Insurance",
  },
  {
    "id": 3,
    "title": "Buy your\nHealth Insurance",
    "subtitle": "",
    "image": "assets/images/icon_health.png",
    "screen": "Insurance",
  },
];

final List<Map<String, dynamic>> filterLobOptions = [
  {"title": "Motor", "policy_type": 1, "event": AnalyticsEvent.motorPolicy},
  {"title": "Life", "policy_type": 2, "event": AnalyticsEvent.lifePolicy},
  {"title": "Health", "policy_type": 3, "event": AnalyticsEvent.healthPolicy},
];

final List<Map<String, dynamic>> calculators = [
  {
    "title": "SIP",
    "icon": LucideIcons.calendar,
    "color": AppColors.pelorous50,
    "url": FlavorConfig.config.staticURL["sip_calculator"],
    "event": AnalyticsEvent.sipCalculator,
  },
  {
    "title": "Term Insurance",
    "icon": LucideIcons.plus,
    "color": AppColors.bittersweet50,
    "url": FlavorConfig.config.staticURL["term_insurance"],
    "event": AnalyticsEvent.termInsuranceCalculator,
  },
  {
    "title": "BMI",
    "icon": LucideIcons.heart,
    "color": AppColors.fuchsiaPink50,
    "url": FlavorConfig.config.staticURL["bmi_calculator"],
    "event": AnalyticsEvent.bmiCalculator,
  },
  {
    "title": "Child Saving",
    "icon": LucideIcons.banknote,
    "color": AppColors.emerald50,
    "url": FlavorConfig.config.staticURL["child_saving_calculator"],
    "event": AnalyticsEvent.childSavingCalculator,
  },
  {
    "title": "Savings",
    "icon": LucideIcons.calendar,
    "color": const Color(0xFFDDEAF7),
    "url": FlavorConfig.config.staticURL["saving_calculator"],
    "event": AnalyticsEvent.savingCalculator,
  },
  {
    "title": "Loan Protection",
    "icon": LucideIcons.plus,
    "color": const Color(0xFFF5E6EF),
    "url": FlavorConfig.config.staticURL["loan_protection"],
    "event": AnalyticsEvent.loanProtectionCalculator,
  },
  {
    "title": "Income Replacement",
    "icon": LucideIcons.banknote,
    "color": const Color(0xFFE1F2E9),
    "url": FlavorConfig.config.staticURL["income_replacement"],
    "event": AnalyticsEvent.incomeReplacementCalculator,
  },
  {
    "title": "Health Insurance",
    "icon": LucideIcons.calendar,
    "color": const Color(0xFFDDEAF7),
    "url": FlavorConfig.config.staticURL["health_insurance"],
    "event": AnalyticsEvent.healthInsuranceCalculator,
  },
  {
    "title": "Tax Saving",
    "icon": LucideIcons.plus,
    "color": const Color(0xFFF5E6EF),
    "url": FlavorConfig.config.staticURL["tax_saving"],
    "event": AnalyticsEvent.taxSavingCalculator,
  },
];
final List<Map<String, dynamic>> exploreInsurance = [
  {
    "title": "Bike\nInsurance",
    "icon": LucideIcons.bike,
    "color": AppColors.pelorous50,
    "url": FlavorConfig.config.staticURL["Motor"]
  },
  {
    "title": "Car\nInsurance",
    "icon": LucideIcons.car,
    "color": AppColors.bittersweet50,
    "url": FlavorConfig.config.staticURL["Motor"]
  },
  {
    "title": "Commercial Vehicle",
    "icon": LucideIcons.truck,
    "color": AppColors.fuchsiaPink50,
    "url": FlavorConfig.config.staticURL["For_commercial_vehicle"]
  },
  {
    "title": "Health\nInsurance",
    "icon": LucideIcons.shield,
    "color": AppColors.emerald50,
    "url": FlavorConfig.config.staticURL["Health"]
  },
  {
    "title": "Life\nInsurance",
    "icon": LucideIcons.umbrella,
    "color": const Color(0xFFDDEAF7),
    "url": FlavorConfig.config.staticURL["Life"]
  },
];

final List<Map<String, dynamic>> proprietaryProducts = [
  {
    "title": "RB\nHealth",
    "icon": LucideIcons.heartPulse,
    "color": AppColors.pelorous50,
    "url": FlavorConfig.config.staticURL["RB_Health"]
  },
  {
    "title": "Auto\nLoans",
    "icon": LucideIcons.building2,
    "color": AppColors.fuchsiaPink50,
    "url": FlavorConfig.config.staticURL["Auto_Loans"]
  },
];

String getTimeDifference(String startDateStr) {
  try {
    // Parse the datetime string
    DateTime startDate = DateTime.parse(startDateStr);
    DateTime endDate = DateTime.now();

    Duration difference = endDate.difference(startDate);

    // Get differences in various units
    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    // Format the output
    if (days > 0) {
      return 'Last visited $days days ago';
    } else if (hours > 0) {
      return 'Last visited ${hours}h  ago';
    } else if (minutes > 0) {
      return 'Last visited ${minutes}m ago';
    } else {
      return '';
    }
  } catch (e) {
    print('Error calculating time difference: $e');
    return 'Invalid date';
  }
}

String formatPolicyNumber(String? policyNumber, {int breakAt = 15}) {
  if (policyNumber == null || policyNumber.isEmpty) {
    return "Policy Number : N/A\n";
  }

  if (policyNumber.length < breakAt) {
    return '${policyNumber}\n';
  }

  return policyNumber;
}

String getImageExtension(String url) {
  return url.split('.').last.toLowerCase(); // Get the file extension
}

const List<String> relationshipList = <String>[
  'Spouse',
  'Daughter',
  'Son',
  'Father',
  'Mother',
  'Mother in Law',
  'Father in Law',
];

String getRelationshipName(int? relationId) {
  switch (relationId) {
    case 1:
      return "Spouse";
    case 2:
      return "Son";
    case 3:
      return "Daughter";
    case 4:
      return "Father";
    case 5:
      return "Mother";
    case 6:
      return "Mother in Law";
    case 7:
      return "Father in Law";
    default:
      return "Unknown";
  }
}

int? getRelationshipId(String relationshipName) {
  switch (relationshipName.toLowerCase()) {
    case "spouse":
      return 1;
    case "son":
      return 2;
    case "daughter":
      return 3;
    case "father":
      return 4;
    case "mother":
      return 5;
    case "mother in law":
      return 6;
    case "father in law":
      return 7;
    default:
      return null; // Return null for unknown relationship names
  }
}

String getPolicyTypeName(int? value) {
  switch (value) {
    case 1:
      return "Vehicle Insurance";
    case 2:
      return "Life Insurance";
    case 3:
      return "Health Insurance";
    case 4:
      return "CV Insurance";
    default:
      return "Unknown";
  }
}

int calculateAge(String dateString) {
  int age = 0;

  if (dateString.isNotEmpty || dateString == "NA") {
    // Parse the date string
    DateTime birthDate = DateFormat("dd/MM/yyyy").parseStrict(dateString);
    DateTime today = DateTime.now();

    // Calculate the age
    age = today.year - birthDate.year;

    // Adjust for cases where the birthday hasn't occurred yet this year
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
  }
  return age;
}

String dateConvert(String? dateString) {
  try {
    // Return "NA" if input is null, empty, or invalid
    if (dateString == null || dateString.trim().isEmpty || dateString == "NA") {
      return "NA";
    }

    DateTime dateTime;

    // Check if the input matches the "dd/MM/yyyy" format
    RegExp ddMMyyyyRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (ddMMyyyyRegex.hasMatch(dateString)) {
      // Parse using "dd/MM/yyyy" format
      print(dateString);
      dateTime = DateFormat("dd/MM/yyyy").parseStrict(dateString);
    } else {
      print(dateString);
      // Try parsing using default DateTime.parse()
      dateTime = DateTime.parse(dateString);
    }

    // Format the DateTime object to the desired format

    return DateFormat("dd MMM yyyy").format(dateTime);
  } catch (e) {
    return "N/A"; // Handle parsing errors
  }
}

String dateConvertTime(String? dateString) {
  try {
    // Return "NA" if input is null, empty, or "NA"
    if (dateString == null || dateString.trim().isEmpty || dateString == "NA") {
      return "NA";
    }

    // Parse the date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Format DateTime object to include both date and time
    return DateFormat("dd MMM yyyy, hh:mm a").format(dateTime);
  } catch (e) {
    // Handle any parsing errors
    return "NA";
  }
}

String calculateBirthDate(int age, {bool isCardFormat = false}) {
  try {
    DateTime today = DateTime.now();

    // Calculate the approximate birth year
    int birthYear = today.year - age;

    // Assume the birthdate is today, but replace the year
    DateTime birthDate = DateTime(birthYear, today.month, today.day);

    // Adjust birthdate if the birthday has already occurred this year
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      birthDate = DateTime(birthYear - 1, today.month, today.day);
    }

    // Format the birthdate as dd/MM/yyyy
    if (isCardFormat) {
      return DateFormat("d MMM, yyyy").format(birthDate);
    } else {
      return DateFormat("dd/MM/yyyy").format(birthDate);
    }
  } catch (e) {
    throw FormatException("Invalid input: $e");
  }
}

int getPolicyTypeIndex(String policyType) {
  switch (policyType) {
    case "Motor":
      return 1;
    case "Health":
      return 3;
    case "Life":
      return 2;
    case "CV":
      return 4;
    default:
      throw Exception("Invalid policy type: $policyType");
  }
}

String getPolicyTypeValue(int policyType) {
  switch (policyType) {
    case 1:
      return "Motor";
    case 3:
      return "Health";
    case 2:
      return "Life";
    case 4:
      return "CV";
    default:
      throw Exception("Invalid policy type: $policyType");
  }
}

int getInsurerTypeIndex(String? insurerName) {
  switch (insurerName) {
    case "Aditya Birla Health Insurance Limited":
      return 1;
    case "Aditya Birla Sun Life Insurance":
      return 2;
    case "Bajaj Allianz General Insurance":
      return 3;
    case "Bajaj Allianz Life":
      return 4;
    case "Bharti Axa Life":
      return 5;
    case "Canara HSBC Oriental LI":
      return 6;
    case "Care Health Insurance":
      return 7;
    case "Cholamandalam General Insurance":
      return 8;
    case "Cholamandalam MS General Insurance":
      return 9;
    case "Digit Insurance":
      return 10;
    case "Digit Life":
      return 11;
    case "Edelweiss General Insurance Company":
      return 12;
    case "Edelweiss General Insurance Company Limited":
      return 13;
    case "Edelweiss Tokio Life":
      return 14;
    case "Future Generali General Insurance":
      return 15;
    case "Future Generali India Insurance Company Ltd":
      return 16;
    case "Go Digit General Insurance Ltd":
      return 17;
    case "HDFC ERGO General Insurance":
      return 18;
    case "HDFC Life":
      return 19;
    case "ICICI Lombard":
      return 20;
    case "ICICI Lombard General Insurance":
      return 21;
    case "ICICI Pru":
      return 22;
    case "IFFCO TOKIO General Insurance":
      return 23;
    case "IFFCO Tokio General Insurance Company Limited":
      return 24;
    case "India First Life Insurance":
      return 25;
    case "Zurich Kotak General insurance":
      return 26;
    case "KOTAK MAHINDRA GENERAL INSURANCE COMPANY LTD":
      return 27;
    case "Liberty Videocon General Insurance":
      return 28;
    case "Life Insurance Corporation":
      return 29;
    case "Magma HDI General Insurance":
      return 30;
    case "Manipal Cigna Health Insurance Company Ltd":
      return 31;
    case "Max Life Insurance":
      return 32;
    case "National Insurance":
      return 33;
    case "National Insurance Company Limited":
      return 34;
    case "New India Assurance":
      return 35;
    case "Niva Bupa Health Insurance":
      return 36;
    case "Oriental Insurance":
      return 37;
    case "Oriental Insurance Company":
      return 38;
    case "PNB MetLife":
      return 39;
    case "Pramerica Life Insurance":
      return 40;
    case "Raheja QBE General Insurance":
      return 41;
    case "Reliance General Insurance":
      return 42;
    case "ROYALSUNDARAM ALLIANCE Insurance CO. Ltd.":
      return 43;
    case "Royal Sundaram General Insurance Co. Limited":
      return 44;
    case "SBI General Insurance":
      return 45;
    case "SBI General Insurance Company Ltd":
      return 46;
    case "SBI Life Insurance":
      return 47;
    case "Shriram General Insurance Company":
      return 48;
    case "Shriram General Insurance Company Ltd":
      return 49;
    case "Star Health Insurance":
      return 50;
    case "SUD Life":
      return 51;
    case "TATA AIA Life":
      return 52;
    case "Tata AIG General Insurance":
      return 53;
    case "United India Insurance":
      return 54;
    case "Universal Sompo General Insurance":
      return 55;
    case "Zuno General Insurance Company":
      return 56;

    default:
      return 0;
  }
}

const List<String> insurerList = [
  "Aditya Birla Health Insurance Limited",
  "Aditya Birla Sun Life Insurance",
  "Bajaj Allianz General Insurance",
  "Bajaj Allianz Life",
  "Bharti Axa Life",
  "Canara HSBC Oriental LI",
  "Care Health Insurance",
  "Cholamandalam General Insurance",
  "Cholamandalam MS General Insurance",
  "Digit Insurance",
  "Digit Life",
  "Edelweiss General Insurance Company",
  "Edelweiss General Insurance Company Limited",
  "Edelweiss Tokio Life",
  "Future Generali General Insurance",
  "Future Generali India Insurance Company Ltd",
  "Go Digit General Insurance Ltd",
  "HDFC ERGO General Insurance",
  "HDFC Life",
  "ICICI Lombard",
  "ICICI Lombard General Insurance",
  "ICICI Pru",
  "IFFCO TOKIO General Insurance",
  "IFFCO Tokio General Insurance Company Limited",
  "India First Life Insurance",
  "Zurich Kotak General insurance",
  "KOTAK MAHINDRA GENERAL INSURANCE COMPANY LTD",
  "Liberty Videocon General Insurance",
  "Life Insurance Corporation",
  "Magma HDI General Insurance",
  "Manipal Cigna Health Insurance Company Ltd",
  "Max Life Insurance",
  "National Insurance",
  "National Insurance Company Limited",
  "New India Assurance",
  "Niva Bupa Health Insurance",
  "Oriental Insurance",
  "Oriental Insurance Company",
  "PNB MetLife",
  "Pramerica Life Insurance",
  "Raheja QBE General Insurance",
  "Reliance General Insurance",
  "ROYALSUNDARAM ALLIANCE Insurance CO. Ltd.",
  "Royal Sundaram General Insurance Co. Limited",
  "SBI General Insurance",
  "SBI General Insurance Company Ltd",
  "SBI Life Insurance",
  "Shriram General Insurance Company",
  "Shriram General Insurance Company Ltd",
  "Star Health Insurance",
  "SUD Life",
  "TATA AIA Life",
  "Tata AIG General Insurance",
  "United India Insurance",
  "Universal Sompo General Insurance",
  "Zuno General Insurance Company",
];

Widget calculateDateDifference(String expiryDateString, BuildContext context) {
  if (expiryDateString == "NA" || expiryDateString.isEmpty) {
    return Text(
      "N/A",
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.neutral400,
          ),
    );
  }

  final today = DateTime.now();

  // Parse expiryDate from string
  final expiryDate = DateTime.parse(expiryDateString);

  // Calculate the difference in days
  final difference = expiryDate.difference(today).inDays;

  // Format the expiry date
  final formattedDate = DateFormat('dd MMM yyyy').format(expiryDate);

  if (difference < 0) {
    // Expired
    return Text(
      "Expired",
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.red500,
          height: 20 / 14,
          fontSize: 12,
          fontWeight: FontWeight.w400),
    );
  } else if (difference == 0) {
    // 1 day
    return Text(
      "Today",
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.red500,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 20 / 14,
          ),
    );
  } else if (difference == 1) {
    // 1 day
    return Text(
      "1 day",
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.red500,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 20 / 14),
    );
  } else if (difference < 60) {
    // Less than 60 days
    return Text(
      "${difference} days",
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.red500,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 20 / 14),
    );
  } else {
    // Default to showing the expiry date
    return Text(
      formattedDate,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.neutral600,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 20 / 14,
          ),
    );
  }
}
DateTime dateConvertDateTime(String dateString) {
  try {

    DateTime dateTime;

    // Normalize format: 17/6/2025 -> 17/06/2025
    RegExp normalizeRegex = RegExp(r'^(\d{1,2})/(\d{1,2})/(\d{4})$');
    final match = normalizeRegex.firstMatch(dateString);
    if (match != null) {
      final normalized =
          "${match.group(1)!.padLeft(2, '0')}/${match.group(2)!.padLeft(2, '0')}/${match.group(3)}";
      dateTime = DateFormat("dd/MM/yyyy").parseStrict(normalized);
    } else {
      dateTime = DateTime.parse(dateString); // fallback
    }

    return dateTime;
  } catch (e) {
    return DateTime.now();
  }
}
String formatTo12Hour(String timeStr) {
  try {
    final time = TimeOfDay(
      hour: int.parse(timeStr.split(":")[0]),
      minute: int.parse(timeStr.split(":")[1]),
    );
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt); // 12hr format like "7:00 AM"
  } catch (_) {
    return timeStr;
  }
}

Widget calculateDateDifferenceHome(
    String expiryDateString, BuildContext context) {
  if (expiryDateString == "NA" || expiryDateString.isEmpty) {
    return Text("N/A",
        style: AppTextStyles.paragraphXSmall
            .copyWith(fontWeight: FontWeight.w500));
  }

  final today = DateTime.now();

  // Parse expiryDate from string
  final expiryDate = DateTime.parse(expiryDateString);

  // Calculate the difference in days
  final difference = expiryDate.difference(today).inDays;

  // Format the expiry date
  final formattedDate = DateFormat('dd MMM yyyy').format(expiryDate);

  if (difference < 0) {
    // Expired
    return Text(
      "Expired",
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.red500, fontSize: 12, fontWeight: FontWeight.w400),
    );
  } else if (difference == 0) {
    // 1 day
    return Text(
      "Today",
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.red500, fontSize: 12, fontWeight: FontWeight.w400),
    );
  } else if (difference == 1) {
    // 1 day
    return Text(
      "1 day",
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.red500, fontSize: 12, fontWeight: FontWeight.w400),
    );
  } else if (difference < 60) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: ' ${difference}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.red500,
          ),
        ),
        const TextSpan(
          text: ' days',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.red500,
          ),
        ),
      ])),
    ]);
  } else {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      RichText(
          text: TextSpan(children: [
        const TextSpan(
          text: "Valid till",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xff009276),
          ),
        ),
        TextSpan(
          text: ' ${formattedDate}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xff131c25),
          ),
        ),
      ])),
    ]);
  }
}
