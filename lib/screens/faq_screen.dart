import 'package:flutter/material.dart';

class FAQSreen extends StatelessWidget {
  static const routeName = '/faq-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: Container(
        child: const Center(
          child: Text('FAQ'),
        ),
      ),
    );
  }
}
