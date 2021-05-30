import 'package:covid_rest_api/app/services/api.dart';
import 'package:covid_rest_api/app/services/api_service.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({required this.apiService});
  final APIService apiService;

  String _accessToken = '';

  Future<int> getEndpointData(Endpoint endpoint) async {
    try {
      if (_accessToken == '') {
        _accessToken = await apiService.getAccessToken();
      }
      return await apiService.getEndpointData(
        accessToken: _accessToken,
        endpoint: endpoint,
      );
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await apiService.getEndpointData(
          accessToken: _accessToken,
          endpoint: endpoint,
        );
      }
      rethrow;
    }
  }
}
