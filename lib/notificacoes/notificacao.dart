import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ServicoNotificacao {
  static final ServicoNotificacao _instance = ServicoNotificacao._internal();
  factory ServicoNotificacao() => _instance;
  ServicoNotificacao._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);
    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  Future<void> mostrarNotificacaoPersistente(String corpo) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'cronometro_canal_id',
          'Cronômetro Ativo',
          channelDescription:
              'Notificação que permanece enquanto o cronômetro está rodando.',
          importance: Importance.low,
          priority: Priority.low,
          ongoing: true,
          autoCancel: false,
          showWhen: false,
        );
    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(
      0,
      'Cronômetro Rodando',
      corpo,
      platformDetails,
    );
  }

  Future<void> mostrarNotificacaoDeVolta(String titulo, String corpo) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'volta_canal_id',
          'Volta Registrada',
          channelDescription: 'Notificação para cada volta registrada.',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        );
    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    final id = DateTime.now().millisecondsSinceEpoch.remainder(100000);

    await _notificationsPlugin.show(id, titulo, corpo, platformDetails);
  }

  Future<void> cancelarNotificacao(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}
