import 'package:flutter/material.dart';

void main() {
  runApp(const CalendarLabApp());
}

class CalendarLabApp extends StatelessWidget {
  const CalendarLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laboratorio Calendarios',
      theme: ThemeData(useMaterial3: true),
      home: const CalendarMenu(),
    );
  }
}

class CalendarMenu extends StatelessWidget {
  const CalendarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 243, 248, 1),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 430,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_month_rounded,
                    size: 72,
                    color: Color.fromRGBO(80, 90, 220, 1),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Diseños de Calendario',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Selecciona uno de los tres modelos',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  _menuButton(
                    context,
                    'Calendario 1',
                    'Inspirado en Steam',
                    Icons.sports_esports,
                    const Color.fromRGBO(23, 26, 33, 1),
                    const SteamCalendar(),
                  ),
                  const SizedBox(height: 14),
                  _menuButton(
                    context,
                    'Calendario 2',
                    'Inspirado en TikTok',
                    Icons.music_note,
                    Colors.black,
                    const TikTokCalendar(),
                  ),
                  const SizedBox(height: 14),
                  _menuButton(
                    context,
                    'Calendario 3',
                    'Inspirado en X Spaces',
                    Icons.mic,
                    const Color.fromRGBO(22, 24, 28, 1),
                    const XCalendar(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    Widget page,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.07),
              blurRadius: 14,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 18),
          ],
        ),
      ),
    );
  }
}

const List<List<String>> septemberWeeks = [
  ['31', '1', '2', '3', '4', '5', '6'],
  ['7', '8', '9', '10', '11', '12', '13'],
  ['14', '15', '16', '17', '18', '19', '20'],
  ['21', '22', '23', '24', '25', '26', '27'],
  ['28', '29', '30', '1', '2', '3', '4'],
];

const List<String> weekDays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

