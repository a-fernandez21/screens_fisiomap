# Instrucciones del Proyecto - App de Grabación de Audio

## Reglas de Arquitectura OBLIGATORIAS

### Flutter Vanilla Puro
- **PROHIBIDO**: freezed, bloc, json_serializable, riverpod, get_it u otros gestores externos
- **SOLO**: BaseWidget + ViewModel pattern con Provider básico

### BaseWidget Pattern (ÚNICO permitido)
- **NO** usar `StatefulWidget` para nuevas pantallas
- Vista: `BaseWidget` que inicializa ViewModel en `initState`
- ViewModel: Extiende `BaseVM` (que extiende `ChangeNotifier`)
- `BaseWidget` envuelve con `ChangeNotifierProvider` y expone `builder` + `onModelReady`

### BaseVM (Base ViewModel)
- Extiende `ChangeNotifier`
- Controla estados: `busy`, `error`, `empty`
- Protege `notifyListeners()` verificando que no esté disposeado
- **TODA** la lógica de negocio debe estar en el ViewModel

### Separación Estricta
- Vista y ViewModel en archivos separados siempre
- **PROHIBIDO**: Lógica en widgets o fuera del ViewModel
- **PROHIBIDO**: Funciones que devuelvan `Widget` (incluso privadas o dentro de `build()`)
- Cada bloque visual debe tener comentario descriptivo en inglés

### Provider Usage
- **PROHIBIDO**: `Provider.of`, `context.read`, o pasar ViewModel entre widgets
- **EXCEPCIÓN**: `Provider.of(context)` SOLO permitido para inicializar modelo en `BaseWidget`
- **PROHIBIDO**: Acceder a `context` fuera del `builder` del `BaseWidget`
- Cada widget debe recibir solo datos necesarios por parámetros nombrados

### Arquitectura Actual (Legacy - Migrar progresivamente)
- `AudioRecorderService`: Lógica de grabación con flutter_sound (Singleton)
- `RecordingOverlayService`: Gestión del widget flotante (Singleton)
- Patrón actual: `factory Service() => _instance;`
- **NOTA**: Estas pantallas usan `StatefulWidget` (código legacy, mantener hasta refactor)

## Workflows Críticos

### Navegación
- Stack overlay para widget flotante minimizado
- Restaurar estado completo al maximizar (paciente, marcas, tiempo)
- **eventBus**: Solo desde instancia global, nunca crear instancias locales

## Reglas de Código ESTRICTAS

### Modularización
- Widget supera 40-50 líneas → Dividir en `widgets/` con componentes pequeños
- Métodos superan 20 líneas → Extraer en métodos privados con nombres descriptivos

### Tipado Explícito
- **PROHIBIDO**: `var` y `dynamic` (salvo justificación técnica clara en comentario)
- Declarar siempre tipos explícitos: `final String name`, `List<int> ids`

### Parámetros Nombrados
- Funciones con más de 1 parámetro deben usar parámetros nombrados
- Ejemplo: `void saveRecording({required String path, required int duration})`

### Naming Conventions
- **Código/Comentarios**: Inglés estricto (`userName`, `// Initialize audio stream`)
- **Textos UI**: Español sin punto final (`"Grabación iniciada"`, `"Error al guardar"`)
- Nombres claros, consistentes, autodescriptivos

### Estilo
- Código limpio, profesional y serio
- Formato consistente (dart format)
- Eliminar prints de debug antes de commits

## Cumplimiento

**TODAS estas reglas son OBLIGATORIAS sin excepciones**
- Para código nuevo: Aplicar BaseWidget + BaseVM pattern
- Para código legacy: Mantener consistencia actual hasta refactor planificado

## Workflows Críticos

### Ciclo de Grabación
1. **Start** → Iniciar stream de micrófono
2. **Pause** → Mantener archivo, pausar timer
3. **Resume** → Reactivar stream y timer
4. **Minimize** → Mostrar overlay flotante, mantener grabación
5. **Restore** → Cerrar overlay, volver a pantalla completa
6. **Stop** → Confirmar ANTES de detener (no destruir estado prematuramente)

### Animación de Ondas
- **Pantalla principal**: 70 ondas, amplitudes reales del micrófono (0-120 dB)
  - Normalización: `0.05 + ((decibels - 45) / 20) * 0.95` para rango 45-65 dB
  - Actualización en tiempo real desde stream
- **Widget flotante**: 8 ondas, simuladas con `sin(animValue)`
  - No usa audio real, solo animación visual

## Convenciones Específicas

### Organización de Widgets
- Estructura: `/lib/widgets/{recorder|marks|patient|selectors|common}/`
- Cada carpeta tiene barrel file exportando todos los widgets
- Ejemplo: `lib/widgets/recorder/recorder_widgets.dart` exporta 9 widgets

### Patrones de Código
```dart
// Early returns para claridad
void setInAudioScreen(bool value) {
  if (_inAudioScreen == value) return;
  if (!_isRecording) return;
  _inAudioScreen = value;
  // ... lógica
}

// Extracción de métodos cuando supera 15-20 líneas
void _updateWaveHeights() {
  // Lógica específica extraída
}
```

### Async/Await
- Siempre esperar confirmación del usuario ANTES de acciones destructivas
- Ejemplo: Mostrar dialog → Esperar respuesta → Solo entonces stopRecording()

### Gestión de Streams
- Cancelar subscriptions en dispose()
- Recrear streams al resumir después de pausa
- Verificar null antes de acceder a subscription

## Archivos Críticos

- `lib/screens/audio_recorder_screen.dart` (1014 líneas): Pantalla principal
- `lib/services/recording_overlay_service.dart` (326 líneas): Widget flotante
- `lib/services/audio_recorder_service.dart`: Lógica de grabación
- `lib/widgets/audio_recorder_widgets.dart` (634 líneas): Componentes reutilizables

## Dependencias Clave

- `flutter_sound ^9.3.8`: Grabación AAC
- `permission_handler ^12.0.1`: Permisos de micrófono
- `path_provider ^2.0.16`: Almacenamiento de archivos

## Reglas de Edición

1. **NO** llamar stopRecording() antes de confirmación del usuario
2. **SIEMPRE** mantener sincronización entre RecordingOverlayService y AudioRecorderScreen
3. **ELIMINAR** prints de debug antes de commits
4. **EXTRAER** métodos cuando superen 20 líneas
5. **USAR** const constructors siempre que sea posible
