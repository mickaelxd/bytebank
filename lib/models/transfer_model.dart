class TransferModel {
  final double value;
  final int accountNumber;

  TransferModel({
    required this.value,
    required this.accountNumber,
  });

  @override
  String toString() {
    return 'Transferencia{valor: $value, numeroConta: $accountNumber}';
  }
}
