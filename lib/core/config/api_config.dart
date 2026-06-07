class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:5166',
  );

  // Common
  static const String userMe = '$baseUrl/api/common/users/me';

  // Finance - Transactions
  static const String transactions = '$baseUrl/api/finance/transactions';
  static const String transactionsBalance = '$baseUrl/api/finance/transactions/balance';
  static const String transactionsScanReceipt = '$baseUrl/api/finance/transactions/scan';
  static const String transactionsExportPdf = '$baseUrl/api/finance/transactions/export/pdf';
  static const String transactionsExportExcel = '$baseUrl/api/finance/transactions/export/excel';

  // Finance - Categories
  static const String categories = '$baseUrl/api/finance/categories';

  // Finance - Budgets
  static const String budgets = '$baseUrl/api/finance/budgets';
}