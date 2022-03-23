import 'package:flutter/material.dart';

class PaymentInfo extends StatelessWidget {
  static const routeName = '/payment-info';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payemnt Info',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Center(
        child: Text('Heelo'),
      ),
    );
  }
}
