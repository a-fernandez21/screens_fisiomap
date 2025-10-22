/// Clase que define constantes globales de la aplicación FisioMap.
/// 
/// Centraliza todos los valores constantes utilizados en la aplicación,
/// incluyendo strings, dimensiones, y valores numéricos. Esto facilita
/// el mantenimiento y la consistencia en toda la aplicación.
/// 
/// El constructor es privado para prevenir la instanciación de esta clase.
class AppConstants {
  /// Constructor privado para prevenir instanciación.
  AppConstants._();

  // Strings y textos de la aplicación
  
  /// Nombre de la aplicación.
  static const String appName = 'FisioMap';
  
  /// Título del AppBar en la pantalla principal.
  static const String appTitle = 'FisioMap - Pacientes';
  
  /// Nombre de la clínica mostrado en el encabezado.
  static const String clinicName = 'Clínica FisioMap';
  
  /// Subtítulo de la clínica en el encabezado.
  static const String clinicSubtitle = 'Gestión de Pacientes';
  
  /// Título de la sección de lista de pacientes.
  static const String patientsListTitle = 'Lista de Pacientes';
  
  // Mensajes de la aplicación
  
  /// Mensaje mostrado al seleccionar un paciente.
  static const String patientSelectedMessage = 'Seleccionaste: ';
  
  /// Mensaje mostrado al intentar agregar un paciente (funcionalidad pendiente).
  static const String addPatientMessage = 'Funcionalidad de agregar paciente próximamente';
  
  // Etiquetas de interfaz
  
  /// Etiqueta para la fecha de última visita.
  static const String lastVisitLabel = 'Última visita: ';
  
  // Dimensiones y espaciado
  
  /// Padding predeterminado para contenedores.
  static const double defaultPadding = 16.0;
  
  /// Padding interno de las tarjetas.
  static const double cardPadding = 16.0;
  
  /// Espaciado entre tarjetas en listas.
  static const double cardSpacing = 12.0;
  
  /// Espaciado entre secciones principales.
  static const double sectionSpacing = 24.0;
  
  /// Espaciado entre elementos relacionados.
  static const double itemSpacing = 16.0;
  
  /// Espaciado pequeño entre elementos.
  static const double smallSpacing = 8.0;
  
  /// Espaciado muy pequeño entre elementos.
  static const double tinySpacing = 4.0;
  
  // Bordes y elevaciones
  
  /// Radio de bordes redondeados predeterminado.
  static const double borderRadius = 12.0;
  
  /// Elevación de sombra para tarjetas.
  static const double cardElevation = 3.0;
  
  /// Elevación de sombra para el AppBar.
  static const double appBarElevation = 4.0;
  
  // Tamaños de elementos
  
  /// Radio del avatar circular del paciente.
  static const double avatarRadius = 25.0;
  
  /// Tamaño de íconos grandes.
  static const double iconSize = 40.0;
  
  /// Tamaño de íconos pequeños.
  static const double smallIconSize = 16.0;
  
  // Propiedades de efectos visuales
  
  /// Radio de expansión de la sombra.
  static const double shadowSpreadRadius = 2.0;
  
  /// Radio de desenfoque de la sombra.
  static const double shadowBlurRadius = 5.0;
  
  /// Opacidad de la sombra (0.0 a 1.0).
  static const double shadowOpacity = 0.3;
}
