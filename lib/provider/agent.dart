import 'dart:ffi';

import 'package:flutter/material.dart';

class Agent with ChangeNotifier {
  final String id;
  final String agentRefrence;
  final int point;
  final List<String> members;

  Agent({
    required this.id,
    required this.agentRefrence,
    required this.point,
    required this.members,
  });
}
