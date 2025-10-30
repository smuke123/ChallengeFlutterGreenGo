# 🚴 GreenGo Logistics - App de Entregas Sostenibles

## 📱 Descripción
Aplicación Flutter para coordinar repartidores en bicicleta para entregas sostenibles en la ciudad. Permite a los repartidores gestionar sus entregas y a los supervisores monitorear el progreso en tiempo real.

## Estructura del Proyecto

```
lib/
├── main.dart                         # Punto de entrada (Providers + i18n + temas)
├── l10n/                              # Localización (i18n)
│   ├── app_es.arb                    # Español
│   └── app_en.arb                    # Inglés
├── models/
│   └── delivery.dart                 # Modelo de Entrega (copyWith/JSON)
├── providers/
│   ├── delivery_provider.dart        # Estado de entregas (inmutable + persistencia)
│   └── theme_provider.dart           # Tema claro/oscuro con SharedPreferences
├── screens/
│   ├── home_screen.dart              # Pantalla principal
│   ├── delivery_list_screen.dart     # Pantalla de repartidor (tabs + progreso)
│   └── supervisor_screen.dart        # Panel de supervisor (filtros/búsqueda/orden)
├── widgets/
│   ├── animated_bike.dart            # Bicicleta animada con LayoutBuilder
│   ├── delivery_card.dart            # Tarjeta con menú contextual y accesibilidad
│   └── progress_bar.dart             # Barra de progreso animada y temática
└── utils/
    └── dummy_data.dart               # Datos de prueba

test/
├── widget_test.dart                  # Smoke test de arranque y título
└── delivery_provider_test.dart       # Pruebas de progreso y conteos
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

### 4. Localización (i18n)
La app soporta Español e Inglés. Se detecta automáticamente por el idioma del sistema.

- Archivos de localización: `lib/l10n/app_es.arb`, `lib/l10n/app_en.arb`.
- Para regenerar localizaciones:
```bash
flutter gen-l10n
```
- Para forzar un idioma (sólo pruebas), puedes establecer `locale` en `MaterialApp`.

### 5. Ejecutar la aplicación
Reemplaza `<SISTEMA>` con tu plataforma:

```bash
flutter run -d <SISTEMA>
```

**Ejemplos:**
- Windows: `flutter run -d windows`
- Linux: `flutter run -d linux`
- Chrome: `flutter run -d chrome`

### 6. Ejecutar pruebas
```bash
flutter test
```

## 🎨 Autores

- [Edgar Santiago Ariza - smuke123](https://github.com/smuke123).
- [Kevin Daniel Castro Mendoza - Kysgrall](https://github.com/f1f2f3f4f5f6f7).

---
Desarrollado para el Challenge de GreenGo Logistics 

