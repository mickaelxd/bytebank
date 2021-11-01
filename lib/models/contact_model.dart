class ContactModel {
  final int? id;
  final String name;
  final int accountNumber;

  ContactModel({
    this.id,
    required this.name,
    required this.accountNumber,
  });

  @override
  String toString() {
    return 'Contato{id: $id, valor: $name, numeroConta: $accountNumber}';
  }
}
