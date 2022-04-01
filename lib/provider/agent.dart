import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AgentItem {
  final String id;
  final String agentRefrence;
  final int point;
  final List<String> members;

  AgentItem({
    required this.id,
    required this.agentRefrence,
    required this.point,
    required this.members,
  });
}

class Agent with ChangeNotifier {
  final String token;

  Agent(this.token);

  String _apiUrl = dotenv.env['HORRAY_API_URL'].toString();
  bool _isAgent = false;
  AgentItem _loadedAgent = new AgentItem(
    id: '',
    agentRefrence: '',
    point: 0,
    members: [],
  );

  // getter function
  bool get isAgent {
    return _isAgent;
  }

  AgentItem get loadedAgent {
    return _loadedAgent;
  }
  // getter function

  Future<void> getAgent(String ref) async {
    try {
      final url = _apiUrl + 'agents/$ref';
      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      // print('Response body: ${response.body}');
      var data = json.decode(response.body);
      if (data == null) return;
      _loadedAgent = new AgentItem(
        id: data['id'],
        agentRefrence: data['agentRefrence'],
        point: data['point'],
        members: [],
      );
      // print(data['members'][0]);
      for (var i = 0; i < data['members'].length; i++) {
        _loadedAgent.members.insert(i, data['members'][i]);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> updateAgent(
    String agentId,
    String ref,
  ) async {
    try {
      final url = _apiUrl + 'agents/$agentId';
      //debugPrint(url);
      var response = await http.patch(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
        body: {'memberRefrence': ref},
      );
      //debugPrint({'memberRefrence': ref});
      print('Response body: ${response.body}');
      var data = json.decode(response.body);
      // if (data == null) throw new Error();
      if (data['statusCode'] == 401) {
        return;
      }
      _loadedAgent = new AgentItem(
        id: data['id'],
        agentRefrence: data['agentRefrence'],
        point: data['point'],
        members: [],
      );
      // print(data['members'][0]);
      for (var i = 0; i < data['members'].length; i++) {
        _loadedAgent.members.insert(i, data['members'][i]);
      }

      this.getAgent(loadedAgent.agentRefrence);

      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }
}
