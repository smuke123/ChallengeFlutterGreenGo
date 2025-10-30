import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'GreenGo Logistics'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In es, this message translates to:
  /// **'🚴 GreenGo Logistics'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Coordinación de repartidores en bicicleta para una ciudad más verde'**
  String get homeSubtitle;

  /// No description provided for @homeMenuCourierTitle.
  ///
  /// In es, this message translates to:
  /// **'Modo Repartidor'**
  String get homeMenuCourierTitle;

  /// No description provided for @homeMenuCourierSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Ver y gestionar mis entregas'**
  String get homeMenuCourierSubtitle;

  /// No description provided for @homeMenuSupervisorTitle.
  ///
  /// In es, this message translates to:
  /// **'Modo Supervisor'**
  String get homeMenuSupervisorTitle;

  /// No description provided for @homeMenuSupervisorSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Monitorear todas las entregas'**
  String get homeMenuSupervisorSubtitle;

  /// No description provided for @toggleThemeTooltip.
  ///
  /// In es, this message translates to:
  /// **'Cambiar tema'**
  String get toggleThemeTooltip;

  /// No description provided for @deliveriesTitle.
  ///
  /// In es, this message translates to:
  /// **'📦 Mis Entregas'**
  String get deliveriesTitle;

  /// No description provided for @tabPending.
  ///
  /// In es, this message translates to:
  /// **'Pendientes'**
  String get tabPending;

  /// No description provided for @tabCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completadas'**
  String get tabCompleted;

  /// No description provided for @statTotal.
  ///
  /// In es, this message translates to:
  /// **'Total'**
  String get statTotal;

  /// No description provided for @statPending.
  ///
  /// In es, this message translates to:
  /// **'Pendientes'**
  String get statPending;

  /// No description provided for @statCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completadas'**
  String get statCompleted;

  /// No description provided for @emptyPending.
  ///
  /// In es, this message translates to:
  /// **'No hay entregas pendientes 🎉'**
  String get emptyPending;

  /// No description provided for @emptyCompleted.
  ///
  /// In es, this message translates to:
  /// **'Aún no has completado entregas'**
  String get emptyCompleted;

  /// No description provided for @resetDialogTitle.
  ///
  /// In es, this message translates to:
  /// **'Reiniciar entregas'**
  String get resetDialogTitle;

  /// No description provided for @resetDialogContent.
  ///
  /// In es, this message translates to:
  /// **'¿Deseas reiniciar todas las entregas? Esto marcará todas como pendientes.'**
  String get resetDialogContent;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In es, this message translates to:
  /// **'Reiniciar'**
  String get reset;

  /// No description provided for @snackReset.
  ///
  /// In es, this message translates to:
  /// **'✅ Entregas reiniciadas'**
  String get snackReset;

  /// No description provided for @supervisorTitle.
  ///
  /// In es, this message translates to:
  /// **'👨‍💼 Panel del Supervisor'**
  String get supervisorTitle;

  /// No description provided for @filter.
  ///
  /// In es, this message translates to:
  /// **'Filtrar:'**
  String get filter;

  /// No description provided for @filterAll.
  ///
  /// In es, this message translates to:
  /// **'Todas'**
  String get filterAll;

  /// No description provided for @filterPending.
  ///
  /// In es, this message translates to:
  /// **'Pendientes'**
  String get filterPending;

  /// No description provided for @filterCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completadas'**
  String get filterCompleted;

  /// No description provided for @emptyCategory.
  ///
  /// In es, this message translates to:
  /// **'No hay entregas en esta categoría'**
  String get emptyCategory;

  /// No description provided for @chipDelivered.
  ///
  /// In es, this message translates to:
  /// **'Entregado'**
  String get chipDelivered;

  /// No description provided for @chipOnRoute.
  ///
  /// In es, this message translates to:
  /// **'En ruta'**
  String get chipOnRoute;

  /// No description provided for @progressTitle.
  ///
  /// In es, this message translates to:
  /// **'Progreso de entregas'**
  String get progressTitle;

  /// No description provided for @snackDelivered.
  ///
  /// In es, this message translates to:
  /// **'✅ Entrega a {clientName} completada'**
  String snackDelivered(Object clientName);

  /// No description provided for @snackRemoved.
  ///
  /// In es, this message translates to:
  /// **'Entrega eliminada'**
  String get snackRemoved;

  /// No description provided for @undo.
  ///
  /// In es, this message translates to:
  /// **'Deshacer'**
  String get undo;

  /// No description provided for @moreOptions.
  ///
  /// In es, this message translates to:
  /// **'Más opciones'**
  String get moreOptions;

  /// No description provided for @markPending.
  ///
  /// In es, this message translates to:
  /// **'Marcar como pendiente'**
  String get markPending;

  /// No description provided for @markDelivered.
  ///
  /// In es, this message translates to:
  /// **'Marcar como entregado'**
  String get markDelivered;

  /// No description provided for @remove.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get remove;

  /// No description provided for @searchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar por cliente, dirección o distrito'**
  String get searchHint;

  /// No description provided for @sortNewest.
  ///
  /// In es, this message translates to:
  /// **'Más recientes'**
  String get sortNewest;

  /// No description provided for @sortOldest.
  ///
  /// In es, this message translates to:
  /// **'Más antiguas'**
  String get sortOldest;

  /// No description provided for @sortStatus.
  ///
  /// In es, this message translates to:
  /// **'Por estado'**
  String get sortStatus;

  /// No description provided for @sortDistrict.
  ///
  /// In es, this message translates to:
  /// **'Por distrito'**
  String get sortDistrict;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
