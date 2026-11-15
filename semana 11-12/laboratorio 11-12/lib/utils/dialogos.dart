import 'package:flutter/cupertino.dart';

/// Mensaje simple con CupertinoAlertDialog (reemplaza al SnackBar).
Future<void> mostrarMensaje(
  BuildContext context, {
  required String titulo,
  required String mensaje,
}) {
  return showCupertinoDialog<void>(
    context: context,
    builder: (dialogContext) => CupertinoAlertDialog(
      title: Text(titulo),
      content: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(mensaje),
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Aceptar'),
        ),
      ],
    ),
  );
}

/// Confirmación que devuelve true / false.
Future<bool> confirmar(
  BuildContext context, {
  required String titulo,
  required String mensaje,
  String textoAccion = 'Confirmar',
  bool destructiva = true,
}) async {
  final respuesta = await showCupertinoDialog<bool>(
    context: context,
    builder: (dialogContext) => CupertinoAlertDialog(
      title: Text(titulo),
      content: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(mensaje),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancelar'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: destructiva,
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(textoAccion),
        ),
      ],
    ),
  );
  return respuesta ?? false;
}
