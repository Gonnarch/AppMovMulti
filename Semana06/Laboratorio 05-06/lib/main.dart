import 'package:flutter/material.dart';

void main() {
  runApp(const CalendarDesignApp());
}

class CalendarDesignApp extends StatelessWidget {
  const CalendarDesignApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendar Design Lab',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MenuCalendarios(),
    );
  }
}

// ============================================================
// MENÚ PRINCIPAL
// ============================================================

class MenuCalendarios extends StatelessWidget {
  const MenuCalendarios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 242, 247, 1),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 440,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  size: 76,
                  color: Color.fromRGBO(73, 83, 210, 1),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Propuestas de Calendario',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '3 diseños visuales diferentes',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 32),

                opcion(
                  context,
                  numero: '01',
                  titulo: 'Nature Escape',
                  subtitulo: 'Viajes, naturaleza y otoño',
                  color: const Color.fromRGBO(190, 103, 52, 1),
                  icono: Icons.landscape_rounded,
                  pagina: const CalendarioNature(),
                ),

                const SizedBox(height: 14),

                opcion(
                  context,
                  numero: '02',
                  titulo: 'Neon Glass',
                  subtitulo: 'Futurista y transparente',
                  color: const Color.fromRGBO(116, 73, 255, 1),
                  icono: Icons.auto_awesome_rounded,
                  pagina: const CalendarioGlass(),
                ),

                const SizedBox(height: 14),

                opcion(
                  context,
                  numero: '03',
                  titulo: 'Social Editorial',
                  subtitulo: 'Agenda social estilo revista',
                  color: const Color.fromRGBO(255, 72, 106, 1),
                  icono: Icons.people_alt_rounded,
                  pagina: const CalendarioEditorial(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget opcion(
    BuildContext context, {
    required String numero,
    required String titulo,
    required String subtitulo,
    required Color color,
    required IconData icono,
    required Widget pagina,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => pagina),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.07),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icono,
                color: Colors.white,
                size: 29,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$numero  $titulo',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitulo,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 17),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CALENDARIO 1 - NATURE ESCAPE
// ============================================================

class CalendarioNature extends StatelessWidget {
  const CalendarioNature({super.key});

  @override
  Widget build(BuildContext context) {
    const fondo = Color.fromRGBO(249, 240, 226, 1);
    const marron = Color.fromRGBO(91, 59, 42, 1);
    const naranja = Color.fromRGBO(199, 105, 55, 1);

    return Scaffold(
      backgroundColor: fondo,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 440,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 280,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(97, 122, 92, 1),
                              Color.fromRGBO(196, 123, 68, 1),
                              Color.fromRGBO(239, 187, 118, 1),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(42),
                            bottomRight: Radius.circular(42),
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 20,
                        top: 68,
                        child: Text(
                          '🍂',
                          style: TextStyle(fontSize: 76),
                        ),
                      ),
                      const Positioned(
                        left: 28,
                        top: 135,
                        child: Text(
                          '🏔️',
                          style: TextStyle(fontSize: 95),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                const CircleAvatar(
                                  radius: 23,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: marron,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 35),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'SEPTIEMBRE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      letterSpacing: 4,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '2026',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 46,
                                      height: 1,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Explora nuevos momentos',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Transform.translate(
                    offset: const Offset(0, -28),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(78, 54, 35, 0.13),
                            blurRadius: 24,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          filaDiasNaturaleza(),
                          const SizedBox(height: 14),
                          filaNature(['31', '1', '2', '3', '4', '5', '6']),
                          filaNature(['7', '8', '9', '10', '11', '12', '13']),
                          filaNature(
                            ['14', '15', '16', '17', '18', '19', '20'],
                          ),
                          filaNature(
                            ['21', '22', '23', '24', '25', '26', '27'],
                            destacado: '21',
                          ),
                          filaNature(
                            ['28', '29', '30', '1', '2', '3', '4'],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Próximas aventuras',
                              style: TextStyle(
                                color: marron,
                                fontSize: 23,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '🍁',
                              style: TextStyle(fontSize: 27),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        eventoNature(
                          icono: Icons.flight_takeoff_rounded,
                          titulo: 'Viaje a Cusco',
                          fecha: '05 SEP · 07:30',
                          color: const Color.fromRGBO(111, 139, 93, 1),
                        ),
                        eventoNature(
                          icono: Icons.camera_alt_rounded,
                          titulo: 'Sesión fotográfica',
                          fecha: '12 SEP · 16:00',
                          color: naranja,
                        ),
                        eventoNature(
                          icono: Icons.hiking_rounded,
                          titulo: 'Ruta de montaña',
                          fecha: '21 SEP · 08:00',
                          color: const Color.fromRGBO(143, 92, 59, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget filaDiasNaturaleza() {
    const dias = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];

    return Row(
      children: dias.map((dia) {
        return Expanded(
          child: Center(
            child: Text(
              dia,
              style: const TextStyle(
                color: Color.fromRGBO(143, 110, 85, 1),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget filaNature(
    List<String> dias, {
    String? destacado,
  }) {
    return Row(
      children: dias.map((dia) {
        final activo = dia == destacado;

        return Expanded(
          child: Container(
            height: 49,
            margin: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              color: activo
                  ? const Color.fromRGBO(222, 142, 74, 1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  dia,
                  style: TextStyle(
                    color: activo
                        ? Colors.white
                        : const Color.fromRGBO(91, 59, 42, 1),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (activo)
                  const Positioned(
                    right: 1,
                    top: -2,
                    child: Text(
                      '🍂',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget eventoNature({
    required IconData icono,
    required String titulo,
    required String fecha,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 53,
            height: 53,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icono, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Color.fromRGBO(91, 59, 42, 1),
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  fecha,
                  style: const TextStyle(
                    color: Color.fromRGBO(150, 120, 95, 1),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_outward_rounded,
            color: Color.fromRGBO(150, 120, 95, 1),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CALENDARIO 2 - NEON GLASS
// ============================================================

class CalendarioGlass extends StatelessWidget {
  const CalendarioGlass({super.key});

  @override
  Widget build(BuildContext context) {
    const morado = Color.fromRGBO(116, 73, 255, 1);
    const cyan = Color.fromRGBO(63, 218, 255, 1);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(28, 22, 70, 1),
              Color.fromRGBO(69, 40, 135, 1),
              Color.fromRGBO(17, 74, 115, 1),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: 440,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.cloud_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                              SizedBox(width: 6),
                              Text(
                                '18°C',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SEPT',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 17,
                                letterSpacing: 4,
                              ),
                            ),
                            Text(
                              '2026',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                height: 1,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          '✦',
                          style: TextStyle(
                            color: cyan,
                            fontSize: 54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Column(
                        children: [
                          diasGlass(),
                          const SizedBox(height: 15),
                          filaGlass(['31', '1', '2', '3', '4', '5', '6']),
                          filaGlass(['7', '8', '9', '10', '11', '12', '13']),
                          filaGlass(
                            ['14', '15', '16', '17', '18', '19', '20'],
                          ),
                          filaGlass(
                            ['21', '22', '23', '24', '25', '26', '27'],
                            destacado: '24',
                          ),
                          filaGlass(
                            ['28', '29', '30', '1', '2', '3', '4'],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tu ritmo del día',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    eventoGlass(
                      momento: 'MORNING',
                      titulo: 'Daily Planning',
                      hora: '08:30',
                      icono: Icons.wb_sunny_outlined,
                      color: const Color.fromRGBO(255, 188, 90, 1),
                    ),
                    eventoGlass(
                      momento: 'AFTERNOON',
                      titulo: 'UX Review',
                      hora: '14:00',
                      icono: Icons.design_services_rounded,
                      color: cyan,
                    ),
                    eventoGlass(
                      momento: 'EVENING',
                      titulo: 'Creative Session',
                      hora: '19:30',
                      icono: Icons.auto_awesome_rounded,
                      color: morado,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget diasGlass() {
    const dias = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    return Row(
      children: dias.map((dia) {
        return Expanded(
          child: Center(
            child: Text(
              dia,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget filaGlass(
    List<String> dias, {
    String? destacado,
  }) {
    return Row(
      children: dias.map((dia) {
        final activo = dia == destacado;

        return Expanded(
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              gradient: activo
                  ? const LinearGradient(
                      colors: [
                        Color.fromRGBO(63, 218, 255, 1),
                        Color.fromRGBO(116, 73, 255, 1),
                      ],
                    )
                  : null,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              dia,
              style: TextStyle(
                color: Colors.white,
                fontWeight: activo ? FontWeight.w900 : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget eventoGlass({
    required String momento,
    required String titulo,
    required String hora,
    required IconData icono,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icono, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  momento,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Text(
            hora,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CALENDARIO 3 - SOCIAL EDITORIAL
// ============================================================

class CalendarioEditorial extends StatelessWidget {
  const CalendarioEditorial({super.key});

  @override
  Widget build(BuildContext context) {
    const negro = Color.fromRGBO(25, 25, 28, 1);
    const rosa = Color.fromRGBO(255, 72, 106, 1);
    const amarillo = Color.fromRGBO(255, 218, 79, 1);
    const azul = Color.fromRGBO(83, 133, 255, 1);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 248, 245, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 440,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        radius: 23,
                        backgroundColor: negro,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MY SOCIAL',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'SEPTEMBER',
                              style: TextStyle(
                                color: negro,
                                fontSize: 37,
                                height: 1.05,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '26',
                        style: TextStyle(
                          color: rosa,
                          fontSize: 72,
                          height: 0.9,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: const Color.fromRGBO(225, 225, 220, 1),
                      ),
                    ),
                    child: Column(
                      children: [
                        diasEditorial(),
                        const SizedBox(height: 12),
                        filaEditorial(['31', '1', '2', '3', '4', '5', '6']),
                        filaEditorial(
                          ['7', '8', '9', '10', '11', '12', '13'],
                          eventos: ['10'],
                        ),
                        filaEditorial(
                          ['14', '15', '16', '17', '18', '19', '20'],
                          eventos: ['18'],
                        ),
                        filaEditorial(
                          ['21', '22', '23', '24', '25', '26', '27'],
                          destacado: '26',
                          eventos: ['23'],
                        ),
                        filaEditorial(
                          ['28', '29', '30', '1', '2', '3', '4'],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: negro,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 11,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: amarillo,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'FEATURED',
                                style: TextStyle(
                                  color: negro,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              '26 SEP',
                              style: TextStyle(
                                color: Colors.white54,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Creative\nMeetup',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            height: 0.95,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            avatarColor(rosa, 'C'),
                            Transform.translate(
                              offset: const Offset(-8, 0),
                              child: avatarColor(azul, 'A'),
                            ),
                            Transform.translate(
                              offset: const Offset(-16, 0),
                              child: avatarColor(amarillo, 'M'),
                            ),
                            const SizedBox(width: 2),
                            const Text(
                              '+12 personas',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: eventoEditorialMini(
                          color: rosa,
                          icono: Icons.coffee_rounded,
                          titulo: 'Coffee\nTalk',
                          fecha: '10 SEP',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: eventoEditorialMini(
                          color: azul,
                          icono: Icons.headphones_rounded,
                          titulo: 'Music\nNight',
                          fecha: '18 SEP',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget diasEditorial() {
    const dias = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Row(
      children: dias.map((dia) {
        return Expanded(
          child: Center(
            child: Text(
              dia,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget filaEditorial(
    List<String> dias, {
    String? destacado,
    List<String> eventos = const [],
  }) {
    return Row(
      children: dias.map((dia) {
        final activo = dia == destacado;
        final tieneEvento = eventos.contains(dia);

        return Expanded(
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              color: activo
                  ? const Color.fromRGBO(255, 72, 106, 1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dia,
                  style: TextStyle(
                    color: activo
                        ? Colors.white
                        : const Color.fromRGBO(25, 25, 28, 1),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: tieneEvento
                        ? const Color.fromRGBO(83, 133, 255, 1)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget avatarColor(Color color, String letra) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: color,
      child: Text(
        letra,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget eventoEditorialMini({
    required Color color,
    required IconData icono,
    required String titulo,
    required String fecha,
  }) {
    return Container(
      height: 155,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icono,
            color: Colors.white,
            size: 27,
          ),
          const Spacer(),
          Text(
            titulo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              height: 1,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            fecha,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
