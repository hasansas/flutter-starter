//

import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final Widget title;
  final Widget content;
  final EdgeInsets contentPadding;

  Section(
      {this.content,
      this.title,
      this.contentPadding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget titleWidget = this.title;
    Widget childWidget = this.content;
    if (titleWidget != null) {
      titleWidget = Container(
          margin: childWidget != null
              ? EdgeInsets.only(top: 12)
              : EdgeInsets.symmetric(vertical: 12),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: DefaultTextStyle(
            child: titleWidget,
            style: theme.textTheme.subtitle
                .copyWith(color: theme.textTheme.caption.color),
          ));
      final columnChildren = childWidget != null
          ? <Widget>[
              titleWidget,
              Container(padding: this.contentPadding, child: childWidget)
            ]
          : <Widget>[titleWidget];
      childWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: columnChildren);
    } else {}
    return Container(
      decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border(
            top: BorderSide(color: theme.dividerColor),
            bottom: BorderSide(color: theme.dividerColor),
          )),
      child: childWidget,
    );
  }
}
