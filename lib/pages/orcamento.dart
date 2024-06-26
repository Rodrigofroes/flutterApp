import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:projectapp/list/class_list.dart';
import 'package:projectapp/utils/extesions.dart';

class OrcamentoPage extends StatefulWidget {
  const OrcamentoPage({super.key});

  @override
  State<OrcamentoPage> createState() => _OrcamentoPageState();
}

class _OrcamentoPageState extends State<OrcamentoPage> {

  void showMensagem(String mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String? _servicoSelecionado;
  late final _valorController = MoneyMaskedTextController(
    initialValue: 0.00,
    decimalSeparator: ',',
    thousandSeparator: '.',
    leftSymbol: 'R\$ ',
  );

  DateTime _selectedDate = DateTime.now().add(const Duration(days: -30));
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final _cpfController = MaskedTextController(mask: '000.000.000-00');
  final _celularController = MaskedTextController(mask: '(00) 00000-0000');
  final TextEditingController _enderecoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _valorController.text = '0.00';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orçamento'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _servicoSelecionado,
                        hint: const Text('Serviço'),
                        onChanged: (String? novoValor) {
                          setState(() {
                            _servicoSelecionado = novoValor;
                          });
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 20)),
                        items: <String>[
                          'Instalação',
                          'Manutenção',
                          'Limpeza',
                          'Higienização'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: _valorController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: 'Valor',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 20)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2021),
                      lastDate: DateTime.now().add(Duration(days: 30)),
                    ).then((date) {
                      if (date == null) return;
                      setState(() {
                        _selectedDate = date;
                      });
                    });
                  },
                  child: Text(_selectedDate.dataPtBr),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome Completo',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'CPF',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _celularController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Celular',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _enderecoController,
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'check',
        backgroundColor: Colors.green,
        onPressed: () async {
          double? valor = _valorController.numberValue;
          print(valor);
          DadosUsuarios novoUsuarios = DadosUsuarios(
              inputListOpc: _servicoSelecionado,
            inputValor: valor,
              inputDesc: _descricaoController.text,
              inputNomeCompleto: _nomeController.text,
              inputCpf: _cpfController.text,
              inputCelular: _celularController.text,
              inputEnd: _enderecoController.text,
            dataCriacao: _selectedDate,
          );

          if (!novoUsuarios.isValid) {
            showMensagem('Preencha todos os campos');
            return;
          }

          _valorController.text = '0.00';
          _descricaoController.clear();
          _nomeController.clear();
          _cpfController.clear();
          _celularController.clear();
          _enderecoController.clear();

          _selectedDate = DateTime.now().add(const Duration(days: -30));
          
          await FirebaseFirestore.instance
              .collection('cliente')
              .add(novoUsuarios.toJson());

          setState(() {});
        },
        materialTapTargetSize: MaterialTapTargetSize.padded,
        isExtended: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: const Icon(Icons.check),
      ),
    );
  }
}
