import 'package:cronometro/viewmodels/cronometro_view_model.dart';
import 'package:cronometro/widgets/botao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaCronometro extends StatelessWidget {
  const TelaCronometro({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CronometroViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cronômetro'),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 10.0,
            ),
            child: Column(
              children: [
                const Spacer(flex: 2),

                FittedBox(
                  fit: BoxFit.contain,
                  child: Builder(
                    builder: (context) {
                      final partes = viewModel.tempoPrincipalExibido.split('.');
                      final principal = partes.isNotEmpty ? partes[0] : '00:00';
                      final milissegundos = partes.length > 1
                          ? '.${partes[1]}'
                          : '.00';

                      return Semantics(
                        label:
                            "Tempo principal do cronômetro: ${viewModel.tempoPrincipalExibido}",
                        liveRegion: true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              principal,
                              style: const TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'monospace',
                              ),
                            ),
                            Text(
                              milissegundos,
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const Spacer(flex: 1),

                Expanded(
                  flex: 5,
                  child: Semantics(
                    label: "Lista de voltas registradas",
                    child: ListView.builder(
                      reverse: true,
                      itemCount: viewModel.voltas.length,
                      itemBuilder: (context, index) {
                        final volta = viewModel.voltas[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nº ${volta.numero}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                viewModel.formatarTempo(volta.tempoVolta),
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                viewModel.formatarTempo(volta.tempoTotal),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (viewModel.estado == EstadoCronometro.zerado)
                        const SizedBox(width: 88)
                      else
                        Botao(
                          texto: viewModel.estado == EstadoCronometro.rodando
                              ? 'Volta'
                              : 'Zerar',
                          icone: viewModel.estado == EstadoCronometro.rodando
                              ? Icons.flag
                              : Icons.refresh,
                          onPressed: () {
                            if (viewModel.estado == EstadoCronometro.rodando) {
                              viewModel.marcarVolta();
                            } else {
                              viewModel.zerar();
                            }
                          },
                        ),

                      Botao(
                        texto: viewModel.estado == EstadoCronometro.rodando
                            ? 'Pausar'
                            : 'Iniciar',
                        icone: viewModel.estado == EstadoCronometro.rodando
                            ? Icons.pause
                            : Icons.play_arrow,
                        cor: const Color.fromARGB(255, 36, 229, 132),
                        corIcone: Colors.white,
                        isPrimary: true,
                        onPressed: () {
                          if (viewModel.estado == EstadoCronometro.rodando) {
                            viewModel.pausar();
                          } else {
                            viewModel.iniciar();
                          }
                        },
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 1),
              ],
            ),
          ),
        );
      },
    );
  }
}
