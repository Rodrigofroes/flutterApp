import 'package:map_fields/map_fields.dart';

class DadosUsuarios {
  String? inputListOpc;
  double? inputValor;
  String? inputDesc;
  String? inputNomeCompleto;
  String? inputCpf;
  String? inputCelular;
  String? inputEnd;
  DateTime? dataCriacao;

  DadosUsuarios({
    this.inputListOpc,
    this.inputValor,
    this.inputDesc,
    this.inputNomeCompleto,
    this.inputCpf,
    this.inputCelular,
    this.inputEnd,
    this.dataCriacao
  });

  factory DadosUsuarios.fromJson(Map<String, dynamic> json) {
    final mapFields = MapFields.load(json);
    return DadosUsuarios(
      inputListOpc: mapFields.getStringNullable('inputListOpc'),
        inputValor: mapFields.getDoubleNullable('inputValor'),
      inputDesc: mapFields.getStringNullable('inputDesc'),
      inputNomeCompleto: mapFields.getStringNullable('inputNomeCompleto'),
      inputCpf: mapFields.getStringNullable('inputCpf'),
      inputCelular: mapFields.getStringNullable('inputCelular'),
      inputEnd: mapFields.getStringNullable('inputEnd'),
      dataCriacao: mapFields.getDateTimeNullable('dataCriacao')
    );
  }

  bool get isValid {
    return inputValor != null &&
        (inputDesc ?? "").trim().isNotEmpty &&
        (inputNomeCompleto ?? "").trim().isNotEmpty &&
        (inputCpf ?? "").trim().isNotEmpty &&
        (inputCelular ?? "").trim().isNotEmpty &&
        (inputEnd ?? "").trim().isNotEmpty &&
        dataCriacao != null;
  }

  Map<String, dynamic> toJson() {
    return {
      "inputListOpc": inputListOpc,
      "inputValor": inputValor,
      "inputDesc": inputDesc,
      "inputNomeCompleto": inputNomeCompleto,
      "inputCpf": inputCpf,
      "inputCelular": inputCelular,
      "inputEnd": inputEnd,
      "dataCriacao": dataCriacao.toString(),
    };
  }
}
