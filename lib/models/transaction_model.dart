import 'package:bytebank/models/contact_model.dart';

class TransactionModel {
  final String id;
  final double value;
  final ContactModel contact;

  TransactionModel({
    required this.id,
    required this.value,
    required this.contact,
  });

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }

  TransactionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        value = json['value'],
        contact = ContactModel.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'contact': contact.toJson(),
      };
}
