import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_form_provider.dart';
import '../services/auth_service.dart';
import '../ui/inputs_decoration.dart';
import '../widgets/auth_background_widget.dart';
import '../widgets/card_container_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
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
                const Text('Registra una cuenta',),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: const RegisterForm(),
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.blue.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(const StadiumBorder())),
                  child: const Text('¿Ya tienes una cuenta?, Autentícate'),
                )
              ])),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
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
              hinText: '********',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_open,
            ),
            onChanged: (value) => LoginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'La contraseña no puede estar vacia';
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
                    final String? errorMessage = await authService.createUser(
                        LoginForm.email, LoginForm.password);
                    if (errorMessage == null) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, 'login');
                    }
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
              child: const Text(
                'Registrar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ]),
      ),
    );
  }
}