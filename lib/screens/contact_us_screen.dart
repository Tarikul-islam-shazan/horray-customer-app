import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  static const routeName = '/contact-us-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Container(
        child: const Center(
          child: Text('Contact Us'),
        ),
      ),
    );
  }
}
