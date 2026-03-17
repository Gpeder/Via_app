import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/utils/image.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _loading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      CoreToast.show(
        context: context,
        title: 'Erro de login',
        description: 'Por favor, preencha todos os campos.',
        variant: CoreToastVariant.destructive,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    CoreToast.show(
      context: context,
      title: 'Login bem-sucedido!',
      description: 'Você entrou na sua conta com sucesso.',
      variant: CoreToastVariant.success,
      duration: const Duration(seconds: 3),
    );
    setState(() {
      _loading = true;
    });

    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _loading = false;
    });

    Navigator.pushNamed(context, '/root');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(textTheme),
              _buildForm(),
              _buildFooter(textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildForm() {
    return Column(
      children: [
        CoreInput(
          controller: emailController,
          onChanged: (value) {},
          keyboardType: TextInputType.emailAddress,
          size: CoreInputSize.lg,
          hint: 'Email',
          variant: CoreInputVariant.outlined,
          label: 'Email',
          prefixIcon: Icons.email,
        ),
        const SizedBox(height: 20),

        CoreInput(
          controller: passwordController,
          onChanged: (value) {},
          keyboardType: TextInputType.visiblePassword,
          size: CoreInputSize.lg,
          obscureText: !_isPasswordVisible,
          hint: 'Senha',
          variant: CoreInputVariant.outlined,
          label: 'Senha',
          suffixIcon: _isPasswordVisible
              ? Icons.visibility
              : Icons.visibility_off,
          prefixIcon: Icons.lock,
          onSuffixTap: _togglePasswordVisibility,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Column _buildHeader(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.circular(12),
            shape: BoxShape.rectangle,
          ),
          child: Image(image: AssetImage(AppImage.logo)),
        ),
        const SizedBox(height: 20),

        Text('Bem vindo de volta!👋', style: textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          'Entre na sua conta para continuar o voluntariado!',
          style: textTheme.bodyLarge?.copyWith(color: AppColors.gray200),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Column _buildFooter(TextTheme textTheme) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                'Esqueceu sua senha?',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        //*== Botão de login ==*//
        CoreButton(
          label: 'Entrar',
          fullWidth: true,
          size: CoreButtonSize.lg,
          onPressed: _handleLogin,
          isLoading: _loading,
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(child: Divider(thickness: 0.5, color: AppColors.gray100)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'ou',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.gray200),
              ),
            ),
            Expanded(child: Divider(thickness: 0.5, color: AppColors.gray100)),
          ],
        ),
        const SizedBox(height: 20),

        //*== Botão de login com Google ==*//
        CoreButton(
          label: 'Continuar com google',
          icon: LucideIcons.glassWater,
          variant: CoreButtonVariant.outline,
          fullWidth: true,
          size: CoreButtonSize.lg,
          onPressed: () {},
        ),
        const SizedBox(height: 20),

        //*== Link para criar nova conta ==*//
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text.rich(
                TextSpan(
                  text: 'Não tem uma conta? ',
                  style: textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Criar conta',
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
