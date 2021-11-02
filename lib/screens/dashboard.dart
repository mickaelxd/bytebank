import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/bytebank_logo.png'),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _FeatureItem(
                      name: 'Transfer',
                      icon: Icons.monetization_on,
                      onTap: () => _showContactsList(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _FeatureItem(
                      name: 'Transaction Feed',
                      icon: Icons.description,
                      onTap: () => _showTransactionsList(context),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  void _showContactsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsList(),
      ),
    );
  }
  void _showTransactionsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final void Function()? onTap;

  const _FeatureItem({
    Key? key,
    required this.name,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          height: 100,
          width: 150,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).primaryTextTheme.bodyText1?.color,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.bodyText1?.color,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
