import 'package:geolocator/geolocator.dart';

Future<Position> getPosition() async {
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}