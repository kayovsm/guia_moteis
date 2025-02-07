import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/motel_model.dart';

class ApiService {
  final String apiUrl = 'https://www.jsonkeeper.com/b/1IXK';
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<MotelModel>> fetchMotels() async {
    final response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List motelsJson = jsonResponse['data']['moteis'];

      List<MotelModel> result = motelsJson.map((motel) {
        return MotelModel.fromJson(motel);
      }).toList();

      print('LOG * Motels: $result');
      return result;
    } else {
      throw Exception('LOG * Failed to load motels');
    }
  }
}
