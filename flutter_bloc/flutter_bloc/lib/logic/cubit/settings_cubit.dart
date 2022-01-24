import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> with HydratedMixin {
  SettingsCubit()
      : super(SettingsState(
            notificationSettings: false, emailNotificationSettings: false));

  void toggleNotificationSettings(bool newValue) =>
      emit(state.copyWith(notificationSettings: newValue));

  void toggleEmailNotificationSettings(bool newValue) =>
      emit(state.copyWith(emailNotificationSettings: newValue));

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toMap();
  }

  // void toggleEmailNotificationSettings() => emit(SettingsState(
  //     notificationSettings: state.notificationSettings,
  //     emailNotificationSetting: !state.emailNotificationSetting));
}
