import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/delivery.dart';
import '../utils/dummy_data.dart';

class DeliveryProvider with ChangeNotifier {
  List<Delivery> _deliveries = [];
  static const String _deliveriesKey = 'deliveries';

  List<Delivery> get deliveries => List.unmodifiable(_deliveries);

  DeliveryProvider() {
    _loadDeliveries();
  }

  // Cargar entregas guardadas o usar datos dummy
  Future<void> _loadDeliveries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? deliveriesJson = prefs.getString(_deliveriesKey);

    if (deliveriesJson != null && deliveriesJson.isNotEmpty) {
      final List<dynamic> decoded = jsonDecode(deliveriesJson);
      _deliveries = decoded.map((json) => Delivery.fromJson(json)).toList();
    } else {
      // Si no hay datos guardados, usar datos dummy
      _deliveries = getDummyDeliveries();
      await _saveDeliveries();
    }
    notifyListeners();
  }

  // Guardar entregas en shared_preferences
  Future<void> _saveDeliveries() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(
      _deliveries.map((delivery) => delivery.toJson()).toList(),
    );
    await prefs.setString(_deliveriesKey, encoded);
  }

  // Marcar como entregado (inmutable)
  Future<void> markAsDelivered(int id) async {
    _deliveries = _deliveries
        .map((d) => d.id == id ? d.copyWith(delivered: true) : d)
        .toList(growable: false);
    await _saveDeliveries();
    notifyListeners();
  }

  // Alternar estado de entrega (inmutable)
  Future<void> toggleDelivered(int id) async {
    _deliveries = _deliveries
        .map((d) => d.id == id ? d.copyWith(delivered: !d.delivered) : d)
        .toList(growable: false);
    await _saveDeliveries();
    notifyListeners();
  }

  // Resetear todas las entregas (para testing)
  Future<void> resetDeliveries() async {
    _deliveries = getDummyDeliveries();
    await _saveDeliveries();
    notifyListeners();
  }

  // Agregar nueva entrega
  Future<void> addDelivery(Delivery delivery) async {
    _deliveries = [..._deliveries, delivery];
    await _saveDeliveries();
    notifyListeners();
  }

  // Actualizar una entrega por id (inmutable)
  Future<void> updateDelivery(int id, Delivery updated) async {
    _deliveries = _deliveries
        .map((d) => d.id == id ? updated : d)
        .toList(growable: false);
    await _saveDeliveries();
    notifyListeners();
  }

  // Eliminar una entrega por id (inmutable)
  Future<void> removeDelivery(int id) async {
    _deliveries = _deliveries.where((d) => d.id != id).toList(growable: false);
    await _saveDeliveries();
    notifyListeners();
  }

  // Obtener progreso
  double get progress {
    if (_deliveries.isEmpty) return 0.0;
    return _deliveries.where((d) => d.delivered).length / _deliveries.length;
  }

  // Obtener cantidad de entregas completadas
  int get completedCount => _deliveries.where((d) => d.delivered).length;

  // Obtener cantidad de entregas pendientes
  int get pendingCount => _deliveries.where((d) => !d.delivered).length;

  // Obtener entregas pendientes
  List<Delivery> get pendingDeliveries =>
      _deliveries.where((d) => !d.delivered).toList();

  // Obtener entregas completadas
  List<Delivery> get completedDeliveries =>
      _deliveries.where((d) => d.delivered).toList();
}
