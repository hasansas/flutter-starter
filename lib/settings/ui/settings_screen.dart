import 'package:flutter/material.dart';
import 'package:starter/settings/settings.dart';
import 'package:starter/widgets/section.dart';
import 'package:starter/user/ui/user_screen.dart';

const _profileImageRadius = 24.0;

class SettingsScreen extends StatelessWidget {
  static Route buildRoute() =>
      MaterialPageRoute(builder: (_) => SettingsScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: _buildSections(context),
      ),
    );
  }

  Widget _buildSections(BuildContext context) {
    // TODO: change UI
    final sections = <Widget>[
      GestureDetector(
        onTap: () {
          Navigator.push(context, UserScreen.buildRoute());
        },
        child: _buildUserInfoSection(context),
      ),
      _buildDisplaySection(context),
    ];

    return Wrap(
      runSpacing: 8,
      children: sections,
    );
  }

  Widget _buildUserInfoSection(BuildContext context) {
    return Section(
        contentPadding: EdgeInsets.zero,
        content: ListTile(
          leading: CircleAvatar(
              radius: _profileImageRadius,
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/236x/29/ba/b8/29bab8a9be8228c661973bffbe6a50fa--exotic.jpg')),
          title: Text('Jane Doe'),
          subtitle: Text('email or phone number'),
        ));
  }

  Widget _buildDisplaySection(BuildContext context) {
    bool _darkMode = Settings.instance.themeMode == ThemeMode.dark ?? false;
    return Section(
        title: Text('DISPLAY'),
        contentPadding: EdgeInsets.zero,
        content: Column(children: <Widget>[
          SwitchListTile(
            title: const Text('Dark mode'),
            value: _darkMode,
            onChanged: (bool value) {
              Settings.instance.themeMode =
                  value ? ThemeMode.dark : ThemeMode.light;
            },
            secondary: const Icon(Icons.invert_colors),
          )
        ]));
  }
}
