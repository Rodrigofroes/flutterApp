extension StringExt on String {
  String substringLs(int i, int f) {
    if (length < f) {
      return this;
    }
    return substring(i, f);
  }

  String get iniciais {
    if (trim().isEmpty) {
      return 'SN';
    }

    final nomes = trim().split(' ').map((e) => e.trim()).toList();
    nomes.removeWhere((e) => e.isEmpty);
    if (nomes.length == 1) {
      return nomes[0].substring(0, 1).toUpperCase();
    }
    return '${nomes[0].substring(0, 1).toUpperCase()}${nomes[1].substring(0, 1).toUpperCase()}';
  }
}

extension IntExt on int {
  String padLeft(int i) {
    return toString().padLeft(i, '0');
  }
}


extension DoubleExt on double {
  String get valorFormatado {
    return 'R\$ ${toStringAsFixed(2)}';
  }
}


extension DateTimeExt on DateTime {
  String get dataEvento {
    return '${year.padLeft(4)}-${month.padLeft(2)}-${day.padLeft(2)} ${hour.padLeft(2)}:${minute.padLeft(2)}:${second.padLeft(2)}';
  }

  String get dataFormatada {
    return '${hour.padLeft(2)}:${minute.padLeft(2)}';
  }

  String get dataPtBr {
    return '${day.padLeft(2)}/${month.padLeft(2)}/${year.padLeft(4)}';
  }

  String get horaPtBr {
    return '${hour.padLeft(2)}:${minute.padLeft(2)}:${second.padLeft(2)}';
  }

  String get horaPtBrSemSegund {
    return '${hour.padLeft(2)}:${minute.padLeft(2)}';
  }

  DateTime get dataHoraServidorFomart {
    final data = toUtc();
    final dataUtc = data.subtract(const Duration(hours: 3));

    return dataUtc;
  }

  String getAnoAtual() {
    var agora = DateTime.now();
    var anoAtual = agora.year.toString();
    return anoAtual;
  }

  String get dataPtBrDiaMes {
    final dia = day.padLeft(2);
    final mes = month.padLeft(2);
    final mesExtenso = {
      '01': 'jan',
      '02': 'fev',
      '03': 'mar',
      '04': 'abr',
      '05': 'mai',
      '06': 'jun',
      '07': 'jul',
      '08': 'ago',
      '09': 'set',
      '10': 'out',
      '11': 'nov',
      '12': 'dez',
    };
    final mesExtensoStr = mesExtenso[mes];
    return '$dia $mesExtensoStr.';
  }

  String get dataPtBrMes {
    final mes = month.padLeft(2);
    final mesExtenso = {
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    };
    final mesExtensoStr = mesExtenso.elementAt(int.parse(mes) - 1);
    return mesExtensoStr;
  }
}
