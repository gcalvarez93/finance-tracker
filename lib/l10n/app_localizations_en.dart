// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Finance Tracker';

  @override
  String get navHome => 'Home';

  @override
  String get navTransactions => 'Transactions';

  @override
  String get navCategories => 'Categories';

  @override
  String get navBudgets => 'Budgets';

  @override
  String get navProfile => 'Profile';

  @override
  String get loginTitle => 'Sign in to continue';

  @override
  String get loginEmail => 'Email';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginButton => 'Sign in';

  @override
  String get loginWithGoogle => 'Continue with Google';

  @override
  String get loginNoAccount => 'Don\'t have an account?';

  @override
  String get loginRegister => 'Register';

  @override
  String get registerTitle => 'Create account';

  @override
  String get registerName => 'Name';

  @override
  String get registerButton => 'Register';

  @override
  String get validationRequired => 'This field is required';

  @override
  String get validationEmail => 'Invalid email';

  @override
  String get validationPasswordLength => 'Minimum 6 characters';

  @override
  String get balance => 'Total balance';

  @override
  String get income => 'Income';

  @override
  String get expense => 'Expenses';

  @override
  String get addTransaction => 'Add transaction';

  @override
  String get export => 'Export';

  @override
  String get exportPdf => 'Export PDF';

  @override
  String get exportExcel => 'Export Excel';

  @override
  String get scanReceipt => 'Scan receipt';

  @override
  String get logout => 'Sign out';
}
