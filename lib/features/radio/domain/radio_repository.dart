import '../data/radio_service.dart';

class RadioRepository {
  final RadioService _service;

  RadioRepository({RadioService? service})
      : _service = service ?? RadioService();

  Future<String> getStreamUrl() => _service.getStreamUrl();

  Future<String> getStationName() => _service.getStationName();

  Future<String> getStationDescription() => _service.getStationDescription();
}
