import 'package:bytebank/models/contact_model.dart';

class TransactionModel {
  final double value;
  final ContactModel contact;

  TransactionModel({
    required this.value,
    required this.contact,
  });

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }

  TransactionModel.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        contact = ContactModel.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'value': value,
        'contact': contact.toJson(),
      };
}
