import 'package:video_player/video_player.dart';

class camera{
  final String idToEdit;
  final String RoomID;
  final String Name;
  final String type;
  final String url;
  final int value;
  late VideoPlayerController controller;


  camera({required this.idToEdit, required this.RoomID, required this.Name, required this.type, required this.url, required this.value, required this.controller});
}