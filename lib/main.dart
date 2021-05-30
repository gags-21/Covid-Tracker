import 'package:covid_rest_api/app/repositories/data_repository.dart';
import 'package:covid_rest_api/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/services/api.dart';
import 'app/services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(API.sandbox()),
      ),
      child: MaterialApp(
        title: 'Coronavirus Tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
