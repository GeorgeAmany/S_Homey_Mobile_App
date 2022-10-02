import 'package:firebase_database/firebase_database.dart';
import 'package:project/activate_routes/rooms_activation.dart';

class Sockets{
  final String Name;
  final String RoomID;
  final String type;
   int value;
  final String id;

  Sockets({required this.type, required this.RoomID, required this.Name,required this.value,required this.id,});


}