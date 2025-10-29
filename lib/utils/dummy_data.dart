import '../models/delivery.dart';

List<Delivery> getDummyDeliveries() {
  return [
    Delivery(
      id: 1,
      clientName: 'Juan Pérez',
      address: 'Calle 10 #45-12',
      district: 'Chapinero',
      delivered: false,
    ),
    Delivery(
      id: 2,
      clientName: 'Ana María Gómez',
      address: 'Carrera 5 #21-8',
      district: 'Usaquén',
      delivered: false,
    ),
    Delivery(
      id: 3,
      clientName: 'Carlos Ruiz',
      address: 'Avenida 30 #8-60',
      district: 'Teusaquillo',
      delivered: false,
    ),
    Delivery(
      id: 4,
      clientName: 'María Fernanda López',
      address: 'Calle 72 #10-34',
      district: 'Chapinero',
      delivered: false,
    ),
    Delivery(
      id: 5,
      clientName: 'Pedro Martínez',
      address: 'Carrera 15 #85-20',
      district: 'Chicó',
      delivered: false,
    ),
    Delivery(
      id: 6,
      clientName: 'Laura Sánchez',
      address: 'Calle 100 #18-90',
      district: 'Santa Bárbara',
      delivered: false,
    ),
    Delivery(
      id: 7,
      clientName: 'Diego Ramírez',
      address: 'Carrera 7 #45-85',
      district: 'La Candelaria',
      delivered: false,
    ),
    Delivery(
      id: 8,
      clientName: 'Sofía Torres',
      address: 'Avenida 19 #120-40',
      district: 'Cedritos',
      delivered: false,
    ),
  ];
}

