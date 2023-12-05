import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectapp/list/class_list.dart';
import 'package:projectapp/utils/extesions.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  String buscarnome = '';
  DateTime _seletDateInit = DateTime.now();
  DateTime _seletDateFinal = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Clientes"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                left: 30,
                top: 18,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            buscarnome = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "Procurar por cliente",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().add(const Duration(days: -800)),
                      lastDate: DateTime.now().add(const Duration(days: 999)),
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
                ElevatedButton(
                  onPressed: () async {
                    DateTime? result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().add(const Duration(days: -999)),
                      lastDate: DateTime.now().add(const Duration(days: 999)),
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
                        _seletDateFinal = result;
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(_seletDateFinal.dataPtBr),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('cliente')
                        .where('dataCriacao')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Erro ao carregar usuários'));
                      }
                      final usuarios = snapshot.data?.docs ?? [];
                      if (usuarios.isEmpty) {
                        return const Center(
                            child: Text('Nenhum usuário encontrado'));
                      }
                      final usuarioModel = usuarios
                          .map((e) => DadosUsuarios.fromJson(e.data()))
                          .toList();
                      final usuariosFiltro = usuarioModel
                          .where((e) => e.inputNomeCompleto!
                              .toLowerCase()
                              .contains(buscarnome.toLowerCase()))
                          .toList();
                      final dataFiltro = usuariosFiltro
                          .where((e) =>
                              e.dataCriacao!.isAfter(_seletDateInit
                                  .subtract(const Duration(days: 1))
                                  .add(const Duration(days: 1, minutes: -1))) &&
                              e.dataCriacao!.isBefore(
                                  _seletDateFinal.add(const Duration(days: 1))))
                          .toList();
                      return ListView.builder(
                        itemCount: dataFiltro.length,
                        itemBuilder: (_, index) {
                          final usuarioData = dataFiltro[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Card(
                              child: ListTile(
                                titleTextStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                title: Text(
                                    "Nome: ${usuarioData.inputNomeCompleto}"),
                                subtitle: Theme(
                                  data: ThemeData(
                                    textTheme: const TextTheme(
                                      titleLarge: TextStyle(
                                        fontSize: 5,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Celular: ${usuarioData.inputCelular}",
                                      ),
                                      Text(
                                        "CPF: ${usuarioData.inputCpf}"),
                                      Text(
                                        "Endereço: ${usuarioData.inputEnd}",
                                      ),
                                      Text(
                                        "Serviço: ${usuarioData.inputListOpc}",
                                      ),
                                      Text(
                                        "Valor: ${usuarioData.inputValor}",
                                      ),
                                      Text(
                                        "Descrição: ${usuarioData.inputDesc}",
                                      ),
                                      Text(
                                        "Data: ${usuarioData.dataCriacao?.dataPtBr}",
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: Container(
                                  alignment: Alignment.centerRight,
                                  width: 40,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Remover Cliente'),
                                                content: const Text(
                                                    'Deseja remover o Cliente?'),
                                                actions: [
                                                  TextButton(
                                                    child: const Text('Sim'),
                                                    onPressed: () async {
                                                      // Aqui você obtém o nome do cliente que deseja excluir.
                                                      String? nomeCliente =
                                                          usuarioData
                                                              .inputNomeCompleto;

                                                      try {
                                                        // Faça uma consulta para encontrar o documento do cliente com base no nome.
                                                        QuerySnapshot
                                                            querySnapshot =
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'cliente')
                                                                .where(
                                                                    'inputNomeCompleto',
                                                                    isEqualTo:
                                                                        nomeCliente)
                                                                .get();

                                                        // Verifique se há algum documento correspondente encontrado.
                                                        if (querySnapshot
                                                            .docs.isNotEmpty) {
                                                          // Se houver correspondências, exclua o primeiro documento encontrado.
                                                          await querySnapshot
                                                              .docs
                                                              .first
                                                              .reference
                                                              .delete();
                                                        } else {
                                                          // Se nenhum documento correspondente for encontrado, você pode mostrar uma mensagem de erro
                                                          // ou realizar outra ação adequada.
                                                          print(
                                                              'Nenhum cliente encontrado com o nome: $nomeCliente');
                                                        }
                                                      } catch (e) {
                                                        // Trate qualquer erro que possa ocorrer durante a exclusão ou consulta.
                                                        print(
                                                            'Erro ao excluir o cliente: $e');
                                                        // Você pode mostrar uma mensagem de erro ou realizar outra ação de acordo com suas necessidades.
                                                      }
                                                      Navigator.pop(ctx);
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('Não'),
                                                    onPressed: () =>
                                                        Navigator.pop(ctx),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
