import 'package:flutter/material.dart';
import 'package:projeto_as/services/firebase/auth/firebase_service_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

enum PasswordStrength { weak, medium, strong }

PasswordStrength _getPasswordStrength(String password) {
  if (password.length < 6) return PasswordStrength.weak;
  final hasLetters = RegExp(r'[A-Za-z]').hasMatch(password);
  final hasNumbers = RegExp(r'\d').hasMatch(password);
  final hasSpecials = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);

  if (password.length >= 8 && hasLetters && hasNumbers && hasSpecials) {
    return PasswordStrength.strong;
  } else if (hasLetters && hasNumbers) {
    return PasswordStrength.medium;
  }
  return PasswordStrength.weak;
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  PasswordStrength _passwordStrength = PasswordStrength.weak;
  String? passwordError;
  String? confirmError;

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(_validatePasswords);
    _confirmController.addListener(_validatePasswords);
  }

  void _validatePasswords() {
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    setState(() {
      _passwordStrength = _getPasswordStrength(password);

      if (password.length < 6) {
        passwordError = 'A senha deve ter pelo menos 6 caracteres.';
      } else {
        passwordError = null;
      }

      if (confirm.isNotEmpty && confirm != password) {
        confirmError = 'As senhas não coincidem.';
      } else {
        confirmError = null;
      }
    });
  }

  Future<void> _handleSignUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (password.length < 6 || password != confirm) return;

    final user = await _auth.signUp(email, password);

    if (!mounted) return;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao cadastrar usuário')),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    filled: true,
                    border: const OutlineInputBorder(),
                    errorText: passwordError,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmController,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    filled: true,
                    border: const OutlineInputBorder(),
                    errorText: confirmError,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                _buildPasswordStrengthBar(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthBar() {
    Color color;
    String label;

    switch (_passwordStrength) {
      case PasswordStrength.weak:
        color = Colors.red;
        label = 'Fraca';
        break;
      case PasswordStrength.medium:
        color = Colors.orange;
        label = 'Média';
        break;
      case PasswordStrength.strong:
        color = Colors.green;
        label = 'Forte';
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: (_passwordStrength.index + 1) / 3,
          color: color,
          backgroundColor: Colors.grey[300],
          minHeight: 6,
        ),
        const SizedBox(height: 4),
        Text(
          'Força da senha: $label',
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
