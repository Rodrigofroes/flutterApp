import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectapp/list.dart';
import 'package:projectapp/list/class_list.dart';
import 'package:projectapp/utils/extesions.dart';

class OrcamentoPage extends StatefulWidget {
  const OrcamentoPage({super.key});

  @override
  State<OrcamentoPage> createState() => _OrcamentoPageState();
}

class _OrcamentoPageState extends State<OrcamentoPage> {
  DateTime _seletDateInit = DateTime.now().add(const Duration(days: -30));

  String? _servicoSelecionado;
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: DropdownButtonFormField<String>(
                  value: _servicoSelecionado,
                  hint: const Text('Serviço'),
                  onChanged: (String? novoValor) {
                    setState(() {
                      _servicoSelecionado = novoValor;
                    });
                  },
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
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _valorController,
                      decoration: const InputDecoration(
                        labelText: 'Valor',
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? result = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().add(const Duration(days: -800)),
                        lastDate: DateTime.now().add(const Duration()),
                        builder: (context, child) {
                          return SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: SizedBox(
                                    height: 700,
                                    width: 700,
                                    child: child,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      if (result != null) {
                        setState(() {
                          _seletDateInit = result;
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(_seletDateInit.dataPtBr),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _celularController,
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
      floatingActionButton: FloatingActionButton(
        tooltip: 'check',
        backgroundColor: Colors.green,
        onPressed: () async {
          DadosUsuarios novoUsuarios = DadosUsuarios(
            inputListOpc: _servicoSelecionado,
            inputValor: _valorController.text,
            inputDesc: _descricaoController.text,
            inputNomeCompleto: _nomeController.text,
            inputCpf: _cpfController.text,
            inputCelular: _celularController.text,
            inputEnd: _enderecoController.text,
            dataCriacao: _seletDateInit
          );

          _valorController.clear();
          _descricaoController.clear();
          _nomeController.clear();
          _cpfController.clear();
          _celularController.clear();
          _enderecoController.clear();

          await FirebaseFirestore.instance
              .collection('cliente')
              .add(novoUsuarios.toJson());

          listaUsuarios.add(novoUsuarios);
          print(listaUsuarios.length);
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
