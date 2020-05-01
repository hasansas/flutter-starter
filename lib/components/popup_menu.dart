import 'package:flutter/material.dart';

class PopUpMenu extends PopupMenuButton<PopUpMenuAction> {
  PopUpMenu(BuildContext context, List<PopUpMenuAction> popUpMenuAction,
      Function onMenuSelected)
      : super(onSelected: (PopUpMenuAction item) {
          Function.apply(onMenuSelected, [context, item.actionType]);
        }, itemBuilder: (context) {
          return popUpMenuAction.map((item) {
            return PopupMenuItem<PopUpMenuAction>(
              value: item,
              child: Text(item.title),
            );
          }).toList();
        });
}

class PopUpMenuAction {
  const PopUpMenuAction(
      {this.actionType, this.title, this.icon, this.onSelected});

  final PopUpMenuActionType actionType;
  final String title;
  final IconData icon;
  final Function onSelected;
}

enum PopUpMenuActionType {
  SETTINGS,
}
