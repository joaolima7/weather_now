import 'package:flutter/material.dart';

const urlBase = 'https://api.openweathermap.org/data/2.5';
const apiKey = 'a9f82e04e675cd1a5def62dbd2021d3c';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

const List<String> savedCities = [
  'Fortaleza',
  'São Paulo',
  'Rio de Janeiro',
  'Curitiba',
];
