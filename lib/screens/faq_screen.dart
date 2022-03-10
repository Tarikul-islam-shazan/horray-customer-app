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
        margin: EdgeInsets.all(10),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text(
                  'How  I can get discout?',
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  'Step-1: Select brand from brand page.\n Step-2: Click payment button.\n Step-3: Scan QR code.',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () {/* ... */},
                    icon: Icon(Icons.thumb_up_sharp),
                    label: Text(
                      'Like',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {/* ... */},
                    icon: Icon(Icons.thumb_down),
                    label: Text(
                      'Dislike',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
