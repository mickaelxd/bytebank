import 'package:bytebank/models/contact_model.dart';

class TransactionModel {
  final double value;
  final ContactModel contact;

  TransactionModel(
    this.value,
    this.contact,
  );

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }
}
