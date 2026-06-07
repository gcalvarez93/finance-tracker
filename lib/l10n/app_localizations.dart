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
    Locale('es'),
  ];

  /// Nombre de la app
  ///
  /// In es, this message translates to:
  /// **'Finance Tracker'**
  String get appName;

  /// Navegación - Inicio
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// Navegación - Movimientos
  ///
  /// In es, this message translates to:
  /// **'Movimientos'**
  String get navTransactions;

  /// Navegación - Categorías
  ///
  /// In es, this message translates to:
  /// **'Categorías'**
  String get navCategories;

  /// Navegación - Presupuestos
  ///
  /// In es, this message translates to:
  /// **'Presupuestos'**
  String get navBudgets;

  /// Navegación - Perfil
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// Título de la pantalla de login
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión para continuar'**
  String get loginTitle;

  /// Campo email
  ///
  /// In es, this message translates to:
  /// **'Email'**
  String get loginEmail;

  /// Campo contraseña
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get loginPassword;

  /// Botón de login
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get loginButton;

  /// Botón de Google
  ///
  /// In es, this message translates to:
  /// **'Continuar con Google'**
  String get loginWithGoogle;

  /// Texto sin cuenta
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta?'**
  String get loginNoAccount;

  /// Link de registro
  ///
  /// In es, this message translates to:
  /// **'Regístrate'**
  String get loginRegister;

  /// Título de registro
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get registerTitle;

  /// Campo nombre
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get registerName;

  /// Botón de registro
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get registerButton;

  /// Validación campo obligatorio
  ///
  /// In es, this message translates to:
  /// **'Este campo es obligatorio'**
  String get validationRequired;

  /// Validación email
  ///
  /// In es, this message translates to:
  /// **'Email no válido'**
  String get validationEmail;

  /// Validación contraseña
  ///
  /// In es, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get validationPasswordLength;

  /// Balance total
  ///
  /// In es, this message translates to:
  /// **'Balance total'**
  String get balance;

  /// Ingresos
  ///
  /// In es, this message translates to:
  /// **'Ingresos'**
  String get income;

  /// Gastos
  ///
  /// In es, this message translates to:
  /// **'Gastos'**
  String get expense;

  /// Añadir transacción
  ///
  /// In es, this message translates to:
  /// **'Añadir movimiento'**
  String get addTransaction;

  /// Exportar
  ///
  /// In es, this message translates to:
  /// **'Exportar'**
  String get export;

  /// Exportar PDF
  ///
  /// In es, this message translates to:
  /// **'Exportar PDF'**
  String get exportPdf;

  /// Exportar Excel
  ///
  /// In es, this message translates to:
  /// **'Exportar Excel'**
  String get exportExcel;

  /// Escanear factura
  ///
  /// In es, this message translates to:
  /// **'Escanear factura'**
  String get scanReceipt;

  /// Cerrar sesión
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get logout;
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
    'that was used.',
  );
}
