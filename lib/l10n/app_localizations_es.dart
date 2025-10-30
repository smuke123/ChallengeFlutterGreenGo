// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'GreenGo Logistics';

  @override
  String get homeTitle => '🚴 GreenGo Logistics';

  @override
  String get homeSubtitle =>
      'Coordinación de repartidores en bicicleta para una ciudad más verde';

  @override
  String get homeMenuCourierTitle => 'Modo Repartidor';

  @override
  String get homeMenuCourierSubtitle => 'Ver y gestionar mis entregas';

  @override
  String get homeMenuSupervisorTitle => 'Modo Supervisor';

  @override
  String get homeMenuSupervisorSubtitle => 'Monitorear todas las entregas';

  @override
  String get toggleThemeTooltip => 'Cambiar tema';

  @override
  String get deliveriesTitle => '📦 Mis Entregas';

  @override
  String get tabPending => 'Pendientes';

  @override
  String get tabCompleted => 'Completadas';

  @override
  String get statTotal => 'Total';

  @override
  String get statPending => 'Pendientes';

  @override
  String get statCompleted => 'Completadas';

  @override
  String get emptyPending => 'No hay entregas pendientes 🎉';

  @override
  String get emptyCompleted => 'Aún no has completado entregas';

  @override
  String get resetDialogTitle => 'Reiniciar entregas';

  @override
  String get resetDialogContent =>
      '¿Deseas reiniciar todas las entregas? Esto marcará todas como pendientes.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get reset => 'Reiniciar';

  @override
  String get snackReset => '✅ Entregas reiniciadas';

  @override
  String get supervisorTitle => '👨‍💼 Panel del Supervisor';

  @override
  String get filter => 'Filtrar:';

  @override
  String get filterAll => 'Todas';

  @override
  String get filterPending => 'Pendientes';

  @override
  String get filterCompleted => 'Completadas';

  @override
  String get emptyCategory => 'No hay entregas en esta categoría';

  @override
  String get chipDelivered => 'Entregado';

  @override
  String get chipOnRoute => 'En ruta';

  @override
  String get progressTitle => 'Progreso de entregas';

  @override
  String snackDelivered(Object clientName) {
    return '✅ Entrega a $clientName completada';
  }

  @override
  String get snackRemoved => 'Entrega eliminada';

  @override
  String get undo => 'Deshacer';

  @override
  String get moreOptions => 'Más opciones';

  @override
  String get markPending => 'Marcar como pendiente';

  @override
  String get markDelivered => 'Marcar como entregado';

  @override
  String get remove => 'Eliminar';

  @override
  String get searchHint => 'Buscar por cliente, dirección o distrito';

  @override
  String get sortNewest => 'Más recientes';

  @override
  String get sortOldest => 'Más antiguas';

  @override
  String get sortStatus => 'Por estado';

  @override
  String get sortDistrict => 'Por distrito';
}
