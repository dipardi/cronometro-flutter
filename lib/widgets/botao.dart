import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String texto;
  final IconData icone;
  final VoidCallback? onPressed;
  final Color cor;
  final Color corIcone;
  final bool isPrimary;

  const Botao({
    super.key,
    required this.texto,
    required this.icone,
    this.onPressed,
    this.cor = const Color.fromARGB(255, 217, 91, 1),
    this.corIcone = const Color.fromARGB(255, 255, 255, 255),
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final double padding = isPrimary ? 30 : 22;
    final double iconSize = isPrimary ? 45 : 30;

    return Semantics(
      label: texto,
      button: true,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: cor,
          padding: EdgeInsets.all(padding),
          shape: const CircleBorder(),
        ),
        onPressed: onPressed,
        child: Icon(icone, color: corIcone, size: iconSize),
      ),
    );
  }
}
