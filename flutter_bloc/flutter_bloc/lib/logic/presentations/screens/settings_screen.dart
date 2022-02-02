import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Column(
            children: [
              SwitchListTile(
                value: state.notificationSettings,
                onChanged: (_) =>
                    context.read<SettingsCubit>().toggleNotificationSettings(_),
                title: const Text('Notification Settings'),
              ),
              SwitchListTile(
                value: state.emailNotificationSettings,
                onChanged: (_) => context
                    .read<SettingsCubit>()
                    .toggleEmailNotificationSettings(_),
                title: const Text('Email Notification Settings'),
              ),
            ],
          );
        },
      ),
    );
  }
}
