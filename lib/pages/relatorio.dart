import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectapp/list/class_list.dart';
import 'package:projectapp/utils/extesions.dart';

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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('cliente').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar relatório'));
          }
          final usuarios = snapshot.data?.docs ?? [];
          if (usuarios.isEmpty) {
            return const Center(child: Text('Nenhum relatório encontrado'));
          }
          final usuarioModel =
              usuarios.map((e) => DadosUsuarios.fromJson(e.data())).toList();

          final listaAgrupada = <String, List<DadosUsuarios>>{};
          for (final usuario in usuarioModel) {
            final dataPtBrMes = usuario.dataCriacao!.dataPtBrMes ?? '';
            if (listaAgrupada.containsKey(dataPtBrMes)) {
              listaAgrupada[dataPtBrMes]?.add(usuario);
            } else {
              listaAgrupada[dataPtBrMes] = [usuario];
            }
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: listaAgrupada.length,
            itemBuilder: (context, index) {
              final dataPtBrDiaMes = listaAgrupada.keys.elementAt(index);
              final usuarios = listaAgrupada[dataPtBrDiaMes] ?? [];
              final valorTotal = usuarios
                  .map((e) => e.inputValor ?? 0)
                  .reduce((value, element) => value + element);

              return Expanded(
                child: ExpansionTile(
                  textColor: Colors.black,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataPtBrDiaMes,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Valor total: ${valorTotal.valorFormatado}",
                        style: const TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  children: [
                    for (final usuario in usuarios)
                      ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cliente: ${usuario.inputNomeCompleto ?? ''}",
                            ),
                            Text("Serviço: ${usuario.inputListOpc ?? ''}"),
                            Text(
                                "Valor: ${usuario.inputValor!.valorFormatado}"),
                          ],
                        ),
                        trailing: Text(usuario.dataCriacao?.dataPtBr ?? ''),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
