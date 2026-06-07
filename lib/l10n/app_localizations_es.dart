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
  String get navBudgets => 'Presupuestos';

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
  String get balance => 'Balance total';

  @override
  String get income => 'Ingresos';

  @override
  String get expense => 'Gastos';

  @override
  String get addTransaction => 'Añadir movimiento';

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
}
