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
  String get validationInvalidAmount => 'Invalid amount';

  @override
  String get balance => 'Total balance';

  @override
  String get income => 'Income';

  @override
  String get expense => 'Expenses';

  @override
  String get addTransaction => 'Add transaction';

  @override
  String get description => 'Description';

  @override
  String get save => 'Save';

  @override
  String get noTransactions => 'No transactions yet';

  @override
  String get latestTransactions => 'Latest transactions';

  @override
  String get financialSummary => 'Your financial summary';

  @override
  String greeting(String name) {
    return 'Hello, $name 👋';
  }

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

  @override
  String get editProfile => 'Edit profile';

  @override
  String get changePhoto => 'Change photo';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get profileUpdated => 'Profile updated successfully';

  @override
  String get notifications => 'Notifications';

  @override
  String get language => 'Language';

  @override
  String get help => 'Help';

  @override
  String get notificationsGeneral => 'General notifications';

  @override
  String get notificationsGeneralSubtitle => 'Receive general app updates';

  @override
  String get notificationsTransactions => 'New transactions';

  @override
  String get notificationsTransactionsSubtitle =>
      'Receive alerts when a transaction is added';

  @override
  String get notificationsBudgets => 'Budget alerts';

  @override
  String get notificationsBudgetsSubtitle =>
      'Alert when you approach your budget limit';

  @override
  String get notificationsReports => 'Monthly reports';

  @override
  String get notificationsReportsSubtitle =>
      'Receive a monthly summary of your finances';

  @override
  String get contact => 'Contact';

  @override
  String get version => 'Version';

  @override
  String get faq => 'Frequently asked questions';

  @override
  String get faq1Question => 'How do I add a transaction?';

  @override
  String get faq1Answer =>
      'Tap the + button on the main screen or in the Transactions tab.';

  @override
  String get faq2Question => 'How do I export my data?';

  @override
  String get faq2Answer =>
      'Go to the Transactions tab and tap the export icon at the top.';

  @override
  String get faq3Question => 'How do I scan a receipt?';

  @override
  String get faq3Answer =>
      'Tap the camera button when adding a transaction to scan automatically.';

  @override
  String get faq4Question => 'Is my data secure?';

  @override
  String get faq4Answer =>
      'Yes, all data is stored securely in Firebase with authentication.';
}
