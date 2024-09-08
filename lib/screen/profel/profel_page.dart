import 'package:flutter/material.dart';
class ProfelPage extends StatefulWidget {
  const ProfelPage({super.key});

  @override
  State<ProfelPage> createState() => _ProfelPageState();
}

class _ProfelPageState extends State<ProfelPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Profel Page"),
      ),
    );
  }
}
