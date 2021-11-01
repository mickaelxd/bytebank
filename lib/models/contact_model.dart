class ContactModel {
  final String fullName;
  final int accountNumber;

  ContactModel({
    required this.fullName,
    required this.accountNumber,
  });

  @override
  String toString() {
    return 'Contato{valor: $fullName, numeroConta: $accountNumber}';
  }
}
