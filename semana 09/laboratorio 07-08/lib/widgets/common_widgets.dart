import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

Widget avatar(String name, Uint8List? photo, {double radius = 24}) =>
    CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFEEE9FF),
      backgroundImage: photo == null ? null : MemoryImage(photo),
      child: photo == null
          ? Text(
              name.trim().isEmpty
                  ? 'A'
                  : name
                        .trim()
                        .split(RegExp(r'\s+'))
                        .take(2)
                        .map((v) => v[0])
                        .join(),
              style: TextStyle(
                color: purple,
                fontSize: radius * .65,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
Widget title(String text, String subtitle) => Align(
  alignment: Alignment.centerLeft,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: ink,
        ),
      ),
      const SizedBox(height: 8),
      Text(subtitle, style: const TextStyle(color: Colors.black54)),
    ],
  ),
);
Widget tag(String text) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
  decoration: BoxDecoration(
    color: const Color(0xFFEEE9FF),
    borderRadius: BorderRadius.circular(30),
  ),
  child: Text(
    text,
    style: const TextStyle(
      color: purple,
      fontSize: 10,
      fontWeight: FontWeight.bold,
      letterSpacing: .6,
    ),
  ),
);
BoxDecoration panelDecoration() => BoxDecoration(
  color: Colors.white.withValues(alpha: .95),
  borderRadius: BorderRadius.circular(24),
  border: Border.all(color: const Color(0xFFEDE9F7)),
  boxShadow: const [
    BoxShadow(color: Color(0x086748DE), blurRadius: 24, offset: Offset(0, 8)),
  ],
);
