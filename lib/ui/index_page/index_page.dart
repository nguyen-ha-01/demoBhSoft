import 'package:flutter/material.dart';
import 'package:tiademo/ui/home_page/widgets/blank_item.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  _IndexPageState();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: BlankItem(),
    );
  }
}
