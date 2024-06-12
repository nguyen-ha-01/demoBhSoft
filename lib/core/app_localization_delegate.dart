import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomMaterialLocalizations extends MaterialLocalizations {
  final Locale locale;

  CustomMaterialLocalizations(this.locale);

  static const List<String> _weekdays = <String>[
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  @override
  String aboutListTileTitle(String applicationName) {
    return 'About $applicationName';
  }

  @override
  String get alertDialogLabel => 'Alert';

  @override
  String get anteMeridiemAbbreviation => 'AM';

  @override
  String get backButtonTooltip => 'Back';

  @override
  String get calendarModeButtonLabel => 'Switch to calendar';

  @override
  String get cancelButtonLabel => 'CANCEL';

  // Implement all other methods...

  @override
  List<String> get narrowWeekdays => _weekdays.map((e) => e.substring(0, 3)).toList();

  @override
  String get nextMonthTooltip => 'Next month';

  @override
  String get nextPageTooltip => 'Next page';

  @override
  String get okButtonLabel => 'OK';

  @override
  String get openAppDrawerTooltip => 'Open navigation menu';

  @override
  String get pageRowsInfoTitleApproximate => '\$firstRow–\$lastRow of about \$rowCount';

  @override
  String get pasteButtonLabel => 'PASTE';

  @override
  String get popupMenuLabel => 'Popup menu';

  @override
  String get postMeridiemAbbreviation => 'PM';

  @override
  String get previousMonthTooltip => 'Previous month';

  @override
  String get previousPageTooltip => 'Previous page';

  @override
  String get refreshIndicatorSemanticLabel => 'Refresh';

  @override
  String remainingTextFieldCharacterCount(int remaining) {
    return '$remaining characters remaining';
  }

  @override
  String get reorderItemDown => 'Move down';

  @override
  String get reorderItemLeft => 'Move left';

  @override
  String get reorderItemRight => 'Move right';

  @override
  String get reorderItemToEnd => 'Move to end';

  @override
  String get reorderItemToStart => 'Move to start';

  @override
  String get reorderItemUp => 'Move up';

  @override
  String get rowsPerPageTitle => 'Rows per page:';

  @override
  String get saveButtonLabel => 'SAVE';

  @override
  String get searchFieldLabel => 'Search';

  @override
  String get selectAllButtonLabel => 'SELECT ALL';

  @override
  String get selectedRowCountTitleOne => '1 item selected';

  @override
  String get selectedRowCountTitleOther => '\$selectedRowCount items selected';

  @override
  String get selectedRowCountTitleZero => 'No items selected';

  @override
  String get showAccountsLabel => 'Show accounts';

  @override
  String get showMenuTooltip => 'Show menu';

  @override
  String get signedInLabel => 'Signed in';

  @override
  String tabLabel({required int tabIndex, required int tabCount}) {
    return 'Tab \$tabIndex of \$tabCount';
  }

  @override
  TimeOfDayFormat timeOfDayFormat({bool alwaysUse24HourFormat = false}) {
    return alwaysUse24HourFormat ? TimeOfDayFormat.HH_colon_mm : TimeOfDayFormat.h_colon_mm_space_a;
  }

  @override
  String get timePickerHourModeAnnouncement => 'Select hours';

  @override
  String get timePickerMinuteModeAnnouncement => 'Select minutes';

  @override
  String get viewLicensesButtonLabel => 'VIEW LICENSES';

  @override
  String get calendarModeButtonTooltip => 'Switch to calendar view';

  @override
  String get inputDateModeButtonTooltip => 'Switch to text input mode';

  @override
  String get timePickerDialHelpText => 'SELECT TIME';

  @override
  String get timePickerHourLabel => 'Hour';

  @override
  String get timePickerMinuteLabel => 'Minute';

  @override
  String get modalBarrierDismissLabel => 'Dismiss';

  @override
  String get drawerLabel => 'Navigation menu';

  @override
  String get moreButtonTooltip => 'More';

  @override
  String get signedOutLabel => 'Signed out';

  // Implement all other methods from MaterialLocalizations...

  static Future<MaterialLocalizations> load(Locale locale) {
    return SynchronousFuture<MaterialLocalizations>(CustomMaterialLocalizations(locale));
  }

  static const LocalizationsDelegate<MaterialLocalizations> delegate = _CustomMaterialLocalizationsDelegate();

  @override
  String get bottomSheetLabel => 'Bottom Sheet';

  @override
  String get closeButtonLabel => 'Close';

  @override
  String get closeButtonTooltip => 'Close';

  @override
  String get continueButtonLabel => 'Continue';

  @override
  String get copyButtonLabel => 'Copy';

  @override
  String get currentDateLabel => 'Current Date';

  @override
  String get cutButtonLabel => 'Cut';

  @override
  String get dateHelpText => 'Enter date';

  @override
  String get dateInputLabel => 'Date Input';

  @override
  String get dateOutOfRangeLabel => 'Date out of range';

  @override
  String get datePickerHelpText => 'Select date';

  @override
  String dateRangeEndDateSemanticLabel(String formattedDate) => 'End date $formattedDate';

  @override
  String get dateRangeEndLabel => 'End Date';

  @override
  String get dateRangePickerHelpText => 'Select range';

  @override
  String dateRangeStartDateSemanticLabel(String formattedDate) => 'Start date $formattedDate';

  @override
  String get dateRangeStartLabel => 'Start Date';

  @override
  String get dateSeparator => '/';

  @override
  String get deleteButtonTooltip => 'Delete';

  @override
  String get dialModeButtonLabel => 'Switch to dial mode';

  @override
  String get dialogLabel => 'Dialog';

  @override
  int get firstDayOfWeekIndex => 0; // Sunday

  @override
  String get firstPageTooltip => 'First page';

  @override
  String formatCompactDate(DateTime date) => '${date.month}/${date.day}/${date.year}';

  @override
  String formatDecimal(int number) => number.toString();

  @override
  String formatFullDate(DateTime date) => '${_weekdays[date.weekday - 1]}, ${date.month} ${date.day}, ${date.year}';

  @override
  String formatHour(TimeOfDay timeOfDay, {bool alwaysUse24HourFormat = false}) => alwaysUse24HourFormat
      ? timeOfDay.hour.toString().padLeft(2, '0')
      : (timeOfDay.hour % 12 == 0 ? 12 : timeOfDay.hour % 12).toString();

  @override
  String formatMediumDate(DateTime date) => '${date.month}/${date.day}/${date.year}';

  @override
  String formatMinute(TimeOfDay timeOfDay) => timeOfDay.minute.toString().padLeft(2, '0');

  @override
  String formatMonthYear(DateTime date) => '${date.month}/${date.year}';

  @override
  String formatShortDate(DateTime date) => '${date.month}/${date.day}/${date.year}';

  @override
  String formatShortMonthDay(DateTime date) => '${date.month}/${date.day}';

  @override
  String formatTimeOfDay(TimeOfDay timeOfDay, {bool alwaysUse24HourFormat = false}) => alwaysUse24HourFormat
      ? '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}'
      : '${formatHour(timeOfDay)}:${formatMinute(timeOfDay)} ${timeOfDay.period == DayPeriod.am ? 'AM' : 'PM'}';

  @override
  String formatYear(DateTime date) => date.year.toString();

  @override
  String get hideAccountsLabel => 'Hide accounts';

  @override
  String get inputDateModeButtonLabel => 'Switch to input mode';

  @override
  String get inputTimeModeButtonLabel => 'Switch to input mode';

  @override
  String get invalidDateFormatLabel => 'Invalid date format';

  @override
  String get invalidDateRangeLabel => 'Invalid date range';

  @override
  String get invalidTimeLabel => 'Invalid time';

  @override
  String get keyboardKeyAlt => 'Alt';

  @override
  String get keyboardKeyAltGraph => 'Alt Graph';

  @override
  String get keyboardKeyBackspace => 'Backspace';

  @override
  String get keyboardKeyCapsLock => 'Caps Lock';

  @override
  String get keyboardKeyChannelDown => 'Channel Down';

  @override
  String get keyboardKeyChannelUp => 'Channel Up';

  @override
  String get keyboardKeyControl => 'Control';

  @override
  String get keyboardKeyDelete => 'Delete';

  @override
  String get keyboardKeyEject => 'Eject';

  @override
  String get keyboardKeyEnd => 'End';

  @override
  String get keyboardKeyEscape => 'Escape';

  @override
  String get keyboardKeyFn => 'Fn';

  @override
  String get keyboardKeyHome => 'Home';

  @override
  String get keyboardKeyInsert => 'Insert';

  @override
  String get keyboardKeyMeta => 'Meta';

  @override
  String get keyboardKeyMetaMacOs => 'Command';

  @override
  String get keyboardKeyMetaWindows => 'Windows';

  @override
  String get keyboardKeyNumLock => 'Num Lock';

  @override
  String get keyboardKeyNumpad0 => 'Numpad 0';

  @override
  String get keyboardKeyNumpad1 => 'Numpad 1';

  @override
  String get keyboardKeyNumpad2 => 'Numpad 2';

  @override
  String get keyboardKeyNumpad3 => 'Numpad 3';

  @override
  String get keyboardKeyNumpad4 => 'Numpad 4';

  @override
  String get keyboardKeyNumpad5 => 'Numpad 5';

  @override
  String get keyboardKeyNumpad6 => 'Numpad 6';

  @override
  String get keyboardKeyNumpad7 => 'Numpad 7';

  @override
  String get keyboardKeyNumpad8 => 'Numpad 8';

  @override
  String get keyboardKeyNumpad9 => 'Numpad 9';

  @override
  String get keyboardKeyNumpadAdd => 'Numpad Add';

  @override
  String get keyboardKeyNumpadComma => 'Numpad Comma';

  @override
  String get keyboardKeyNumpadDecimal => 'Numpad Decimal';

  @override
  String get keyboardKeyNumpadDivide => 'Numpad Divide';

  @override
  String get keyboardKeyNumpadEnter => 'Numpad Enter';

  @override
  String get keyboardKeyNumpadEqual => 'Numpad Equal';

  @override
  String get keyboardKeyNumpadMultiply => 'Numpad Multiply';

  @override
  String get keyboardKeyNumpadParenLeft => 'Numpad (';

  @override
  String get keyboardKeyNumpadParenRight => 'Numpad )';

  @override
  String get keyboardKeyNumpadSubtract => 'Numpad Subtract';

  @override
  String get keyboardKeyPageDown => 'Page Down';

  @override
  String get keyboardKeyPageUp => 'Page Up';

  @override
  String get keyboardKeyPower => 'Power';

  @override
  String get keyboardKeyPowerOff => 'Power Off';

  @override
  String get keyboardKeyPrintScreen => 'Print Screen';

  @override
  String get keyboardKeyScrollLock => 'Scroll Lock';

  @override
  String get keyboardKeySelect => 'Select';

  @override
  String get keyboardKeyShift => 'Shift';

  @override
  String get keyboardKeySpace => 'Space';

  @override
  String get lastPageTooltip => 'Last page';

  @override
  String licensesPackageDetailText(int licenseCount) => '$licenseCount licenses';

  @override
  String get licensesPageTitle => 'Licenses';

  @override
  String get lookUpButtonLabel => 'Look up';

  @override
  String get menuBarMenuLabel => 'Menu bar';

  @override
  String get menuDismissLabel => 'Dismiss menu';

  @override
  DateTime? parseCompactDate(String? inputString) {
    try {
      if (inputString == null) return null;
      final parts = inputString.split('/');
      if (parts.length != 3) return null;
      final month = int.tryParse(parts[0]);
      final day = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);
      if (month == null || day == null || year == null) return null;
      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }

  @override
  String get scanTextButtonLabel => 'Scan text';

  @override
  String get scrimLabel => 'Scrim';

  @override
  String scrimOnTapHint(String modalRouteContentName) => 'Dismiss $modalRouteContentName';

  @override
  String pageRowsInfoTitle(int firstRow, int lastRow, int rowCount, bool rowCountIsApproximate) {
    // TODO: implement pageRowsInfoTitle
    throw UnimplementedError();
  }

  @override
  // TODO: implement scriptCategory
  ScriptCategory get scriptCategory => scriptCategory;

  @override
  // TODO: implement searchWebButtonLabel
  String get searchWebButtonLabel => searchWebButtonLabel;

  @override
  // TODO: implement selectYearSemanticsLabel
  String get selectYearSemanticsLabel => selectYearSemanticsLabel;

  @override
  String selectedRowCountTitle(int selectedRowCount) {
    // TODO: implement selectedRowCountTitle
    throw "selected ${selectedRowCount}";
  }

  @override
  // TODO: implement shareButtonLabel
  String get shareButtonLabel => 'shareButtonLabel';

  @override
  // TODO: implement timePickerInputHelpText
  String get timePickerInputHelpText => 'timePickerInputHelpText';

  @override
  // TODO: implement unspecifiedDate
  String get unspecifiedDate => 'unspecifiedDate';

  @override
  // TODO: implement unspecifiedDateRange
  String get unspecifiedDateRange => 'unspecifiedDateRange';
}

class _CustomMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const _CustomMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) => CustomMaterialLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<MaterialLocalizations> old) => false;
}
