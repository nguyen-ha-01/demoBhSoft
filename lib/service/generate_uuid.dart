import 'package:uuid/uuid.dart';

class GenerateUuid {
  final Uuid _generator = const Uuid();
  String generateId() {
    return "LOCAL${_generator.v1()}";
  }
}
