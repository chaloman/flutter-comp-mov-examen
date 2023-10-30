import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/provider.dart';

class ProviderService extends ChangeNotifier {

  final String _baseUrl = '143.198.118.203:8000';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<ProviderList> providers = [];
  ProviderList? selectedProvider;
  bool isLoading = true;
  bool isEditCreate = true;
  
  ProviderService() {
    try
    {
      loadProviders();
    }
    catch (e) {
      print("Error: $e");
    }
  }

  Future loadProviders() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_list_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.get(url, headers: {'authorization': basicAuth });
    final providersMap = Provider.fromJson(response.body);
    providers = providersMap.list;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProvider(ProviderList provider) async {
    isEditCreate = true;
    notifyListeners();
    if (provider.providerId == 0) {
      await createProvider(provider);
    } else {
      await updateProvider(provider);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateProvider(ProviderList provider) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_edit_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.post(url, body: provider.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final index = providers.indexWhere((element) => element.providerId == provider.providerId);
    providers[index] = provider;
    await loadProviders();
    return '';
  }

  Future createProvider(ProviderList provider) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_add_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.post(url, body: provider.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    await loadProviders();
    return '';
  }

  Future deleteProvider(ProviderList provider, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_del_rest/',
    );
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    final response = await http.post(url, body: provider.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    providers.clear();
    await loadProviders();
    return '';
  }
}