import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../utils/dialogos.dart';
import '../widgets/boton_gradiente.dart';
import '../widgets/campo_vidrio.dart';
import '../widgets/entrada_animada.dart';
import '../widgets/glass_card.dart';
import '../widgets/pantalla_base.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _oculto = true;
  bool _cargando = false;

  // Animación de "latido" del logo
  late final AnimationController _pulso = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  late final Animation<double> _escala = Tween<double>(begin: 0.92, end: 1.06)
      .animate(CurvedAnimation(parent: _pulso, curve: Curves.easeInOut));

  Future<void> _ingresar() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    final emailValido = RegExp(r'^[\w.\-]+@[\w\-]+(\.[\w\-]+)*\.[a-zA-Z]{2,}$').hasMatch(email);
    if (!emailValido) {
      await mostrarMensaje(context,
          titulo: 'Email inválido',
          mensaje: 'Ingresa un correo con formato válido, por ejemplo usuario@correo.com.');
      return;
    }
    if (password.length < 6) {
      await mostrarMensaje(context,
          titulo: 'Contraseña muy corta', mensaje: 'La contraseña debe tener al menos 6 caracteres.');
      return;
    }

    // Simula la verificación mostrando el CupertinoActivityIndicator
    setState(() => _cargando = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _cargando = false);
    Navigator.pushReplacementNamed(context, AppRoutes.menu);
  }

  @override
  void dispose() {
    _pulso.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PantallaBase(
      mostrarBarra: false,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Logo con latido y brillo
              ScaleTransition(
                scale: _escala,
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    gradient: AppColors.gradientePrincipal,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(color: Color(0x88F472B6), blurRadius: 36, spreadRadius: 2),
                    ],
                  ),
                  child: const Icon(CupertinoIcons.book_fill, color: AppColors.blanco, size: 46),
                ),
              ),
              const SizedBox(height: 28),

              // Título con texto degradado
              EntradaAnimada(
                indice: 0,
                child: ShaderMask(
                  shaderCallback: (rect) => AppColors.gradienteSecundario.createShader(rect),
                  child: const Text(
                    'Bienvenido',
                    style: TextStyle(color: AppColors.blanco, fontSize: 34, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const EntradaAnimada(
                indice: 1,
                child: Text(
                  'Inicia sesión para gestionar a tus alumnos',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textoSecundario, fontSize: 15),
                ),
              ),
              const SizedBox(height: 30),

              EntradaAnimada(
                indice: 2,
                child: GlassCard(
                  padding: const EdgeInsets.all(20),
                  radio: 24,
                  child: Column(
                    children: [
                      CampoVidrio(
                        controller: emailController,
                        placeholder: 'Correo electrónico',
                        icono: CupertinoIcons.mail,
                        teclado: TextInputType.emailAddress,
                        accion: TextInputAction.next,
                      ),
                      const SizedBox(height: 14),
                      CampoVidrio(
                        controller: passwordController,
                        placeholder: 'Contraseña',
                        icono: CupertinoIcons.lock,
                        oculto: _oculto,
                        accion: TextInputAction.done,
                        sufijo: GestureDetector(
                          onTap: () => setState(() => _oculto = !_oculto),
                          child: Icon(
                            _oculto ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                            color: AppColors.textoSecundario,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      BotonGradiente(
                        texto: 'INGRESAR',
                        icono: CupertinoIcons.arrow_right_circle_fill,
                        cargando: _cargando,
                        onPressed: _ingresar,
                      ),
                      const SizedBox(height: 6),
                      CupertinoButton(
                        onPressed: () => mostrarMensaje(
                          context,
                          titulo: 'Recuperar contraseña',
                          mensaje: 'Te enviaremos un enlace a tu correo para restablecerla.',
                        ),
                        child: const Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(color: AppColors.cian, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
