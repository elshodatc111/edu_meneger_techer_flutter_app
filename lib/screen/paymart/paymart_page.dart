import 'package:flutter/material.dart';

class PaymartPage extends StatefulWidget {
  const PaymartPage({super.key});

  @override
  State<PaymartPage> createState() => _PaymartPageState();
}

class _PaymartPageState extends State<PaymartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Paymart Page"),
      ),
    );
  }
}
