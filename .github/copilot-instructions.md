# Instrucciones del Proyecto - App de Grabación de Audio

## Reglas de Arquitectura OBLIGATORIAS

### Flutter Vanilla Puro
- **PROHIBIDO**: freezed, bloc, json_serializable, riverpod, get_it u otros gestores externos
- **SOLO**: BaseWidget + ViewModel pattern con Provider básico

### BaseWidget Pattern (ÚNICO permitido)
- **PROHIBIDO**: `StatefulWidget` para nuevas pantallas (código nuevo)
- Vista: `BaseWidget` que inicializa ViewModel en `initState`
- ViewModel: Extiende `BaseVM` (que extiende `ChangeNotifier`)
- `BaseWidget` envuelve con `ChangeNotifierProvider` y expone `builder` + `onModelReady`
- **EXCEPCIÓN**: `StatefulWidget` solo cuando el widget necesita estado completamente independiente del ViewModel (ej: SearchBarWidget con TextEditingController propio)

### BaseVM (Base ViewModel)
- Extiende `ChangeNotifier`
- Controla estados: `busy`, `error`, `empty`
- Protege `notifyListeners()` verificando que no esté disposeado
- **TODA** la lógica de negocio debe estar en el ViewModel

### Estructura de ViewModels (OBLIGATORIA)
- **Orden estricto**: 
  1. Variables privadas (con underscore)
  2. Getters inmediatamente debajo de cada variable
  3. Setters inmediatamente debajo de cada getter
  4. Constructor (vacío o solo con dependencias)
  5. Método `onInit()`
  6. Métodos públicos
  7. Métodos privados (con underscore)
- **Ejemplo**:
  ```dart
  // Variable
  String _userName = '';
  
  // Getter inmediatamente debajo
  String get userName => _userName;
  
  // Setter inmediatamente debajo del getter
  set userName(String value) {
    _userName = value;
    notifyListeners();
  }
  ```

### BuildContext Usage
- **EVITAR** pasar `BuildContext` al ViewModel siempre que sea posible
- **PREFERIR**: Métodos del ViewModel que devuelvan valores, y la Vista decide qué hacer (mostrar dialog, navegar, etc.)
- **SOLO PERMITIDO** pasar `BuildContext` cuando:
  - Navegación es absolutamente necesaria desde el ViewModel
  - Mostrar dialogs que dependen del flujo de negocio
- **NUNCA** almacenar `BuildContext` en variables del ViewModel
- **SIEMPRE** pasar como parámetro en el método específico que lo necesita

### Separación Estricta
- Vista y ViewModel en archivos separados siempre
- **PROHIBIDO**: Lógica en widgets o fuera del ViewModel
- **PROHIBIDO**: Funciones que devuelvan `Widget` (incluso privadas o dentro de `build()`)
- Cada bloque visual debe tener comentario descriptivo en inglés

### Provider Usage
- **PROHIBIDO**: `Provider.of`, `context.read`, o pasar ViewModel entre widgets
- **EXCEPCIÓN ÚNICA**: `Provider.of(context)` SOLO permitido para inicializar modelo en `BaseWidget`
- **PROHIBIDO**: Acceder a `context` fuera del `builder` del `BaseWidget`
- Cada widget debe recibir solo datos necesarios por parámetros nombrados
- **IMPORTANTE**: Si un StatelessWidget necesita reaccionar a cambios del ViewModel, usar `ListenableBuilder` que escucha al ViewModel

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
- Variables: camelCase en inglés
- Clases/Widgets: PascalCase en inglés
- Archivos: snake_case en inglés

### Estilo
- Código limpio, profesional y serio
- Formato consistente (dart format)
- Eliminar prints de debug antes de commits

## Cumplimiento

**TODAS estas reglas son OBLIGATORIAS sin excepciones**
- Para código nuevo: Aplicar BaseWidget + BaseVM pattern estrictamente
- Para código legacy: Mantener consistencia actual hasta refactor planificado
- **Zero tolerancia**: No crear código que viole estas reglas
- Toda nueva pantalla/feature debe seguir el patrón establecido

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

## Reglas de Edición

1. **NO** llamar stopRecording() antes de confirmación del usuario
2. **SIEMPRE** mantener sincronización entre RecordingOverlayService y AudioRecorderScreen
3. **ELIMINAR** prints de debug antes de commits (usar debugPrint solo para desarrollo)
4. **EXTRAER** métodos cuando superen 20 líneas
5. **USAR** const constructors siempre que sea posible
6. **StatelessWidget** + `ListenableBuilder` para widgets que necesitan escuchar cambios del ViewModel
7. **StatefulWidget** solo para estado completamente independiente (ej: controladores de TextField)
