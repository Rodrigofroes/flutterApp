import 'package:flutter/material.dart';
import 'package:projectapp/list.dart';

class Relatorio extends StatefulWidget {
  const Relatorio({super.key});

  @override
  State<Relatorio> createState() => _RelatorioState();
}

class _RelatorioState extends State<Relatorio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatorio'),
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}