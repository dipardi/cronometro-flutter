import 'dart:async';
import 'package:cronometro/modelos/voltas.dart';
import 'package:cronometro/notificacoes/notificacao.dart'; // 1. Importa o serviço
import 'package:flutter/material.dart';

enum EstadoCronometro { zerado, rodando, pausado }

class CronometroViewModel extends ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  final ServicoNotificacao _servicoNotificacao = ServicoNotificacao();

  String tempoPrincipalExibido = "00:00:00.00";
  List<Volta> voltas = [];
  EstadoCronometro estado = EstadoCronometro.zerado;

  void iniciar() {
    estado = EstadoCronometro.rodando;
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      tempoPrincipalExibido = formatarTempo(_stopwatch.elapsed);

      _servicoNotificacao.mostrarNotificacaoPersistente(
        'Tempo: $tempoPrincipalExibido',
      );
      notifyListeners();
    });
  }

  void pausar() {
    estado = EstadoCronometro.pausado;
    _stopwatch.stop();
    _timer?.cancel();

    _servicoNotificacao.cancelarNotificacao(0);
    notifyListeners();
  }

  void zerar() {
    estado = EstadoCronometro.zerado;
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
    tempoPrincipalExibido = "00:00:00.00";
    voltas.clear();

    _servicoNotificacao.cancelarNotificacao(0);
    notifyListeners();
  }

  void marcarVolta() {
    final tempoTotalAtual = _stopwatch.elapsed;
    final tempoTotalVoltaAnterior = voltas.isEmpty
        ? Duration.zero
        : voltas.first.tempoTotal;

    final tempoDaVolta = tempoTotalAtual - tempoTotalVoltaAnterior;

    final novaVolta = Volta(
      numero: voltas.length + 1,
      tempoVolta: tempoDaVolta,
      tempoTotal: tempoTotalAtual,
    );

    voltas.insert(0, novaVolta);

    final titulo = 'Volta ${novaVolta.numero}';
    final corpo =
        'Tempo da volta: ${formatarTempo(novaVolta.tempoVolta)} | Total: ${formatarTempo(novaVolta.tempoTotal)}';
    _servicoNotificacao.mostrarNotificacaoDeVolta(titulo, corpo);

    notifyListeners();
  }

  String formatarTempo(Duration duration) {
    String doisDigitos(int n) => n.toString().padLeft(2, '0');
    String minutos = doisDigitos(duration.inMinutes.remainder(60));
    String segundos = doisDigitos(duration.inSeconds.remainder(60));
    String milissegundos = doisDigitos(
      (duration.inMilliseconds.remainder(1000) ~/ 10),
    );

    if (duration.inHours > 0) {
      String horas = doisDigitos(duration.inHours);
      return "$horas:$minutos:$segundos.$milissegundos";
    }
    return "$minutos:$segundos.$milissegundos";
  }
}
