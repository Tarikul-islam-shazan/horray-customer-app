import 'package:flutter/material.dart';
import 'package:horray/screens/scan_qr_screen.dart';

class OfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontSize: 16),
          onPrimary: Colors.white,
          padding: EdgeInsets.all(16),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(ScanQRScreen.routeName);
        },
        child: Text(
          'Go To Scanner',
        ),
      ),
    );
  }
}