class SteamCalendar extends StatelessWidget {
  const SteamCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    const background = Color.fromRGBO(23, 26, 33, 1);
    const card = Color.fromRGBO(27, 40, 56, 1);
    const accent = Color.fromRGBO(102, 192, 244, 1);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: Colors.white,
        title: const Text('Calendario 1'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 430,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(27, 40, 56, 1),
                          Color.fromRGBO(42, 71, 94, 1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.grid_view_rounded, color: Colors.white),
                        Column(
                          children: [
                            Text(
                              'Septiembre 2026',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Biblioteca de actividades',
                              style: TextStyle(
                                color: Color.fromRGBO(170, 190, 210, 1),
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.notifications_none, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _calendarCard(
                    cardColor: card,
                    dayColor: accent,
                    textColor: Colors.white,
                    selectedColor: accent,
                    selectedTextColor: Colors.black,
                    selectedDay: '21',
                    borderRadius: 18,
                  ),
                  const SizedBox(height: 24),
                  _sectionTitle('Eventos destacados', Colors.white),
                  const SizedBox(height: 14),
                  _eventCard(
                    Icons.groups,
                    'Reunión de equipo',
                    '5 de septiembre · 10:00 a.m.',
                    accent,
                    card,
                    Colors.white,
                  ),
                  _eventCard(
                    Icons.school,
                    'Examen de programación',
                    '12 de septiembre · 9:00 a.m.',
                    const Color.fromRGBO(70, 130, 180, 1),
                    card,
                    Colors.white,
                  ),
                  _eventCard(
                    Icons.analytics,
                    'Presentación de proyecto',
                    '21 de septiembre · 2:00 p.m.',
                    const Color.fromRGBO(90, 170, 220, 1),
                    card,
                    Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TikTokCalendar extends StatelessWidget {
  const TikTokCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    const background = Colors.black;
    const card = Color.fromRGBO(18, 18, 18, 1);
    const cyan = Color.fromRGBO(0, 242, 234, 1);
    const pink = Color.fromRGBO(255, 0, 80, 1);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: Colors.white,
        title: const Text('Calendario 2'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 430,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: card,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: cyan, width: 1.5),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.bolt, color: cyan),
                        Column(
                          children: [
                            Text(
                              'Septiembre 2026',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Planifica · Crea · Disfruta',
                              style: TextStyle(color: pink),
                            ),
                          ],
                        ),
                        Icon(Icons.favorite_border, color: pink),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _calendarCard(
                    cardColor: card,
                    dayColor: Colors.white70,
                    textColor: Colors.white,
                    selectedColor: pink,
                    selectedTextColor: Colors.white,
                    selectedDay: '12',
                    borderRadius: 14,
                    selectedBorderColor: cyan,
                  ),
                  const SizedBox(height: 24),
                  _sectionTitle('Para ti', Colors.white),
                  const SizedBox(height: 14),
                  _eventCard(
                    Icons.music_note,
                    'Sesión creativa',
                    '5 SEP · 10:00 a.m.',
                    cyan,
                    card,
                    Colors.white,
                  ),
                  _eventCard(
                    Icons.code,
                    'Examen de programación',
                    '12 SEP · 9:00 a.m.',
                    pink,
                    card,
                    Colors.white,
                  ),
                  _eventCard(
                    Icons.movie_creation_outlined,
                    'Presentación del proyecto',
                    '21 SEP · 2:00 p.m.',
                    const Color.fromRGBO(160, 90, 255, 1),
                    card,
                    Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class XCalendar extends StatelessWidget {
  const XCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    const background = Colors.black;
    const card = Color.fromRGBO(22, 24, 28, 1);
    const blue = Color.fromRGBO(29, 155, 240, 1);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: Colors.white,
        title: const Text('Calendario 3'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 430,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: card,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(
                          radius: 23,
                          backgroundColor: blue,
                          child: Icon(Icons.mic, color: Colors.white),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Septiembre 2026',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Organiza tus próximos espacios',
                                style: TextStyle(
                                  color: Color.fromRGBO(130, 140, 150, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.more_horiz, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _calendarCard(
                    cardColor: card,
                    dayColor: const Color.fromRGBO(130, 140, 150, 1),
                    textColor: Colors.white70,
                    selectedColor: blue,
                    selectedTextColor: Colors.white,
                    selectedDay: '21',
                    borderRadius: 24,
                    borderColor: const Color.fromRGBO(47, 51, 54, 1),
                  ),
                  const SizedBox(height: 24),
                  _sectionTitle('Próximos espacios', Colors.white),
                  const SizedBox(height: 14),
                  _eventCard(
                    Icons.groups_rounded,
                    'Reunión de equipo',
                    '5 Sep · 10:00 a.m.',
                    blue,
                    card,
                    Colors.white,
                    circularIcon: true,
                  ),
                  _eventCard(
                    Icons.school_outlined,
                    'Examen de programación',
                    '12 Sep · 9:00 a.m.',
                    blue,
                    card,
                    Colors.white,
                    circularIcon: true,
                  ),
                  _eventCard(
                    Icons.mic_none_rounded,
                    'Presentación de proyecto',
                    '21 Sep · 2:00 p.m.',
                    blue,
                    card,
                    Colors.white,
                    circularIcon: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _calendarCard({
  required Color cardColor,
  required Color dayColor,
  required Color textColor,
  required Color selectedColor,
  required Color selectedTextColor,
  required String selectedDay,
  required double borderRadius,
  Color? borderColor,
  Color? selectedBorderColor,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(24),
      border: borderColor == null ? null : Border.all(color: borderColor),
    ),
    child: Column(
      children: [
        Row(
          children: weekDays
              .map(
                (day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        color: dayColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 12),
        ...septemberWeeks.map(
          (week) => Row(
            children: week.map((day) {
              final selected = day == selectedDay;
              return Expanded(
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 1),
                  decoration: BoxDecoration(
                    color: selected ? selectedColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: selected && selectedBorderColor != null
                        ? Border.all(color: selectedBorderColor, width: 2)
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    day,
                    style: TextStyle(
                      color: selected ? selectedTextColor : textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

Widget _sectionTitle(String text, Color color) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _eventCard(
  IconData icon,
  String title,
  String subtitle,
  Color accent,
  Color background,
  Color textColor, {
  bool circularIcon = false,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Color.fromRGBO(
          accent.r.toInt(),
          accent.g.toInt(),
          accent.b.toInt(),
          0.45,
        ),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: accent,
            shape: circularIcon ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: circularIcon ? null : BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  color: Color.fromRGBO(
                    textColor.r.toInt(),
                    textColor.g.toInt(),
                    textColor.b.toInt(),
                    0.65,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
