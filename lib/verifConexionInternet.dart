import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'main.dart';

enum ConnectionStatus {
  online,
  offline,
}
class CheckInternetConnection {
  final Connectivity _connectivity = Connectivity();

  // El estado por defecto sera Online. Este controlador nos va
  // ayudar a emitir nuevos estados cuando la conexion cambie.
  final _controller = BehaviorSubject.seeded(ConnectionStatus.online);
  StreamSubscription? _connectionSubscription;

  CheckInternetConnection() {
    _checkInternetConnection();

  }

  // La clase [ConnectionStatusValueNotifier] va suscribirse a este Stream
  // y cuando la conexión cambie el status se va actualizar
  Stream<ConnectionStatus> internetStatus() {
    _connectionSubscription ??= _connectivity.onConnectivityChanged
        .listen((_) => _checkInternetConnection());
    return _controller.stream;
  }

  // Solución de stackoverflow
  Future<void> _checkInternetConnection() async {
    try {
      // Algunas veces, después de conectarnos a la red, esta función
      // se ejecuta cuando el dispositivo todavía no establece
      // conexión a internet. Este delay de 3 segundos le da tiempo
      // al dispositivo a conectarse y evitar falsos negativos.
      await Future.delayed(const Duration(seconds: 3));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _controller.sink.add(ConnectionStatus.online);

      } else {
        _controller.sink.add(ConnectionStatus.offline);
      }
    } on SocketException catch (_) {
      _controller.sink.add(ConnectionStatus.offline);
    }
  }

  Future<void> close() async {
    // Cancelamos la suscripción y cerramos el controlador
    await _connectionSubscription?.cancel();
    await _controller.close();
  }
}

class ConnectionStatusValueNotifier extends ValueNotifier<ConnectionStatus> {
  // Nos ayuda a mantener una suscripción con la
  // clase [CheckInternetConnection]
  late StreamSubscription _connectionSubscription;

  ConnectionStatusValueNotifier() : super(ConnectionStatus.online) {

    // Cada vez que se emite un nuevos estado actualizamos [value]
    // esto va hacer que nuestro widget se vuelva a construir.
    _connectionSubscription = internetChecker
        .internetStatus()

        .listen((newStatus) => value = newStatus);
  }

  @override
  void dispose() {
    // Cancelamos la subscription
    _connectionSubscription.cancel();
    super.dispose();
  }
}

//Widget TO SHOW THE ALERT
class WarningWidgetValueNotifier extends StatelessWidget {
  const WarningWidgetValueNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(

      valueListenable: ConnectionStatusValueNotifier(),
      builder: (context, ConnectionStatus status, child) {

        return

          Visibility(
          visible:  status != ConnectionStatus.online,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 60,
            color: Colors.red,
            child: Row(
              children: [
                const Icon(Icons.wifi_off),
                const SizedBox(width: 8),
                const Text('Sin conexión a internet'),
              ],
            ),

          ),
        );
      },
    );
  }
}

