import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as prov;
import 'package:provider/provider.dart';
import '../providers/provider_form_provider.dart';
import '../services/provider_service.dart';
import '../ui/inputs_decoration.dart';

class CreateProviderScreen extends StatelessWidget {
  const CreateProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerService = prov.Provider.of<ProviderService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProviderFormProvider(providerService.selectedProvider!),
        child: _ProviderScreenBody(
          providerService: providerService,
        ));
  }
}

class _ProviderScreenBody extends StatelessWidget {
  const _ProviderScreenBody({
    Key? key,
    required this.providerService,
  }) : super(key: key);

  final ProviderService providerService;
  @override
  Widget build(BuildContext context) {
    final providerForm = Provider.of<ProviderFormProvider>(context);
    final isUpdating = providerForm.provider.providerId == 0;

    List<Widget> actionsButtons = [
      FloatingActionButton(
        onPressed: () async {
          if (!providerForm.isValidForm()) return;
          await providerService.deleteProvider(providerForm.provider, context);
        },
        heroTag: null,
        tooltip: "Eliminar",
        child: const Icon(Icons.remove_circle),
      ),
      const SizedBox(width: 20)
    ];
    if (isUpdating) {
      actionsButtons.clear();
    }

    actionsButtons.add(FloatingActionButton(
        onPressed: () async {
          if (!providerForm.isValidForm()) return;
          await providerService.editOrCreateProvider(providerForm.provider);
        },
        heroTag: null,
        tooltip: "Guardar cambios",
        child: const Icon(Icons.check)));

    return Scaffold(
      appBar: AppBar(
        title: Text(!isUpdating ? "Editar Proveedor" : 'Crear proveedor'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          _ProviderForm(),
        ]),
      ),
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end, children: actionsButtons),
    );
  }
}

class _ProviderForm extends StatefulWidget {
  @override
  _ProviderFormState createState() => _ProviderFormState();
}

class _ProviderFormState extends State<_ProviderForm> {
  bool sv = false;

  @override
  Widget build(BuildContext context) {
    final providerForm = Provider.of<ProviderFormProvider>(context);
    final provider = providerForm.provider;
    setState(() {
      sv = provider.providerState == "Activa";
    });
    return Form(
      key: providerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            initialValue: provider.providerName,
            onChanged: (val) => provider.providerName = val,
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Nombre Requerido' : null,
            decoration: InputColors.authInputDecoration(
              hinText: 'Nombre',
              labelText: 'Nombre',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: provider.providerLastName,
            onChanged: (value) => provider.providerLastName = value,
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Apellido Requerido' : null,
            decoration: InputColors.authInputDecoration(
              hinText: 'Apellido',
              labelText: 'Apellido',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            initialValue: provider.providerEmail,
            onChanged: (value) => provider.providerEmail = value,
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Email Requerido' : null,
            decoration: InputColors.authInputDecoration(
              hinText: 'Email',
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 20),
          SwitchListTile.adaptive(
            value: sv,
            onChanged: (v) {
              provider.providerState = v ? "Activa" : "bloqueada";
              setState(() {
                sv = v;
              });
            },
            activeColor: Colors.orange,
            title: const Text('Disponible'),
          )
        ],
      ),
    );
  }
}