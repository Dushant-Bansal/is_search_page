import 'package:json_annotation/json_annotation.dart';

part 'internship.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Internship {
  final int id;
  final String title;
  final String employmentType;
  final ApplicationStatusMessage applicationStatusMessage;
  final String? jobTitle;
  final bool workFromHome;
  final String segment;
  final String? segmentLabelValue;
  final String? internshipTypeLabelValue;
  final List<String> jobSegments;
  final String companyName;
  final String companyUrl;
  final bool isPremium;
  final bool isPremiumInternship;
  final String employerName;
  final String companyLogo;
  final String type;
  final String url;
  final int isInternchallenge;
  final bool isExternal;
  final bool isActive;
  final String expiresAt;
  final String closedAt;
  final String profileName;
  final bool partTime;
  final String startDate;
  final String duration;
  final Stipend stipend;
  final String? salary;
  final String? jobExperience;
  final String experience;
  final String postedOn;
  final int? postedOnDateTime;
  final String applicationDeadline;
  final String expiringIn;
  final String postedByLabel;
  final String postedByLabelType;
  final List<String> locationNames;
  final List<Location> locations;
  final String startDateComparisonFormat;
  final String startDate1;
  final String startDate2;
  final bool isPpo;
  final bool isPpoSalaryDisclosed;
  final String? ppoSalary;
  final String? ppoSalary2;
  final String ppoLabelValue;
  final bool toShowExtraLabel;
  final String extraLabelValue;
  final bool isExtraLabelBlack;
  final List<String> campaignNames;
  final String campaignName;
  final bool toShowInSearch;
  final String campaignUrl;
  final String? campaignStartDateTime;
  final String? campaignLaunchDateTime;
  final String? campaignEarlyAccessStartDateTime;
  final String? campaignEndDateTime;
  final List<Label> labels;
  final String labelsApp;
  final List<String> labelsAppInCard;
  final bool isCovidWfhSelected;
  final bool toShowCardMessage;
  final String message;
  final bool isApplicationCappingEnabled;
  final String applicationCappingMessage;
  final List<String> overrideMetaDetails;
  final bool eligibleForEasyApply;
  final bool eligibleForB2bApplyNow;
  final bool toShowB2bLabel;
  final bool isInternationalJob;
  final bool toShowCoverLetter;
  final String? officeDays;

  Internship(
    this.id,
    this.title,
    this.employmentType,
    this.applicationStatusMessage,
    this.jobTitle,
    this.workFromHome,
    this.segment,
    this.segmentLabelValue,
    this.internshipTypeLabelValue,
    this.jobSegments,
    this.companyName,
    this.companyUrl,
    this.isPremium,
    this.isPremiumInternship,
    this.employerName,
    this.companyLogo,
    this.type,
    this.url,
    this.isInternchallenge,
    this.isExternal,
    this.isActive,
    this.expiresAt,
    this.closedAt,
    this.profileName,
    this.partTime,
    this.startDate,
    this.duration,
    this.stipend,
    this.salary,
    this.jobExperience,
    this.experience,
    this.postedOn,
    this.postedOnDateTime,
    this.applicationDeadline,
    this.expiringIn,
    this.postedByLabel,
    this.postedByLabelType,
    this.locationNames,
    this.locations,
    this.startDateComparisonFormat,
    this.startDate1,
    this.startDate2,
    this.isPpo,
    this.isPpoSalaryDisclosed,
    this.ppoSalary,
    this.ppoSalary2,
    this.ppoLabelValue,
    this.toShowExtraLabel,
    this.extraLabelValue,
    this.isExtraLabelBlack,
    this.campaignNames,
    this.campaignName,
    this.toShowInSearch,
    this.campaignUrl,
    this.campaignStartDateTime,
    this.campaignLaunchDateTime,
    this.campaignEarlyAccessStartDateTime,
    this.campaignEndDateTime,
    this.labels,
    this.labelsApp,
    this.labelsAppInCard,
    this.isCovidWfhSelected,
    this.toShowCardMessage,
    this.message,
    this.isApplicationCappingEnabled,
    this.applicationCappingMessage,
    this.overrideMetaDetails,
    this.eligibleForEasyApply,
    this.eligibleForB2bApplyNow,
    this.toShowB2bLabel,
    this.isInternationalJob,
    this.toShowCoverLetter,
    this.officeDays,
  );

  factory Internship.fromJson(Map<String, dynamic> json) =>
      _$InternshipFromJson(json);

  Map<String, dynamic> toJson() => _$InternshipToJson(this);
}

class ApplicationStatusMessage {
  final bool toShow;
  final String message;
  final String type;

  ApplicationStatusMessage({
    required this.toShow,
    required this.message,
    required this.type,
  });

  factory ApplicationStatusMessage.fromJson(Map<String, dynamic> json) {
    return ApplicationStatusMessage(
      toShow: json['to_show'],
      message: json['message'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'to_show': toShow,
      'message': message,
      'type': type,
    };
  }
}

class Stipend {
  final String salary;
  final String? tooltip;
  final int salaryValue1;
  final String? salaryValue2;
  final String salaryType;
  final String currency;
  final String scale;
  final bool largeStipendText;

  Stipend({
    required this.salary,
    this.tooltip,
    required this.salaryValue1,
    this.salaryValue2,
    required this.salaryType,
    required this.currency,
    required this.scale,
    required this.largeStipendText,
  });

  factory Stipend.fromJson(Map<String, dynamic> json) {
    return Stipend(
      salary: json['salary'],
      tooltip: json['tooltip'],
      salaryValue1: json['salaryValue1'],
      salaryValue2: json['salaryValue2'],
      salaryType: json['salaryType'],
      currency: json['currency'],
      scale: json['scale'],
      largeStipendText: json['large_stipend_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'salary': salary,
      'tooltip': tooltip,
      'salaryValue1': salaryValue1,
      'salaryValue2': salaryValue2,
      'salaryType': salaryType,
      'currency': currency,
      'scale': scale,
      'large_stipend_text': largeStipendText,
    };
  }
}

class Location {
  final String string;
  final String link;
  final String country;
  final String? region;
  final String locationName;

  Location({
    required this.string,
    required this.link,
    required this.country,
    this.region,
    required this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      string: json['string'],
      link: json['link'],
      country: json['country'],
      region: json['region'],
      locationName: json['locationName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'string': string,
      'link': link,
      'country': country,
      'region': region,
      'locationName': locationName,
    };
  }
}

class Label {
  final List<String> labelValue;
  final List<String> labelMobile;
  final List<String> labelApp;
  final List<String> labelsAppInCard;

  Label({
    required this.labelValue,
    required this.labelMobile,
    required this.labelApp,
    required this.labelsAppInCard,
  });

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      labelValue: List<String>.from(json['label_value']),
      labelMobile: List<String>.from(json['label_mobile']),
      labelApp: List<String>.from(json['label_app']),
      labelsAppInCard: List<String>.from(json['labels_app_in_card']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label_value': labelValue,
      'label_mobile': labelMobile,
      'label_app': labelApp,
      'labels_app_in_card': labelsAppInCard,
    };
  }
}
