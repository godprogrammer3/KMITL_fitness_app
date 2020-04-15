import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PaymentPage extends StatelessWidget {
  final String url;
  const PaymentPage({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PaymentPageChild(url: url);
  }
}

class PaymentPageChild extends StatefulWidget {
  final String url;
  PaymentPageChild({Key key, this.url}) : super(key: key);
  @override
  _PaymentPageChildState createState() => _PaymentPageChildState(url:url);
}

class _PaymentPageChildState extends State<PaymentPageChild> {
  final String url;
  final _key = UniqueKey();

  _PaymentPageChildState({this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        centerTitle: true,
      ),
      body:  Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: url))
          ],
        ));
  }
}