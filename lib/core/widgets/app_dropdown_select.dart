// lib/core/widgets/forms/app_dropdown_select.dart
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../models/select_model.dart';

class AppDropdownSelect extends StatelessWidget {
  const AppDropdownSelect({
    super.key,
    this.label,
    required this.items,
    this.isDisabled = false,
    this.isLoading = false,
    this.onChanged,
    this.selectedItem,
    this.mode,
    this.showSearchBox = true,
    this.maxHeight = 600,
  });

  final String? label;
  final List<SelectModel> items;
  final bool isDisabled;
  final bool isLoading;
  final ValueChanged<SelectModel?>? onChanged;
  final SelectModel? selectedItem;
  final Mode? mode;
  final bool showSearchBox;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabledOrLoading = isDisabled || isLoading || items.isEmpty;

    return DropdownSearch<SelectModel>(
      items: (f, i) => items,
      compareFn: (item, selected) => item.id == selected.id,
      itemAsString: (item) => item.title.toString(),
      selectedItem: isDisabledOrLoading ? null : selectedItem,
      onChanged: isDisabledOrLoading ? null : onChanged,
      enabled: !isDisabledOrLoading,
      validator: (v) => v == null ? "Please select $label" : null,
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(labelText: label),
      ),
      popupProps: PopupProps.modalBottomSheet(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(label ?? '', style: theme.textTheme.titleLarge),
        ),
        showSearchBox: showSearchBox,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.disabledColor,
            ),
          ),
        ),
        constraints: BoxConstraints(maxHeight: maxHeight),
        fit: FlexFit.loose,
      ),
    );
  }
}
