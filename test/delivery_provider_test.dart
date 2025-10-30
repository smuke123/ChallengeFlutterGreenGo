import 'package:flutter_test/flutter_test.dart';
import 'package:challengefluttergreengo/providers/delivery_provider.dart';
import 'package:challengefluttergreengo/models/delivery.dart';

void main() {
  test('DeliveryProvider calcula progreso y conteos correctamente', () async {
    final provider = DeliveryProvider();
    // Cargar datos iniciales asincrónicamente
    await Future.delayed(const Duration(milliseconds: 10));

    // Reemplazar entregas con set mínimo controlado
    await provider.resetDeliveries();

    // Añadir dos entregas controladas
    await provider.addDelivery(Delivery(id: 100, clientName: 'A', address: 'X', district: 'Y'));
    await provider.addDelivery(Delivery(id: 101, clientName: 'B', address: 'X', district: 'Y'));

    final totalBefore = provider.deliveries.length;
    expect(totalBefore >= 2, true);

    await provider.markAsDelivered(100);
    expect(provider.completedCount >= 1, true);
    expect(provider.pendingCount, totalBefore - provider.completedCount);
    expect(provider.progress, provider.completedCount / provider.deliveries.length);

    await provider.toggleDelivered(100);
    expect(provider.deliveries.firstWhere((d) => d.id == 100).delivered, false);
  });
}


