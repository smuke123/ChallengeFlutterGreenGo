// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'GreenGo Logistics';

  @override
  String get homeTitle => '🚴 GreenGo Logistics';

  @override
  String get homeSubtitle => 'Coordinating bicycle couriers for a greener city';

  @override
  String get homeMenuCourierTitle => 'Courier Mode';

  @override
  String get homeMenuCourierSubtitle => 'View and manage my deliveries';

  @override
  String get homeMenuSupervisorTitle => 'Supervisor Mode';

  @override
  String get homeMenuSupervisorSubtitle => 'Monitor all deliveries';

  @override
  String get toggleThemeTooltip => 'Toggle theme';

  @override
  String get deliveriesTitle => '📦 My Deliveries';

  @override
  String get tabPending => 'Pending';

  @override
  String get tabCompleted => 'Completed';

  @override
  String get statTotal => 'Total';

  @override
  String get statPending => 'Pending';

  @override
  String get statCompleted => 'Completed';

  @override
  String get emptyPending => 'No pending deliveries 🎉';

  @override
  String get emptyCompleted => 'You haven\'t completed deliveries yet';

  @override
  String get resetDialogTitle => 'Reset deliveries';

  @override
  String get resetDialogContent =>
      'Do you want to reset all deliveries? This will mark all as pending.';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get snackReset => '✅ Deliveries reset';

  @override
  String get supervisorTitle => '👨‍💼 Supervisor Panel';

  @override
  String get filter => 'Filter:';

  @override
  String get filterAll => 'All';

  @override
  String get filterPending => 'Pending';

  @override
  String get filterCompleted => 'Completed';

  @override
  String get emptyCategory => 'No deliveries in this category';

  @override
  String get chipDelivered => 'Delivered';

  @override
  String get chipOnRoute => 'On route';

  @override
  String get progressTitle => 'Delivery progress';

  @override
  String snackDelivered(Object clientName) {
    return '✅ Delivery to $clientName completed';
  }

  @override
  String get snackRemoved => 'Delivery removed';

  @override
  String get undo => 'Undo';

  @override
  String get moreOptions => 'More options';

  @override
  String get markPending => 'Mark as pending';

  @override
  String get markDelivered => 'Mark as delivered';

  @override
  String get remove => 'Remove';

  @override
  String get searchHint => 'Search by client, address or district';

  @override
  String get sortNewest => 'Newest';

  @override
  String get sortOldest => 'Oldest';

  @override
  String get sortStatus => 'By status';

  @override
  String get sortDistrict => 'By district';
}
