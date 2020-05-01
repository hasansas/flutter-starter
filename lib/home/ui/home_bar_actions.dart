import 'package:flutter/material.dart';
import 'package:starter/components/popup_menu.dart';
import 'package:starter/settings/settings_screen.dart';

List<Widget> homeBarActions(context) {
  return <Widget>[PopUpMenu(context, _PopUpMenuActions, onPopUpMenuSelected)];
}

const _PopUpMenuActions = const <PopUpMenuAction>[
  const PopUpMenuAction(
      actionType: PopUpMenuActionType.SETTINGS,
      title: 'Settings',
      icon: Icons.settings,
      onSelected: onPopUpMenuSelected),
];

void onPopUpMenuSelected(BuildContext context, PopUpMenuActionType actionType) {
  switch (actionType) {
    case PopUpMenuActionType.SETTINGS:
      Navigator.push(context, SettingsScreen.buildRoute());
      break;
    default:
      break;
  }
}
