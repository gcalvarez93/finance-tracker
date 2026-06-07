// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Finance Tracker';

  @override
  String get navHome => 'Inicio';

  @override
  String get navTransactions => 'Movimientos';

  @override
  String get navCategories => 'Categorías';

  @override
  String get navBudgets => 'Presupuesto';

  @override
  String get navProfile => 'Perfil';

  @override
  String get loginTitle => 'Inicia sesión para continuar';

  @override
  String get loginEmail => 'Email';

  @override
  String get loginPassword => 'Contraseña';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get loginWithGoogle => 'Continuar con Google';

  @override
  String get loginNoAccount => '¿No tienes cuenta?';

  @override
  String get loginRegister => 'Regístrate';

  @override
  String get registerTitle => 'Crear cuenta';

  @override
  String get registerName => 'Nombre';

  @override
  String get registerButton => 'Registrarse';

  @override
  String get validationRequired => 'Este campo es obligatorio';

  @override
  String get validationEmail => 'Email no válido';

  @override
  String get validationPasswordLength => 'Mínimo 6 caracteres';

  @override
  String get validationInvalidAmount => 'Importe no válido';

  @override
  String get balance => 'Balance total';

  @override
  String get income => 'Ingresos';

  @override
  String get expense => 'Gastos';

  @override
  String get addTransaction => 'Añadir movimiento';

  @override
  String get description => 'Descripción';

  @override
  String get save => 'Guardar';

  @override
  String get noTransactions => 'No hay movimientos aún';

  @override
  String get latestTransactions => 'Últimos movimientos';

  @override
  String get financialSummary => 'Tu resumen financiero';

  @override
  String greeting(String name) {
    return 'Hola, $name 👋';
  }

  @override
  String get export => 'Exportar';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get exportExcel => 'Exportar Excel';

  @override
  String get scanReceipt => 'Escanear factura';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get changePhoto => 'Cambiar foto';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get profileUpdated => 'Perfil actualizado correctamente';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get language => 'Idioma';

  @override
  String get help => 'Ayuda';

  @override
  String get notificationsGeneral => 'Notificaciones generales';

  @override
  String get notificationsGeneralSubtitle =>
      'Recibe actualizaciones generales de la app';

  @override
  String get notificationsTransactions => 'Nuevos movimientos';

  @override
  String get notificationsTransactionsSubtitle =>
      'Recibe alertas cuando se añada un movimiento';

  @override
  String get notificationsBudgets => 'Alertas de presupuesto';

  @override
  String get notificationsBudgetsSubtitle =>
      'Aviso cuando te acerques al límite de tu presupuesto';

  @override
  String get notificationsReports => 'Informes mensuales';

  @override
  String get notificationsReportsSubtitle =>
      'Recibe un resumen mensual de tus finanzas';

  @override
  String get contact => 'Contacto';

  @override
  String get version => 'Versión';

  @override
  String get faq => 'Preguntas frecuentes';

  @override
  String get faq1Question => '¿Cómo añado un movimiento?';

  @override
  String get faq1Answer =>
      'Pulsa el botón + en la pantalla principal o en la pestaña de Movimientos.';

  @override
  String get faq2Question => '¿Cómo exporto mis datos?';

  @override
  String get faq2Answer =>
      'Ve a la pestaña de Movimientos y pulsa el icono de exportar en la parte superior.';

  @override
  String get faq3Question => '¿Cómo escaneo una factura?';

  @override
  String get faq3Answer =>
      'Pulsa el botón de cámara al añadir un movimiento para escanear automáticamente.';

  @override
  String get faq4Question => '¿Mis datos están seguros?';

  @override
  String get faq4Answer =>
      'Sí, todos los datos se almacenan de forma segura en Firebase con autenticación.';

  @override
  String get categories => 'Categorías';

  @override
  String get addCategory => 'Añadir categoría';

  @override
  String get categoryName => 'Nombre de la categoría';

  @override
  String get categoryColor => 'Color';

  @override
  String get categoryIcon => 'Icono';

  @override
  String get noCategories => 'No hay categorías aún';

  @override
  String get categoryDeleted => 'Categoría eliminada';

  @override
  String get categoryCreated => 'Categoría creada correctamente';

  @override
  String get category => 'Categoría';

  @override
  String get selectCategory => 'Selecciona una categoría';

  @override
  String get editCategory => 'Editar categoría';

  @override
  String get categoryUpdated => 'Categoría actualizada correctamente';
}
