# Aula violeta · Sección A

Interfaz Flutter inspirada en la sección A de la referencia. Incluye acceso de demostración, menú, búsqueda de alumnos, registro con foto opcional y perfil docente editable. Diseño morado con tarjetas, navegación inferior y fondo educativo animado dibujado en Flutter, sin imágenes externas.

## Ejecutar

Con Flutter estable reciente instalado, abre esta carpeta en VS Code o Android Studio y ejecuta:

```sh
flutter pub get
flutter run -d chrome
```

Para generar la estructura Android y ejecutar en un emulador o dispositivo:

```sh
flutter create --platforms=android .
flutter run
```

## Probar el recorrido

1. Inicia sesión con cualquier correo válido y una contraseña de al menos cuatro caracteres.
2. Abre Registrar, elige una fotografía de la galería y escribe nombre, apellido y una nota de 0 a 20.
3. Guarda el alumno y búscalo en Alumnos. Desde 11 se muestra Aprobado.
4. En Perfil, cambia el nombre, correo, teléfono o foto de la docente.
5. Usa el botón de salida en la cabecera para volver al acceso.

## Alcance

Es un prototipo funcional de interfaz: la autenticación es de demostración y los registros, fotos y cambios de perfil viven solo en memoria; se reinician al cerrar o recargar la aplicación. No incluye servidor ni base de datos. El fondo respeta la preferencia del sistema de reducir animaciones.

## Verificación en este entorno

Dependencias resueltas y código formateado. `flutter analyze` finalizó sin errores ni advertencias.

## Organización y conceptos solicitados

```text
lib/
  main.dart                     Punto de entrada
  app/
    aula_app.dart               Configuración y mapa de rutas
    app_routes.dart             Nombres de rutas
  core/
    theme/app_theme.dart        Tema global: colores, campos, botones y Cards
    utils/photo_picker.dart     Selección de fotografías
    utils/validators.dart       Validaciones compartidas
  models/student.dart           Modelo y conversión desde/hacia Map
  data/aula_store.dart           Lista de alumnos y estado entre rutas
  screens/
    aula_home.dart              Acceso, menú, perfil y estructura de navegación
    student_list_screen.dart    Búsqueda y lista de alumnos
    student_form.dart           Formulario de registro
  widgets/
    academic_background.dart    Animación real dibujada en cada fotograma
    common_widgets.dart         Elementos visuales reutilizados
```

- **ListView.separated:** construye los alumnos visibles de forma diferida y agrega separación entre tarjetas. La lista ocupa su propio espacio desplazable.
- **ListTile:** organiza foto, nombre, nota y estado de cada alumno; también las opciones del menú.
- **List y Map:** los datos iniciales usan una lista de mapas; `Student.fromMap` los transforma en objetos. `toMap` permite convertir los datos textuales del alumno a un mapa (la foto se mantiene aparte en memoria).
- **Rutas:** `/`, `/menu`, `/alumnos`, `/registrar` y `/perfil`. Se usa Navigator para cambiar de sección y limpiar la navegación al salir.
- **Tema global:** `AppTheme.light` se aplica desde MaterialApp; incluye el estilo compartido de Cards.
- **Cards:** tarjetas reales de Flutter en menú y alumnos.

## Diseño con movimiento real

El acceso utiliza una composición violeta nocturna con tipografía grande, emblema luminoso y tarjeta de formulario clara. El resto del portal combina superficies claras con acentos morados. No se copia el diseño de la referencia.

Un AnimationController mueve luces de color, libros, símbolos educativos y órbitas mediante CustomPainter. El ciclo dura 18 segundos; el fondo no es una imagen estática ni un GIF. Si el sistema tiene activada la reducción de movimiento, la animación se presenta detenida para respetar esa preferencia.

El proyecto requiere Flutter estable reciente compatible con Dart 3.8 o superior. La comprobación visual del recorrido en un dispositivo sigue pendiente.


Verificación final: flutter build web terminó correctamente y generó build/web. La revisión visual interactiva en dispositivo sigue pendiente.
