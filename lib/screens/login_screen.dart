import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_form_provider.dart';
import '../services/auth_service.dart';
import '../ui/inputs_decoration.dart';
import '../widgets/auth_background_widget.dart';
import '../widgets/card_container_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              CardContainer(
                  child: Column(children: [
                const SizedBox(height: 10),
                Text('Login'),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: const LoginForm(),
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, 'addUser'),
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.1)
                      ),
                      shape: MaterialStateProperty.all(const StadiumBorder())),
                  child: const Text('¿No tienes cuenta?, Créarla aquí'),
                )
              ])),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: LoginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.text,
          decoration: InputColors.authInputDecoration(
            hinText: 'Ingrese email',
            labelText: 'Email',
            prefixIcon: Icons.people,
          ),
          onChanged: (value) => LoginForm.email = value,
          validator: (value) {
            return (value != null && value.length >= 4)
                ? null
                : 'El usuario no puede estar vacio';
          },
        ),
        const SizedBox(height: 30),
        TextFormField(
          autocorrect: false,
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: InputColors.authInputDecoration(
            hinText: '*******',
            labelText: 'Contraseña',
            prefixIcon: Icons.lock_outline,
          ),
          onChanged: (value) => LoginForm.password = value,
          validator: (value) {
            return (value != null && value.length >= 4)
                ? null
                : 'La contraseña no puede estar vacio';
          },
        ),
        const SizedBox(height: 30),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          disabledColor: Colors.grey,
          color: Colors.orange,
          elevation: 0,
          onPressed: LoginForm.isLoading
              ? null
              : () async {
                  FocusScope.of(context).unfocus();
                  final authService =
                      Provider.of<AuthService>(context, listen: false);
                  if (!LoginForm.isValidForm()) return;
                  LoginForm.isLoading = true;
                  final String? errorMessage = await authService.login(
                      LoginForm.email, LoginForm.password);
                  if (errorMessage == null) {
                    Navigator.pushNamedAndRemoveUntil(context, 'home', (_) => false);
                  }
                  LoginForm.isLoading = false;
                },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            child: const Text(
              'Acceder',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ]),
    );
  }
}