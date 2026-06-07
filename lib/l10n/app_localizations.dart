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
  /// **'Presupuesto'**
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

  /// Validación importe
  ///
  /// In es, this message translates to:
  /// **'Importe no válido'**
  String get validationInvalidAmount;

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

  /// Campo descripción
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get description;

  /// Botón guardar
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// Sin transacciones
  ///
  /// In es, this message translates to:
  /// **'No hay movimientos aún'**
  String get noTransactions;

  /// Últimos movimientos
  ///
  /// In es, this message translates to:
  /// **'Últimos movimientos'**
  String get latestTransactions;

  /// Resumen financiero
  ///
  /// In es, this message translates to:
  /// **'Tu resumen financiero'**
  String get financialSummary;

  /// Saludo con nombre
  ///
  /// In es, this message translates to:
  /// **'Hola, {name} 👋'**
  String greeting(String name);

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

  /// Editar perfil
  ///
  /// In es, this message translates to:
  /// **'Editar perfil'**
  String get editProfile;

  /// Cambiar foto
  ///
  /// In es, this message translates to:
  /// **'Cambiar foto'**
  String get changePhoto;

  /// Guardar cambios
  ///
  /// In es, this message translates to:
  /// **'Guardar cambios'**
  String get saveChanges;

  /// Perfil actualizado
  ///
  /// In es, this message translates to:
  /// **'Perfil actualizado correctamente'**
  String get profileUpdated;

  /// Notificaciones
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notifications;

  /// Idioma
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get language;

  /// Ayuda
  ///
  /// In es, this message translates to:
  /// **'Ayuda'**
  String get help;

  /// Notificaciones generales
  ///
  /// In es, this message translates to:
  /// **'Notificaciones generales'**
  String get notificationsGeneral;

  /// Subtítulo notificaciones generales
  ///
  /// In es, this message translates to:
  /// **'Recibe actualizaciones generales de la app'**
  String get notificationsGeneralSubtitle;

  /// Notificaciones de movimientos
  ///
  /// In es, this message translates to:
  /// **'Nuevos movimientos'**
  String get notificationsTransactions;

  /// Subtítulo notificaciones movimientos
  ///
  /// In es, this message translates to:
  /// **'Recibe alertas cuando se añada un movimiento'**
  String get notificationsTransactionsSubtitle;

  /// Notificaciones de presupuesto
  ///
  /// In es, this message translates to:
  /// **'Alertas de presupuesto'**
  String get notificationsBudgets;

  /// Subtítulo notificaciones presupuesto
  ///
  /// In es, this message translates to:
  /// **'Aviso cuando te acerques al límite de tu presupuesto'**
  String get notificationsBudgetsSubtitle;

  /// Notificaciones de informes
  ///
  /// In es, this message translates to:
  /// **'Informes mensuales'**
  String get notificationsReports;

  /// Subtítulo notificaciones informes
  ///
  /// In es, this message translates to:
  /// **'Recibe un resumen mensual de tus finanzas'**
  String get notificationsReportsSubtitle;

  /// Contacto
  ///
  /// In es, this message translates to:
  /// **'Contacto'**
  String get contact;

  /// Versión
  ///
  /// In es, this message translates to:
  /// **'Versión'**
  String get version;

  /// Preguntas frecuentes
  ///
  /// In es, this message translates to:
  /// **'Preguntas frecuentes'**
  String get faq;

  /// FAQ 1 pregunta
  ///
  /// In es, this message translates to:
  /// **'¿Cómo añado un movimiento?'**
  String get faq1Question;

  /// FAQ 1 respuesta
  ///
  /// In es, this message translates to:
  /// **'Pulsa el botón + en la pantalla principal o en la pestaña de Movimientos.'**
  String get faq1Answer;

  /// FAQ 2 pregunta
  ///
  /// In es, this message translates to:
  /// **'¿Cómo exporto mis datos?'**
  String get faq2Question;

  /// FAQ 2 respuesta
  ///
  /// In es, this message translates to:
  /// **'Ve a la pestaña de Movimientos y pulsa el icono de exportar en la parte superior.'**
  String get faq2Answer;

  /// FAQ 3 pregunta
  ///
  /// In es, this message translates to:
  /// **'¿Cómo escaneo una factura?'**
  String get faq3Question;

  /// FAQ 3 respuesta
  ///
  /// In es, this message translates to:
  /// **'Pulsa el botón de cámara al añadir un movimiento para escanear automáticamente.'**
  String get faq3Answer;

  /// FAQ 4 pregunta
  ///
  /// In es, this message translates to:
  /// **'¿Mis datos están seguros?'**
  String get faq4Question;

  /// FAQ 4 respuesta
  ///
  /// In es, this message translates to:
  /// **'Sí, todos los datos se almacenan de forma segura en Firebase con autenticación.'**
  String get faq4Answer;

  /// Categorías
  ///
  /// In es, this message translates to:
  /// **'Categorías'**
  String get categories;

  /// Añadir categoría
  ///
  /// In es, this message translates to:
  /// **'Añadir categoría'**
  String get addCategory;

  /// Campo nombre categoría
  ///
  /// In es, this message translates to:
  /// **'Nombre de la categoría'**
  String get categoryName;

  /// Campo color categoría
  ///
  /// In es, this message translates to:
  /// **'Color'**
  String get categoryColor;

  /// Campo icono categoría
  ///
  /// In es, this message translates to:
  /// **'Icono'**
  String get categoryIcon;

  /// Sin categorías
  ///
  /// In es, this message translates to:
  /// **'No hay categorías aún'**
  String get noCategories;

  /// Categoría eliminada
  ///
  /// In es, this message translates to:
  /// **'Categoría eliminada'**
  String get categoryDeleted;

  /// Categoría creada
  ///
  /// In es, this message translates to:
  /// **'Categoría creada correctamente'**
  String get categoryCreated;

  /// Campo categoría
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get category;

  /// Placeholder selector categoría
  ///
  /// In es, this message translates to:
  /// **'Selecciona una categoría'**
  String get selectCategory;

  /// Editar categoría
  ///
  /// In es, this message translates to:
  /// **'Editar categoría'**
  String get editCategory;

  /// Categoría actualizada
  ///
  /// In es, this message translates to:
  /// **'Categoría actualizada correctamente'**
  String get categoryUpdated;

  /// Presupuestos
  ///
  /// In es, this message translates to:
  /// **'Presupuestos'**
  String get budgets;

  /// Añadir presupuesto
  ///
  /// In es, this message translates to:
  /// **'Añadir presupuesto'**
  String get addBudget;

  /// Sin presupuestos
  ///
  /// In es, this message translates to:
  /// **'No hay presupuestos aún'**
  String get noBudgets;

  /// Límite presupuesto
  ///
  /// In es, this message translates to:
  /// **'Límite'**
  String get budgetLimit;

  /// Gastado presupuesto
  ///
  /// In es, this message translates to:
  /// **'Gastado'**
  String get budgetSpent;

  /// Restante presupuesto
  ///
  /// In es, this message translates to:
  /// **'Restante'**
  String get budgetRemaining;

  /// Presupuesto eliminado
  ///
  /// In es, this message translates to:
  /// **'Presupuesto eliminado'**
  String get budgetDeleted;

  /// Presupuesto creado
  ///
  /// In es, this message translates to:
  /// **'Presupuesto creado correctamente'**
  String get budgetCreated;

  /// Límite superado
  ///
  /// In es, this message translates to:
  /// **'Límite superado'**
  String get budgetOverLimit;

  /// Selector mes
  ///
  /// In es, this message translates to:
  /// **'Mes'**
  String get selectMonth;

  /// Selector año
  ///
  /// In es, this message translates to:
  /// **'Año'**
  String get selectYear;

  /// Exportación exitosa
  ///
  /// In es, this message translates to:
  /// **'Archivo exportado correctamente'**
  String get exportSuccess;

  /// Error exportación
  ///
  /// In es, this message translates to:
  /// **'Error al exportar el archivo'**
  String get exportError;

  /// Exportando
  ///
  /// In es, this message translates to:
  /// **'Exportando...'**
  String get exporting;

  /// Escaneo exitoso
  ///
  /// In es, this message translates to:
  /// **'Factura escaneada correctamente'**
  String get scanSuccess;

  /// Error escaneo
  ///
  /// In es, this message translates to:
  /// **'Error al escanear la factura'**
  String get scanError;

  /// Escaneando
  ///
  /// In es, this message translates to:
  /// **'Escaneando...'**
  String get scanning;

  /// Seleccionar imagen
  ///
  /// In es, this message translates to:
  /// **'Seleccionar imagen'**
  String get selectImage;

  /// Hacer foto
  ///
  /// In es, this message translates to:
  /// **'Hacer foto'**
  String get takePhoto;
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
