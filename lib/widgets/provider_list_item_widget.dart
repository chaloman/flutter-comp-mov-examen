import 'package:flutter/material.dart';
import '../models/provider.dart';

class ProviderListItem extends StatelessWidget {
  
  final ProviderList provider;
  const ProviderListItem({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${provider.providerName} ${provider.providerLastName}"),
      subtitle: Text("Estado: ${provider.providerState}"),
    );
  }
}