// Path: lib/features/transactions/domain/entities/receipt_scan_entity.dart

/// Datos que el OCR ha podido extraer de un ticket. Todos son opcionales
/// porque la lectura puede ser parcial.
class ReceiptScanEntity {
  final double? amount;
  final String? description;
  final DateTime? date;

  const ReceiptScanEntity({this.amount, this.description, this.date});
}