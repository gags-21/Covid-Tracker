import 'package:covid_rest_api/app/repositories/data_repository.dart';
import 'package:covid_rest_api/app/repositories/endpoints_data.dart';
import 'package:covid_rest_api/app/services/api.dart';
import 'package:covid_rest_api/app/ui/endpoint_card.dart';
import 'package:covid_rest_api/app/ui/last_updated_status_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late EndpointsData _endpointsData;

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointsData = await dataRepository.getAllEndpointsData();

    setState(() {
      _endpointsData = endpointsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
      lastUpdated: _endpointsData.values[Endpoint.cases]?.date,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            LastUpdatedStatusText(
              text: formatter.lastUpdatedStatusText(),
            ),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData.values[endpoint]?.value,
              ),
          ],
        ),
      ),
    );
  }
}
