part of 'settings_cubit.dart';

class SettingsState {
  bool notificationSettings;
  bool emailNotificationSettings;

  SettingsState(
      {required this.notificationSettings,
      required this.emailNotificationSettings});

  SettingsState copyWith({
    bool? notificationSettings,
    bool? emailNotificationSettings,
  }) {
    return SettingsState(
      notificationSettings: notificationSettings ?? this.notificationSettings,
      emailNotificationSettings:
          emailNotificationSettings ?? this.emailNotificationSettings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notificationSettings': notificationSettings,
      'emailNotificationSettings': emailNotificationSettings,
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      notificationSettings: map['notificationSettings'] ?? false,
      emailNotificationSettings: map['emailNotificationSettings'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsState.fromJson(String source) =>
      SettingsState.fromMap(json.decode(source));
}
