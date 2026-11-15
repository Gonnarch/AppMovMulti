# lab1112 – Gestión de Alumnos con widgets Cupertino

Laboratorio S11-S12 · App Multiplataforma (Flutter)

Mismo laboratorio de la semana 8 rehecho con widgets **Cupertino** (estilo iOS),
con un diseño oscuro "Aurora": fondo animado con movimiento continuo,
tarjetas con efecto vidrio (glassmorphism) y animaciones de entrada.

## Cómo ejecutar
```bash
flutter create . --platforms=android,web   # genera las carpetas de plataforma (no toca lib/)
flutter pub get
flutter run -d chrome   # o en emulador
```
Login: cualquier email válido y contraseña de 6+ caracteres.

## Estructura
```
lib/
├── main.dart                     CupertinoApp + tema global + fondo animado
├── theme/app_colors.dart         Paleta de colores y degradados
├── routes/app_routes.dart        Rutas con nombre (Map) + transición animada
├── models/alumno.dart            Modelo Alumno
├── providers/alumno_provider.dart Estado (lista de alumnos y perfil en un Map)
├── utils/dialogos.dart           CupertinoAlertDialog (mensaje / confirmación)
├── widgets/
│   ├── fondo_animado.dart        CustomPainter: burbujas, ondas y partículas en movimiento
│   ├── glass_card.dart           Card con BackdropFilter (vidrio)
│   ├── alumno_card.dart          Tarjeta reutilizable del alumno
│   ├── anillo_nota.dart          Anillo de progreso animado de la nota
│   ├── avatar.dart               Avatar con iniciales / anillo giratorio
│   ├── entrada_animada.dart      Animación de entrada en cascada
│   ├── tarjeta_estadistica.dart  Contador animado
│   ├── boton_gradiente.dart      CupertinoButton con degradado
│   ├── campo_vidrio.dart         CupertinoTextField estilizado
│   └── pantalla_base.dart        CupertinoPageScaffold + barra translúcida
└── pages/
    ├── login_page.dart
    ├── menu_page.dart
    ├── registrar_alumno_page.dart
    ├── alumnos_page.dart
    ├── detalle_alumno_page.dart
    └── perfil_page.dart
```

## Widgets Cupertino usados
CupertinoApp, CupertinoThemeData, CupertinoPageScaffold, CupertinoNavigationBar,
CupertinoListSection, CupertinoListTile, CupertinoListTileChevron, CupertinoTextField,
CupertinoSearchTextField, CupertinoSlidingSegmentedControl, CupertinoButton,
CupertinoActivityIndicator, CupertinoAlertDialog, CupertinoDialogAction,
CupertinoActionSheet, CupertinoPicker, CupertinoSwitch, CupertinoIcons.
