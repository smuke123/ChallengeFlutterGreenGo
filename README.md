# 🚴 GreenGo Logistics - App de Entregas Sostenibles

## 📱 Descripción
Aplicación Flutter para coordinar repartidores en bicicleta para entregas sostenibles en la ciudad. Permite a los repartidores gestionar sus entregas y a los supervisores monitorear el progreso en tiempo real.

## Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada
├── models/
│   └── delivery.dart           # Modelo de Entrega
├── providers/
│   ├── delivery_provider.dart  # Provider de entregas
│   └── theme_provider.dart     # Provider de tema
├── screens/
│   ├── home_screen.dart        # Pantalla principal
│   ├── delivery_list_screen.dart # Pantalla de repartidor
│   └── supervisor_screen.dart  # Pantalla de supervisor
├── widgets/
│   ├── animated_bike.dart      # Bicicleta animada
│   ├── delivery_card.dart      # Tarjeta de entrega
│   └── progress_bar.dart       # Barra de progreso animada
└── utils/
    └── dummy_data.dart         # Datos de prueba
```

## 🚀 Cómo Ejecutar

### 1. Clonar el repositorio
```bash
git clone https://github.com/smuke123/ChallengeFlutterGreenGo.git
cd ChallengeFlutterGreenGo
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Generar carpetas de plataforma
Reemplaza `<SISTEMA>` con tu plataforma: `windows`, `linux`, `macos`, `android`, `ios`, o `web`

```bash
flutter create --platforms=<SISTEMA> .
```

**Ejemplos:**
- Windows: `flutter create --platforms=windows .`
- Linux: `flutter create --platforms=linux .`
- Android: `flutter create --platforms=android .`

### 4. Ejecutar la aplicación
Reemplaza `<SISTEMA>` con tu plataforma:

```bash
flutter run -d <SISTEMA>
```

**Ejemplos:**
- Windows: `flutter run -d windows`
- Linux: `flutter run -d linux`
- Chrome: `flutter run -d chrome`

## 🎨 Autores

- [smuke123](https://github.com/smuke123).
- [Kysgrall](https://github.com/f1f2f3f4f5f6f7).

---
Desarrollado para el Challenge de GreenGo Logistics 

